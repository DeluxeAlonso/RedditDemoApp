//
//  AuthPermissionWebViewNavigationDelegate.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation
import WebKit

protocol AuthPermissionViewModelProtocol {

    var authPermissionURLRequest: URLRequest? { get }

}

protocol AuthPermissionCoordinatorProtocol: Coordinator {

    func dismiss(completion: (() -> Void)?)

}

protocol AuthPermissionWebViewNavigationDelegate: WKNavigationDelegate {

    var didFinishNavigation: () -> Void { get set }

}
