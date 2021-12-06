//
//  TableViewCell.swift
//  meMe
//
//  Created by Jack McCabe on 12/4/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    var memeImage:UIImage!
    var bottomLabel:String!
    var topLabel:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
