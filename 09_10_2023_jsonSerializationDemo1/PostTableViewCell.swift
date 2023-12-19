//
//  PostTableViewCell.swift
//  09_10_2023_jsonSerializationDemo1
//
//  Created by Vishal Jagtap on 19/12/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
