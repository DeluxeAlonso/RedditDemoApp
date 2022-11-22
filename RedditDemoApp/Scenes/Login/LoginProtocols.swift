//
//  LoginProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

protocol LoginViewModelProtocol {

    var startLoading: Bindable_Deprecated<Bool> { get }
    var didReceiveError: Bindable_Deprecated<Error?> { get }

    var loginDidFinish: (() -> Void)? { get set }

    /**
     * Retrieves the access token given an access code.
     * - Parameters:
     *      - code: access code to be used.
     */
    func getAccessToken(with code: String)

    /**
     * Generates the auth permission url to be used for login access.
     * - Returns: The authentication permission url.
     */
    func buildAuthPermissionURL() -> URL?

}

protocol LoginInteractorProtocol {

    /**
     * Fetches the access token given an access code.
     * - Parameters:
     *      - credential: base64 encoded credential for basic authentication.
     *      - code: access code to be used.
     *      - completion: called on completion containing the fetched access token.
     */
    func getAccessToken(credential: String,
                        code: String,
                        completion: @escaping (Result<String, Error>) -> Void)

}

protocol LoginCoordinatorProtocol: AnyObject {

    func showAuthPermission(for authPermissionURL: URL?,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate)

    func showMainScreen(from viewController: UIViewController)

}
