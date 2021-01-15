//
//  ViewController.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import UIKit

class PostsViewController: UITableViewController {

    private let footerHeight: CGFloat = 40
    private let showDetailSegueIdentifier = "showDetail"

    private let postsViewModel = PostsViewModel()
    
    var delegate: PostSelectionDelegate?
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        bindViewModel()
        loadPosts()
    }

    private func initTableView() {
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = .black
        self.refreshControl?.addTarget(self, action: #selector(loadPosts), for: UIControl.Event.valueChanged)
    }
    
    @objc private func loadPosts() {
        refreshControl?.beginRefreshing()
        postsViewModel.loadTopPosts()
    }
    
    private func bindViewModel() {
        postsViewModel.onError = { error in
            print(error)
        }
        postsViewModel.onPostsLoaded = {
            DispatchQueue.main.async {
                self.onPostsLoaded()
            }
        }
    }
    
    private func onPostsLoaded() {
        if selectedPost == nil, let firstPost = postsViewModel.posts?.first {
            selectedPost = firstPost
            delegate?.didSelect(post: firstPost)
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    private func dismiss(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let post = postsViewModel.posts?[indexPath.row] else {
            return
        }
        postsViewModel.remove(post: post)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func dismissAll() {
        postsViewModel.removeAllPosts()
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let post = selectedPost else {
            return
        }
        if segue.identifier == showDetailSegueIdentifier,
           let detailViewController = segue.destination as? PostDetailViewController {
            detailViewController.post = post
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == showDetailSegueIdentifier {
            return delegate == nil
        } else {
            return true
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }

        postCell.post = postsViewModel.posts?[indexPath.row]
        postCell.onDismiss = {
            self.dismiss(cell: postCell)
        }
        return postCell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerHeight)
        let footerView = PostFooterCell(frame: frame)
        footerView.onDismissAll = {
            self.dismissAll()
        }
        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = postsViewModel.posts?[indexPath.row] else {
            return
        }
        selectedPost = post
        delegate?.didSelect(post: post)
    }
    
}
