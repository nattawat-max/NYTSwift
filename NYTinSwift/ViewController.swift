//
//  ViewController.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 11/8/2564 BE.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Alamofire

class ViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var listCollectionView: UICollectionView! 
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var navView: UIView!
    
    let screenSize: CGRect = UIScreen.main.bounds
    let listCollectionViewCellId = "ListCollectionViewCell"
    var bookList: [BookList] = []
    var bookListMedia: [BookListMedia] = []
    var imageCache: [NSData] = []
    var selectedMedia : BookListMedia?
    var selectedBook : BookList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBtn.isHidden = true
        self.setNavView()
        self.prepareCollectionView()
        self.getBook()
        self.setButton()
        

        // Do any additional setup after loading the view.
        
        
    }

    func prepareCollectionView() {
        //register Cell
        
        let nibCell = UINib(nibName: listCollectionViewCellId, bundle: nil)
        listCollectionView.register(nibCell, forCellWithReuseIdentifier: listCollectionViewCellId)
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
        
    }
    func setNavView(){

        self.navView.layer.shadowColor = UIColor.black.cgColor
        self.navView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.navView.layer.shadowRadius = 2.0;
        self.navView.layer.shadowOpacity = 0.3
        self.navView.layer.masksToBounds = false
    }
    
    func setButton(){
        searchBtn.addTarget(self, action: #selector(gotoSearch(_:)), for: .touchUpInside)

    }
    
    @objc func gotoSearch( _ sender: AnyObject ){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        vc.bookList = self.bookList
        vc.bookListMedia = self.bookListMedia
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoDetail(book : BookList, media : BookListMedia){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.book = book
        vc.media = media
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- Fetching Data
    func getBook() {
        
        Alamofire.request(API_Domain).responseJSON {reponse in
            switch reponse.result {
                case .success(let value):
                    let json = JSON(value)
                    self.onFinishLoadingData(json: json)
//                    debugPrint(json)
                case .failure(let error):
                    print(error)
            }
        }
    }
    

    // MARK:- Phrasing JSON

    func onFinishLoadingData( json: JSON ) {
        
        let bookListData = json["results"].arrayValue
        var bookTitle : String
        bookTitle = ""
        for bookItem in bookListData {
            let bookListItem = BookList(withJSON: bookItem)
            bookTitle = bookListItem.title
            bookList.append(bookListItem)
            
            let mediaList = bookItem["multimedia"].arrayValue
            for mediaItem in mediaList{
                let media = BookListMedia(withJSON: mediaItem)
                media.title = bookTitle
                if (media.format == "superJumbo")
                {
                    bookListMedia.append(media)
                }
            }
            
            
        }
       
        if (bookListMedia.count != bookList.count){
            self.getBook()
            return
        }
        searchBtn.isHidden = false
        listCollectionView.reloadData()
    }
    
    
    // MARK:- UICollectionViewDataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell

//        cell.contentView.layer.cornerRadius = 8.0
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
//        cell.contentView.layer.masksToBounds = true
//
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cell.layer.shadowRadius = 2.0;
//        cell.layer.shadowOpacity = 0.3
//        cell.layer.masksToBounds = false
//        let imgUrl = bookListMedia[indexPath.row].url
        
        let bookItem = bookList[indexPath.row]
        cell.titleLabel.text = bookItem.title
        cell.imgView.sd_setImage(with: URL(string: bookListMedia[indexPath.row].url), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        
        return cell
    }

    // MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (screenSize.width / 2) - 26
        let cellHeight = cellWidth *  3/2;
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)

    }

    
    
    // MARK:- UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        let media = bookListMedia[indexPath.row]
        let book = bookList[indexPath.row]
        self.gotoDetail(book: book , media: media)
        
        
    }
    
    
}






