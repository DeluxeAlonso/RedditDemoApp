//
//  LoginViewModel.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {

    private let interactor: LoginInteractorProtocol

    private(set) var startLoading: Bindable_Deprecated<Bool> = Bindable_Deprecated(false)
    private(set) var didReceiveError: Bindable_Deprecated<Error?> = Bindable_Deprecated(nil)

    var loginDidFinish: (() -> Void)?

    // MARK: - Initializers

    init(interactor: LoginInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - LoginViewModelProtocol

    func buildAuthPermissionURL() -> URL? {
        let clientId = AppConstants.clientId
        let redirectUri = AppConstants.authRedirectUri
        let urlString = String(format: AppConstants.authPermissionURLFormat, clientId, redirectUri)

        return URL(string: urlString)
    }

    func getAccessToken(with code: String) {
        startLoading.value = true
        let credential = buildAuthCredential()
        Task {
            do {
                // TODO: - Move authentication manager to login view model
                let response = try await interactor.getAccessToken(credential: credential, code: code)
                self.loginDidFinish?()
            } catch {
                self.didReceiveError.value = error
            }
        }
    }

    // MARK: - Private

    private func buildAuthCredential() -> String {
        let clientId = AppConstants.clientId
        let credential = clientId + ":"

        return credential.toBase64()
    }

}
