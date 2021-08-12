//
//  BookList.swift
//  NYTinSwift
//
//  Created by Nattawat Kanmarawanich on 12/8/2564 BE.
//

import Foundation
import UIKit
import SwiftyJSON

class BookList: NSObject {
    var title : String!
    var section : String!
    var abstract : String!
    var url : String!
    var byline : String!
//    var multimedia[] : BookListMedia.[]
    
    
    
    init( withJSON json: JSON) {
        super.init()
        
        parseObject( withJSON: json )
    }
    
    func parseObject( withJSON json: JSON ) {
        
        title = json["title"].stringValue
//
//        if friend_id == nil || friend_id.isEmpty == true {
//            friend_id = json["inviter_id"].stringValue
//        }
//
//
        section = json["section"].stringValue
        abstract = json["abstract"].stringValue
        byline = json["byline"].stringValue
        url = json["url"].stringValue
    }
}


class BookListMedia: NSObject {
    var title: String!
    var url: String!
    var format : String!
    
    init( withJSON json: JSON) {
        super.init()
        
        parseObject( withJSON: json )
    }
    
    func parseObject( withJSON json: JSON ) {

        url = json["url"].stringValue
        format = json["format"].stringValue
    }
}
