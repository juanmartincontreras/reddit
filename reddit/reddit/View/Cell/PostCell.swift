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
    @IBOutlet weak var commentsCountLabel: UILabel!

    var post: Post? {
        didSet {
            loadPost()
        }
    }

    private func loadPost() {
        authorLabel.text = post?.author

        if let timestamp = post?.createdUTC {
            let date = Date(timeIntervalSince1970: timestamp)
            createdAtLabel.text = date.timeAgoDisplay()
        } else {
            createdAtLabel.text = nil
        }


        titleLabel.text = post?.title
        if let thumbnail = post?.thumbnail, let thumbnailUrl = URL(string: thumbnail) {
            thumbnailImageView.load(url: thumbnailUrl)
        }

        let commentsCount = post?.numComments ?? 0
        commentsCountLabel.text = "\(commentsCount) Comments"
    }

    override func prepareForReuse() {
        authorLabel.text = nil
        titleLabel.text = nil
        thumbnailImageView.image = nil
        createdAtLabel.text = nil
        commentsCountLabel.text = "0 Comments"
    }

    @IBAction func onDismissPostTap(_ sender: Any) {
    }

}
