//
//  PostCell.swift
//  AlamofireWithSwiftConcurrency
//
//  Created by Robert Ryan on 12/28/23.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        bodyLabel.text = nil
    }

    func configure(for post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
