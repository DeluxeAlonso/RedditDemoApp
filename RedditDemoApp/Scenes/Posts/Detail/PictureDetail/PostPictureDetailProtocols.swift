//
//  PostPictureDetailProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import Foundation
import WebKit

protocol PostPictureDetailViewModelProtocol {

    var pictureURLRequest: URLRequest? { get }

}

protocol PostPictureDetailCoordinatorProtocol: Coordinator {

    func dismiss(completion: (() -> Void)?)

}

protocol PostPictureDetailWebViewNavigationDelegate: WKNavigationDelegate {

    var didFinishNavigation: () -> Void { get set }

}
