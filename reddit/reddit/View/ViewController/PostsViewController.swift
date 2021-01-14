//
//  ViewController.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import UIKit

class PostsViewController: UITableViewController {

    private let showDetailSegueIdentifier = "showDetail"

    private let postsViewModel = PostsViewModel()
    
    var delegate: PostSelectionDelegate?
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(loadPosts), for: UIControl.Event.valueChanged)
        
        bindViewModel()
        loadPosts()
    }
    
    @objc private func loadPosts() {
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
        let postCell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell
        postCell?.post = postsViewModel.posts?[indexPath.row]
        return postCell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = postsViewModel.posts?[indexPath.row] else {
            return
        }
        selectedPost = post
        delegate?.didSelect(post: post)
    }
    
}
