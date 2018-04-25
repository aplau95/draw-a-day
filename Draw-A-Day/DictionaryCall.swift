//
//  DictionaryCall.swift
//  Draw-A-Day
//
//  Created by Andrew Lau on 4/18/18.
//  Copyright © 2018 Andrew Lau. All rights reserved.
//

import Foundation

struct Root : Decodable {
    let metadata : MetaData
    let results : [Results]
}

struct MetaData: Decodable{
    let total: Int
}


struct Results: Decodable{
    let id: String
    let word: String
}

class API {
    
    var count: Int = 0
    
    func randomOffset(count: Int) -> Int {
        print("random count is " + "\(count)")
        let rand = Int(arc4random_uniform(UInt32(count)));
        print("the random num is " + "\(rand)")
        return rand
        
    }
    
    init(){
        let appId = "111aab88"
        let appKey = "78ff37165f7543bcb86ee546b7e8e8c3"
        let language = "en"
        let filters = "lexicalCategory=noun;domains=Clothing"
        let limit = "?limit=2"
        let jsonUrlString = "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/\(language)/\(filters)\(limit)"
        var url : URL!
        var count:Int = 0
        url = URL(string: jsonUrlString)
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, err) in
            
            guard let data = data else {return}
            
            do {
                let root = try JSONDecoder().decode(Root.self, from : data)
                if let lr = try? root.metadata.total{ self.count = lr}
            } catch let jsonErr {
                print("Error serializaing json:", jsonErr)
            }
            print("count is " + "\(self.count)")
        }).resume()
        
    }
    
    func dictCall(completion: @escaping (String) -> ()){
        var noun: String = ""
        
        let newOffset = randomOffset(count: self.count)
        print("offset is " + "\(newOffset)")
        let appId = "111aab88"
        let appKey = "78ff37165f7543bcb86ee546b7e8e8c3"
        let language = "en"
        let filters = "lexicalCategory=noun;domains=Clothing"
        let limit = "?limit=1"
        let offset2 = "&offset=\(newOffset)"
        let jsonUrlString = "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/\(language)/\(filters)\(limit)\(offset2)"
        var url : URL!
        
        url = URL(string: jsonUrlString)
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, err) in
            
            
            guard let data = data else {return}
            
            do {
                print(data.count)
                let root = try JSONDecoder().decode(Root.self, from : data)
                
                if let wordObject = try? root.results[0].word {
                    noun = wordObject
                }
                
                
            } catch let jsonErr {
                print("Error serializaing json:", jsonErr)
            }
            
            completion(noun)
            
            
            
        }).resume()
        return
    }

}
