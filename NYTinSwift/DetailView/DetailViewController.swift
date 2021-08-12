//
//  DetailViewController.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 13/8/2564 BE.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var webBtn: UIButton!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    var book: BookList!
    var media : BookListMedia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        setButton()
        setWebView()
        setNavView()
        titleLabel.text = book.title
        abstractLabel.text = book.abstract
        imgView.sd_setImage(with: URL(string: media.url), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
    }
    
    func setNavView(){

        self.navView.layer.shadowColor = UIColor.black.cgColor
        self.navView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.navView.layer.shadowRadius = 2.0;
        self.navView.layer.shadowOpacity = 0.3
        self.navView.layer.masksToBounds = false
    }
    func setWebView(){
        
        self.webView.layer.cornerRadius = 8

        self.webView.layer.shadowColor = UIColor.black.cgColor
        self.webView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.webView.layer.shadowRadius = 2.0;
        self.webView.layer.shadowOpacity = 0.3
        self.webView.layer.masksToBounds = false
    }
    
    func setButton(){
        backBtn.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)
        webBtn.addTarget(self, action: #selector(goWebsite(_:)), for: .touchUpInside)

    }
    @objc func goBack( _ sender: AnyObject ){
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc func goWebsite( _ sender: AnyObject ){
        
        guard let url = URL(string: book.url) else { return }
        UIApplication.shared.open(url)
    }
    

   


}
