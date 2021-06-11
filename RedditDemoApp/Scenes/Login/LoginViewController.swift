//
//  LoginViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded, Alertable {

    @IBOutlet private weak var loginButton: ShrinkingButton!

    static var storyboardName: String = "Login"

    var viewModel: LoginViewModelProtocol?
    weak var coordinator: LoginCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loginDidFinish = { [weak self] in
            guard let self = self else { return }
            self.coordinator?.showMainScreen(from: self)
        }
    }

    // MARK: - Private

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        viewModel.startLoading.bind { [weak self] startLoading in
            guard let self = self else { return }
            if startLoading {
                self.loginButton.startAnimation()
            } else {
                self.loginButton.stopAnimation()
            }
        }
        viewModel.didReceiveError.bind { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.showAlert(message: error.localizedDescription)
        }
    }

    // MARK: - Actions

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let url = viewModel?.buildAuthPermissionURL() else { return }
        coordinator?.showAuthPermission(for: url, and: self)
    }

}

extension LoginViewController: AuthPermissionViewControllerDelegate {

    func authPermissionViewController(_ authPermissionViewController: AuthPermissionViewController,
                                      didReceiveAuthorization code: String?) {
        guard let code = code else { return }
        viewModel?.getAccessToken(with: code)
    }

}
