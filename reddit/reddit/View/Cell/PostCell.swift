//
//  PostCell.swift
//  reddit
//
//  Created by Juan Martin Contreras on 11/01/2021.
//

import UIKit

class PostCell: UITableViewCell {

    static let reuseIdentifier = "postCell"

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
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
    }
}
