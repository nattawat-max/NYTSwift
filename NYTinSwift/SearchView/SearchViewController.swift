//
//  SearchViewController.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 12/8/2564 BE.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    

    @IBOutlet weak var searchTabelView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchTableViewCellId = "searchTableViewCell"
    let screenSize: CGRect = UIScreen.main.bounds
    
    var bookList: [BookList] = []
    var filteredBookList: [BookList] = []
    var bookListMedia: [BookListMedia] = []
    var filteredMedia: [BookListMedia] = []
    var isFiltered: Bool!
    var searchTask: DispatchWorkItem?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        prepareTableView()
        setupView()
        setButton()
        // Do any additional setup after loading the view.
    }
    
    func setButton(){
        backBtn.addTarget(self, action: #selector(goBack(_:)), for: .touchUpInside)

    }
    func prepareTableView(){
        //register Cell
        
        let nibCell = UINib(nibName: searchTableViewCellId, bundle: nil)
        self.searchTabelView.register(nibCell, forCellReuseIdentifier: searchTableViewCellId)
        
//        searchTabelView.register(nibCell, forCellWithReuseIdentifier: searchTableViewCellId)
//
        self.searchTabelView.delegate = self
        self.searchTabelView.dataSource = self
    }
    func setupView(){
        self.setNavView()
    }
    
    func setNavView(){

        self.navView.layer.shadowColor = UIColor.black.cgColor
        self.navView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.navView.layer.shadowRadius = 2.0;
        self.navView.layer.shadowOpacity = 0.3
        self.navView.layer.masksToBounds = false
    }
    
    @objc func goBack( _ sender: AnyObject ){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func gotoDetail(book : BookList, media : BookListMedia){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.book = book
        vc.media = media
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFiltered == true){
            return filteredBookList.count
        }
        else{
            return bookList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = screenSize.width / 3
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchTableViewCellId, for: indexPath) as! searchTableViewCell 
        cell.selectionStyle = .none
        
        if(isFiltered == true){
            let bookItem = filteredBookList[indexPath.row]
            cell.titleLabel.text = bookItem.title
            cell.abstractLabel.text = bookItem.abstract
            cell.bylineLabel.text = bookItem.byline
            cell.imgView.sd_setImage(with: URL(string: filteredMedia[indexPath.row].url), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        }
        else{
            let bookItem = bookList[indexPath.row]
            cell.titleLabel.text = bookItem.title
            cell.abstractLabel.text = bookItem.abstract
            cell.bylineLabel.text = bookItem.byline
            cell.imgView.sd_setImage(with: URL(string: bookListMedia[indexPath.row].url), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isFiltered == true){
            let media = filteredMedia[indexPath.row]
            let book = filteredBookList[indexPath.row]
            self.gotoDetail(book: book , media: media)
        }
        else{
            let media = bookListMedia[indexPath.row]
            let book = bookList[indexPath.row]
            self.gotoDetail(book: book , media: media)
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Cancel previous task if any
        self.searchTask?.cancel()
        // Replace previous task with a new one
        let task = DispatchWorkItem { [weak self] in
            self?.sendSearchRequest(searchText: searchText)
        }
        self.searchTask = task

        // Execute task in 0.5 seconds (if not cancelled !)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
            
        
    }
    
    @objc func sendSearchRequest (searchText:String){
//        print(searchText)
        if(searchText.count == 0){
            self.isFiltered = false;
            self.searchTabelView.reloadData()
//            self.filteredImg = nil;
//            self.filteredBook = nil;
        }
        else{
            self.isFiltered = true;
            
            var searchingBookList: [BookList] = []
            var searchingMedia: [BookListMedia] = []
            var indexCount = 0
            for bookItem in self.bookList
            {
                if(bookItem.title .contains(searchText)){
                    searchingBookList.append(bookItem)
                    let media = bookListMedia[indexCount]
                    searchingMedia.append(media)
                }
                indexCount += 1
            }
            
            filteredBookList = searchingBookList
            filteredMedia = searchingMedia
            
            indexCount = 0
            
            for bookItem in self.bookList
            {
                let authorName = bookItem.byline.deletingPrefix("By ")
                    
                if(authorName.contains(searchText)){
                    for book in filteredBookList{
                        if(book.title != bookItem.title){
                            searchingBookList.append(bookItem)
                            let media = bookListMedia[indexCount]
                            searchingMedia.append(media)
                        }
                    }
                }
                indexCount += 1

            }
            
            filteredBookList = searchingBookList
            filteredMedia = searchingMedia
            
            
        
            
            self.searchTabelView.reloadData()
        }
    }
    

}
extension String{
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
