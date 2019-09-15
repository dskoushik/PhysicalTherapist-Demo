//
//  SearchResultsTableViewCell.swift
//  PTSearch
//
//  Created by Divya Sivakumar on 9/14/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

     @IBOutlet weak var BusinessdescLbl: UILabel!
     @IBOutlet weak var RatingdescLbl: UILabel!
     @IBOutlet weak var ReviewdescLbl: UILabel!
     @IBOutlet weak var AddressdescLbl: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
