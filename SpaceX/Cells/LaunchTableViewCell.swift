//
//  LaunchTableViewCell.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblLaunchNumber: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
