//
//  ViewController.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import UIKit

class PostsViewController: UITableViewController {

    private let postsViewModel = PostsViewModel()

    var delegate: PostSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        loadPosts()
    }

    private func loadPosts() {
        postsViewModel.loadTopPosts()
    }

    private func bindViewModel() {
        postsViewModel.onError = { error in
            print(error)
        }
        postsViewModel.onPostsLoaded = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell
        postCell?.post = postsViewModel.posts?[indexPath.row]
        return postCell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = postsViewModel.posts?[indexPath.row] else {
            return
        }
        delegate?.didSelect(post: post)
    }

}
