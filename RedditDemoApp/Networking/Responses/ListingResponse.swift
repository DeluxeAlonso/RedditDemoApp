//
//  ListingDataResponse.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

struct ListingResponse<T: Decodable>: Decodable {

    let data: ListingChildrenResponse<T>

}

struct ListingChildrenResponse<T: Decodable>: Decodable {

    let children: [ListingDataResponse<T>]
    
}

struct ListingDataResponse<T: Decodable>: Decodable {

    let kind: String
    let data: T

}
