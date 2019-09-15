//
//  PTSearchViewController.swift
//  PTSearch
//
//  Created by Divya Sivakumar on 9/14/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//

import UIKit


class PTSearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
   
    

    weak var appDelegate : PTAppDelegate! = (UIApplication.shared.delegate as! PTAppDelegate)
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var tblResults: UITableView!
    
    var businesses: [Business]!
    var sortedBusiness:[[String:AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMessage!.isHidden = true
        tblResults!.isHidden = true
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.businesses != nil)
        {
            return self.businesses!.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(businesses != nil)
        {
            return 105.0
        }
        return 0
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier="SearchResultsTableViewCell"
        var cell: SearchResultsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchResultsTableViewCell
        if( cell == nil) {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchResultsTableViewCell
        }
        let business: Business!  = self.businesses[indexPath.row]
        if(!(business.ratingStarCount?.isEqual(to: 0))!)
        {
         cell?.AddressdescLbl.text = business.address
         cell?.BusinessdescLbl.text = business.name
         cell?.RatingdescLbl.text = business.ratingStarCount?.stringValue
         cell?.ReviewdescLbl.text = business.reviewCount?.stringValue
        }
        tableView.rowHeight = (cell?.frame.height)!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier="SearchResultsSectionHeaderCell"
        var cell: SearchResultsSectionHeaderCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchResultsSectionHeaderCell
        if( cell == nil) {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SearchResultsSectionHeaderCell
        }
        var totalReviewCount = 0
        var totalPTCount = 0
        var totalPTWithRating = 0
        var avgPTRating:Double!
        var totalRatingCount = 0.0
        if(businesses != nil)
        {
            for business in businesses {
                totalReviewCount += Int(truncating: business.reviewCount!)
                totalPTCount += 1
                if(!(business.ratingStarCount?.isEqual(to: 0))!)
                {
                    totalPTWithRating += 1
                    totalRatingCount += Double(truncating: business.ratingStarCount!)
                }
            }
            avgPTRating = Double(totalRatingCount/Double(totalPTWithRating))
            cell!.TotalReviewsLbl.text = String(totalReviewCount)
            cell!.TotalPTCountLbl.text = String(totalPTCount)
            cell!.PTCountWRatingLbl.text = String(totalPTWithRating)
            cell!.AvgPTRatingLbl.text = String(format: "%.1f", avgPTRating)
        }
        return cell!
    }
    
    
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        return true
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if (txtSearch.text == "")
        {
            lblMessage!.isHidden = false
            tblResults.isHidden = true
            self.businesses = nil;
        }
        else
        {
            lblMessage!.isHidden = true
            tblResults!.isHidden = false
            let locationParam = txtSearch.text ?? ""
            Business.searchWithTerm(term: "Physical Therapist", locationParam:locationParam,  completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses?.sorted(by: {(Double)($0.ratingStarCount!) > (Double)($1.ratingStarCount!)})
                self.tblResults.reloadData()
            }
            )
        }
    }
}

