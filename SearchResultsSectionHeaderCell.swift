//
//  SearchResultsSectionHeaderCell.swift
//  PTSearch
//
//  Created by Divya Sivakumar on 9/15/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//

import UIKit

class SearchResultsSectionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var TotalPTCountLbl: UILabel!
    @IBOutlet weak var PTCountWRatingLbl: UILabel!
    @IBOutlet weak var AvgPTRatingLbl: UILabel!
    @IBOutlet weak var TotalReviewsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
