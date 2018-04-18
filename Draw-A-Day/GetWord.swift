import UIKit


class getWord: UIViewController {
    
    var txt = "wgaaa"
    
    @IBOutlet weak var Noun: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Noun.text = txt
        

        
        
    }

    
    @IBAction func getWordTap(_ sender: Any) {
        Results.dictCall() { (results:String) in
            print(results);
            DispatchQueue.main.async {
                //Update your UI
                self.Noun.text = "\(results)"
            }
            
        }
    }
    
    
   
    
    

}
