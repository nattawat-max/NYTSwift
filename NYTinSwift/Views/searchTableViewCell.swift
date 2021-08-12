//
//  searchTableViewCell.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 12/8/2564 BE.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bylineLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        abstractLabel.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        bgView.layer.cornerRadius = 8.0
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.clear.cgColor
        bgView.layer.masksToBounds = true
    
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width :0, height : 1)
        bgView.layer.shadowRadius = 3.0
        bgView.layer.shadowOpacity = 0.25
        bgView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
