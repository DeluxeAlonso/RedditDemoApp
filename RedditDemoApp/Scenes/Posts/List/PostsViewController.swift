//
//  PostsViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class PostsViewController: UIViewController, Storyboarded, Alertable {

    @IBOutlet weak var dismissBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!
    
    static var storyboardName: String = "Posts"

    private var prefetchDataSource: TableViewDataSourcePrefetching!

    var viewModel: PostsViewModelProtocol?
    weak var coordinator: PostsCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()

        viewModel?.getTopPosts(shouldRefresh: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // We deselect the current selected row on view will appear
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    // MARK: - Private

    private func setupUI() {
        title = LocalizedStrings.topPostsTItle()
        dismissBarButtonItem.title = LocalizedStrings.dismiss()
        setupTableView()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        tableView.registerNib(cellType: PostCell.self)

        setupRefreshControl()

        configureTableViewPrefetchDataSource()
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func configureTableViewPrefetchDataSource() {
        guard let viewModel = viewModel else { return }
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.numberOfPosts(),
                                                            needsPrefetch: viewModel.needsPrefetch,
                                                            prefetchHandler: { [weak self] in
                                                                self?.viewModel?.getTopPosts(shouldRefresh: false)
                                                            })
        tableView.prefetchDataSource = prefetchDataSource
    }

    private func configureView(with state: PostsViewState) {
        dismissBarButtonItem.isEnabled = state.hasAvailableEntities
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: LocalizedStrings.emptyPostsTitle())
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial, .paging:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.localizedDescription)
        }
    }

    // MARK: - Reactive behavior

    private func setupBindings() {
        viewModel?.viewState.bindAndFire({ [weak self] state in
            guard let self = self else { return }
            self.configureView(with: state)
            self.configureTableViewPrefetchDataSource()
            self.tableView.reloadSections([.zero], with: .fade)
            self.tableView.refreshControl?.endRefreshing()
        }, on: .main)
        viewModel?.didUpdatePost.bind({ [weak self] index in
            guard let index = index else { return }
            let indexPath = IndexPath(row: index, section: 0)
            self?.tableView.reloadRows(at: [indexPath], with: .none)
            self?.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }, on: .main)
        viewModel?.didRemovePost.bind({ [weak self] index in
            guard let index = index else { return }
            let indexPath = IndexPath(row: index, section: 0)
            self?.tableView.deleteRows(at: [indexPath], with: .left)
        }, on: .main)
    }

    // MARK: - Actions

    @IBAction private func dismissBarButtonItemTapped(_ sender: UIBarButtonItem) {
        viewModel?.hideAllPosts()
    }

    // MARK: - Selectors

    @objc private func refreshControlAction() {
        viewModel?.getTopPosts(shouldRefresh: true)
    }

    @objc private func imageDownloadError(_ image: UIImage,
                                          didFinishSavingWithError error: Error?,
                                          contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlert(message: error.localizedDescription)
        } else {
            showAlert(message: LocalizedStrings.savePictureSuccess())
        }
    }

}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPosts() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { fatalError() }
        let cell = tableView.dequeueReusableCell(with: PostCell.self, for: indexPath)
        cell.viewModel = viewModel.buildPostCellModel(at: indexPath.row)
        cell.delegate = self

        return cell
    }

}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.markAsRead(at: indexPath.row)
        coordinator?.showPostDetail(viewModel.post(at: indexPath.row))
    }

}

// MARK: - PostCellDelegate

extension PostsViewController: PostCellDelegate {

    func postCell(_ postCell: PostCell, didTapDownloadButton image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageDownloadError), nil)
    }

    func postCell(_ postCell: PostCell, didTapThumbnail url: URL) {
        coordinator?.showPictureDetail(for: url)
    }

    func postCell(_ postCell: PostCell, didTapDismissButton tapped: Bool) {
        guard let indexPath = tableView.indexPath(for: postCell) else {
            return
        }
        viewModel?.hidePost(at: indexPath.row)
    }

}
