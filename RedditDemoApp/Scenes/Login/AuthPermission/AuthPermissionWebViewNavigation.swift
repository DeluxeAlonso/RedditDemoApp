//
//  AuthPermissionWebViewNavigation.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation
import WebKit

class AuthPermissionWebViewNavigation: NSObject, AuthPermissionWebViewNavigationDelegate {

    var didFinishNavigation: () -> Void

    // MARK: - Initializers

    init(didFinishNavigation: @escaping () -> Void) {
        self.didFinishNavigation = didFinishNavigation
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishNavigation()
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        // if the request is a non-http(s) schema, then have the UIApplication handle
        // opening the request
        if let url = navigationAction.request.url,
            !url.absoluteString.hasPrefix("http://"),
            !url.absoluteString.hasPrefix("https://"),
            UIApplication.shared.canOpenURL(url) {

            // have UIApplication handle the url (sms:, tel:, mailto:, ...)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)

            // cancel the request (handled by UIApplication)
            decisionHandler(.cancel)
        }
        else {
            // allow the request
            decisionHandler(.allow)
        }
    }

}
