//
//  LoginProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

protocol LoginViewModelProtocol {

    var startLoading: Bindable<Bool> { get }
    var didReceiveError: Bindable<Error?> { get }

    var loginDidFinish: (() -> Void)? { get set }

    func getAccessToken(with code: String)
    func buildAuthPermissionURL() -> URL?

}

protocol LoginInteractorProtocol {

    func getAccessToken(credential: String,
                        code: String,
                        completion: @escaping (Result<String, Error>) -> Void)

}

protocol LoginCoordinatorProtocol: AnyObject {

    func showAuthPermission(for authPermissionURL: URL?,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate)

    func showMainScreen(from viewController: UIViewController)

}
