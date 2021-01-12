//
//  ViewController.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import UIKit

class ViewController: UIViewController {

    private let postsViewModel = PostsViewModel()

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
        postsViewModel.onPostsLoaded = { posts in
            print(posts)
        }
    }

}

