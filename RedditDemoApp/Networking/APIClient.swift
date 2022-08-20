//
//  APIClient.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol APIClient {

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)

    func fetch<T: Decodable>(with request: URLRequest, decodingType: T.Type) async throws -> T

}

extension APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            decodingType: T.Type,
                                            completionHandler completion: JSONTaskCompletionHandler?) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion?(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion?(genericModel, nil)
                    } catch {
                        print(error.localizedDescription)
                        completion?(nil, .requestFailed)
                    }
                } else {
                    completion?(nil, .invalidData)
                }
            } else {
                completion?(nil, APIError(response: httpResponse))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.requestFailed))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.requestFailed))
                }
            }
        }
        task.resume()
    }

    // Async await

    func fetch<T: Decodable>(with request: URLRequest, decodingType: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            throw APIError(response: httpResponse)
        }
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(decodingType, from: data)
            return genericModel
        } catch {
            throw APIError.requestFailed
        }
    }

}
