/*
 * Copyright (C) 2017 Aptyr (github.com/aptyr)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftyJSON

class User : NSObject {
    public var login : String?
    public var id : Int?
    public var avatar_url : String?
    public var name : String?
    public var email : String?
    public var createdAt : Date?
    public var repos : Int?
    
    public var since : Date? {
        get {
            return createdAt
        }
    }
    
    init(json:JSON) {
        
        login = json["login"].string
        id = json["id"].int
        avatar_url = json["avatar_url"].string
        name = json["name"].string
        email = json["email"].string
        createdAt = json["created_at"].date
        repos = json["public_repos"].int
    }
    
    init(dict: [String: Any]) {
        print("dict: \(dict)")
        login = dict["login"] as! String?
        id = dict["id"] as! Int?
        avatar_url = dict["avatar_url"] as! String?
        name = dict["name"] as! String?
        email = dict["email"] as! String?
        createdAt = dict["created_at"] as! Date?
        repos = dict["public_repos"] as! Int?
    }
    
    func asDict() -> [String: AnyObject] {
        var dict : [String: AnyObject] = [:]
        
        dict["login"] = login as AnyObject?
        dict["id"] = id as AnyObject?
        dict["avatar_url"] = avatar_url as AnyObject?
        dict["name"] = name as AnyObject?
        dict["email"] = email as AnyObject?
        dict["created_at"] = createdAt as AnyObject?
        dict["public_repos"] = repos as AnyObject?
        print("dict: \(dict)")

        return dict
    }
    
    
    override var description: String {
        return "\(login) : \(name) : \(since)"
    }
    
}
