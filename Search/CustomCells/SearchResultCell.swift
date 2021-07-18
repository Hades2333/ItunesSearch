//
//  SearchResultCell.swift
//  Search
//
//  Created by Hellizar on 18.07.21.
//

import UIKit

class SearchResultCell: UITableViewCell {

    // MARK: IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255,
                                               green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

}
