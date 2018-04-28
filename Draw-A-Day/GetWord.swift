import UIKit


extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


class getWord: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var list = ["", "Air Force", "Alcoholic", "American Civil War", "American Football", "Amerindian", "Anatomy", "Ancient History", "Angling", "Anthropology", "Archaeology", "Archery", "Architecture", "Art", "Artefacts", "Arts And Humanities", "Astrology", "Astronomy", "Athletics", "Audio", "Australian Rules", "Aviation", "Ballet", "Baseball", "Basketball", "Bellringing", "Biblical", "Billiards", "Biochemistry", "Biology", "Bird", "Bookbinding", "Botany", "Bowling", "Bowls", "Boxing", "Breed", "Brewing", "Bridge", "Broadcasting", "Buddhism", "Building", "Bullfighting", "Camping", "Canals", "Cards", "Carpentry", "Chemistry", "Chess", "Christian", "Church Architecture", "Civil Engineering", "Clockmaking", "Clothing", "Coffee", "Commerce", "Commercial Fishing", "Complementary Medicine", "Computing", "Cooking", "Cosmetics", "Cricket", "Crime", "Croquet", "Crystallography", "Currency", "Cycling", "Dance", "Dentistry", "Drink", "Dyeing", "Early Modern History", "Ecclesiastical", "Ecology", "Economics", "Education", "Egyptian History", "Electoral", "Electrical", "Electronics", "Element", "English Civil War", "Falconry", "Farming", "Fashion", "Fencing", "Film", "Finance", "Fire Service", "First World War", "Fish", "Food", "Forestry", "Freemasonry", "French Revolution", "Furniture", "Gambling", "Games", "Gaming", "Genetics", "Geography", "Geology", "Geometry", "Glassmaking", "Golf", "Goods Vehicles", "Grammar", "Greek History", "Gymnastics", "Hairdressing", "Handwriting", "Heraldry", "Hinduism", "History", "Hockey", "Honour", "Horology", "Horticulture", "Hotels", "Hunting", "Insect", "Instrument", "Intelligence", "Invertebrate", "Islam", "Jazz", "Jewellery", "Journalism", "Judaism", "Knitting", "Language", "Law", "Leather", "Linguistics", "Literature", "Logic", "Lower Plant", "Mammal", "Marriage", "Martial Arts", "Mathematics", "Measure", "Mechanics", "Medicine", "Medieval History", "Metallurgy", "Meteorology", "Microbiology", "Military", "Military History", "Mineral", "Mining", "Motor Racing", "Motoring", "Mountaineering", "Music", "Musical Direction", "Mythology", "Napoleonic Wars", "Narcotics", "Nautical", "Naval", "Needlework", "Numismatics", "Occult", "Oceanography", "Office", "Oil Industry", "Optics", "Palaeontology", "Parliament", "Pathology", "Penal", "People", "Pharmaceutics", "Philately", "Philosophy", "Phonetics", "Photography", "Physics", "Physiology", "Plant", "Plumbing", "Police", "Politics", "Popular Music", "Postal", "Pottery", "Printing", "Professions", "Prosody", "Psychiatry", "Psychology", "Publishing", "Racing", "Railways", "Rank", "Relationships", "Religion", "Reptile", "Restaurants", "Retail", "Rhetoric", "Riding", "Roads", "Rock", "Roman Catholic Church", "Roman History", "Rowing", "Royalty", "Rugby", "Savoury", "Scouting", "Second World War", "Sex", "Shoemaking", "Sikhism", "Skateboarding", "Skating", "Skiing", "Smoking", "Snowboarding", "Soccer", "Sociology", "Space", "Sport", "Statistics", "Stock Exchange", "Surfing", "Surgery", "Surveying", "Sweet", "Swimming", "Tea", "Team Sports", "Technology", "Telecommunications", "Tennis", "Textiles", "Theatre", "Theology", "Timber", "Title", "Tools", "Trade Unionism", "Transport", "University", "Variety", "Veterinary", "Video", "War Of American Independence", "Weapons", "Weightlifting", "Wine", "Wrestling", "Yoga", "Zoology"]
    

    
    //component declarations
    @IBOutlet weak var Noun: UILabel!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var getWordButton: UIButton!
    @IBOutlet weak var bg: UIImageView!
    let img = UIImage(named: "paint-strokes")!.alpha(0.7)
    
    var txt = ""
    var cat = "Air Force"
    var api = API("Air Force")

        
    override func viewDidLoad() {
        dropDown.delegate = self
        dropDown.dataSource = self
        super.viewDidLoad()
        Noun.text = txt
        self.getWordButton.layer.cornerRadius = 4
        self.Noun.textAlignment = .center
        self.bg.image = img
        
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        api.changeCat(list[row])
        api = API(list[row])
    }
    
    
    @IBAction func getWordTap(_ sender: Any) {
        
        api.dictCall() { (results:String) in
            DispatchQueue.main.async {
                //Update your UI
                self.Noun.text = "\(results)".capitalized
            }
            
        }
 
    }
    

}
