import UIKit


class getWord: UIViewController {
    
    var txt = "wgaaa"
    var api = API()
    
    @IBOutlet weak var Noun: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Noun.text = txt
        
        

        
        
    }

    
    @IBAction func getWordTap(_ sender: Any) {
        api.dictCall() { (results:String) in
            print(results);
            DispatchQueue.main.async {
                //Update your UI
                self.Noun.text = "\(results)"
            }
            
        }
 
        /*
        let appId = "111aab88"
        let appKey = "78ff37165f7543bcb86ee546b7e8e8c3"
        let language = "en"
        let filters = "domains=Art"
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/wordlist/en/lexicalCategory%3DNoun%3Bdomains%3Dsport?word_length=%3E5%2C%3C10&exact=false&limit=1")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
            if let response = response,
                let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                
                print(jsonData)
            } else {
                print(error)
                print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue))
            }
        }).resume()
        */
    }
    
    
   
    
    

}
