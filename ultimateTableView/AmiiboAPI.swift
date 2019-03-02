//
//  AmiiboAPI.swift
//  ultimateTableView
//
//  Created by Mikaela Caron on 3/2/19.
//  Copyright © 2019 Mikaela Caron. All rights reserved.
//

import Foundation

final class AmiiboAPI {
    
    //uses single instance here rather than creating lots of different instances
    static let shared = AmiiboAPI()
    
    func fetchAmiiboList(onComplete: @escaping ([Amiibo]) -> ()) {
        
        let urlString = "http://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard let data = data else {
                print("Data was nil")
                return
            }
            
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("Couldn't decode JSON")
                return
            }
            
            onComplete(amiiboList.amiibo)
            
        }//end task
        
        //exectues task
        task.resume()
        
    }//end fetchAmiiboList()
    
}//end AmiiboAPI class

struct AmiiboList: Codable {
    let amiibo: [Amiibo]
}

struct Amiibo: Codable {
    
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRelease
    let tail: String
    let type: String
    
}

struct AmiiboRelease: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
}
