//
//  DictionaryCall.swift
//  Draw-A-Day
//
//  Created by Andrew Lau on 4/18/18.
//  Copyright © 2018 Andrew Lau. All rights reserved.
//

import Foundation

struct Root : Decodable {
    let results : [Results]
}

    
struct Results: Decodable{
        let id: String
        let word: String
    
    
    static func dictCall(completion: @escaping (String) -> ()){
        // TODO: replace with your own app id and app key
        let appId = "111aab88"
        let appKey = "78ff37165f7543bcb86ee546b7e8e8c3"
        let language = "en"
        let filters = "lexicalCategory=noun;domains=Clothing"
        let endpoint = "lexicalCategory"
        let limit = "?limit=1"
        let offset = "&offset=359"
        let jsonUrlString = "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/\(language)/\(filters)\(limit)\(offset)"
        //let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/domains /\(language)")!
        
        
        guard let url = URL(string: jsonUrlString) else {return}
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, err) in
            
            var noun:String = ""
            
            guard let data = data else {return}
            
            do {
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
