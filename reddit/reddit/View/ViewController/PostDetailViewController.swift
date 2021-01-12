//
//  PostDetailViewController.swift
//  reddit
//
//  Created by Juan Martin Contreras on 12/01/2021.
//

import UIKit

protocol PostSelectionDelegate: class {
    func didSelect(post: Post)
}

class PostDetailViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var post: Post? {
        didSet {
            loadPost()
        }
    }

    private func loadPost() {
        authorLabel.text = post?.author
        titleLabel.text = post?.title
        if let thumbnail = post?.thumbnail, let thumbnailUrl = URL(string: thumbnail) {
            thumbnailImageView.load(url: thumbnailUrl)
        }
    }

}

extension PostDetailViewController: PostSelectionDelegate {

    func didSelect(post: Post) {
        self.post = post
    }

}
