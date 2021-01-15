//
//  PostFooter.swift
//  reddit
//
//  Created by Juan Martin Contreras on 14/01/2021.
//

import UIKit

class PostFooterCell: UIView {

    static let reuseIdentifier = "postFooterCell"
    static let nibName = "PostFooterCell"

    @IBOutlet var contentView: UIView!

    var onDismissAll: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed(PostFooterCell.nibName, owner: self, options: nil)
        contentView.fixInView(self)
    }

    @IBAction func onDismissAllTap(_ sender: Any) {
        onDismissAll?()
    }

}
