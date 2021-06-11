//
//  PostPictureDetailViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit
import WebKit

class PostPictureDetailViewController: UIViewController, Storyboarded, UIAdaptivePresentationControllerDelegate {

    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var forwardButton: UIBarButtonItem!
    @IBOutlet private weak var reloadButton: UIBarButtonItem!

    static var storyboardName: String = "Posts"

    private var estimatedProgressObserver: NSKeyValueObservation!
    private var webViewNavigationDelegate: AuthPermissionWebViewNavigationDelegate!

    var viewModel: PostPictureDetailViewModelProtocol?
    weak var coordinator: PostPictureDetailCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        loadURL()
    }

    // MARK: - Private

    private func setupUI() {
        setupNavigationBar()
        setupWebView()
    }

    private func setupNavigationBar() {
        navigationController?.presentationController?.delegate = self

        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                                 target: self, action: #selector(closeBarButtonAction))
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }

    private func setupWebView() {
        let didFinishNavigation = { [unowned self] in
            self.checkNavigationButtonsState()
        }

        let didUpdateProgress: (WKWebView, Any) -> Void = { [unowned self] webView, _ in
            self.updateProgressView(with: webView.estimatedProgress)
        }

        webViewNavigationDelegate = AuthPermissionWebViewNavigation(didFinishNavigation: didFinishNavigation)
        webView.navigationDelegate = webViewNavigationDelegate
        webView.allowsBackForwardNavigationGestures = true
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new],
                                                    changeHandler: didUpdateProgress)
    }

    private func loadURL() {
        guard let urlRequest = viewModel?.pictureURLRequest else { return }
        webView.load(urlRequest)
    }

    private func checkNavigationButtonsState() {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }

    private func updateProgressView(with value: Double) {
        progressView.progress = Float(value)

        if value == 1.0 {
            progressView.fadeOut(0.5)
        } else {
            progressView.fadeIn(0.0)
        }
    }

    // MARK: - Selectors

    @objc private func closeBarButtonAction() {
        coordinator?.dismiss(completion: nil)
    }

    // MARK: - Actions

    @IBAction private func backButtonAction(_ sender: Any) {
        webView.goBack()
    }

    @IBAction private func forwardButtonAction(_ sender: Any) {
        webView.goForward()
    }

    @IBAction private func reloadButtonAction(_ sender: Any) {
        loadURL()
    }

}
