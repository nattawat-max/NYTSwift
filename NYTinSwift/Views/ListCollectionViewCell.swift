//
//  ListCollectionViewCell.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 11/8/2564 BE.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 8
        bgView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        
        
        
        // Initialization code
//        titleLabel.numberOfLines = 0
//        titleLabel.sizeToFit()
//        titleLabel.textColor = UIColor(red: 0.0, green: 0.004, blue: 0.502, alpha: 1.0)
//        titleLabel.textColor = UIColor colorWithRed: 0.50 green: 0.50 blue: 0.50 alpha: 1.00;
        

    }

}


