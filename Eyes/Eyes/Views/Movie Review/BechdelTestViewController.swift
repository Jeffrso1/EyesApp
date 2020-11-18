//
//  BechdelTestViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import UIKit
import CloudKitMagicCRUD

class BechdelTestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DAORequester {
    
    var imageLoader = ImageLoader()
    
    let button = TagButton()
    
    let responses = TestResponse()
    
    var movieID: Int = 0
    
    var tag: Tag?
    
    var firstTag : TagSelected?
    var secondTag: TagSelected?
    var tags : [Tag] = []
    
    var selectedTags: [Tag] = []
    var tagsSelected : [TagSelected] = []
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterBlurImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var confirmButton:UIButton!
    @IBOutlet var denyButton:UIButton!
    @IBOutlet var confirmButton2:UIButton!
    @IBOutlet var denyButton2:UIButton!
    
    @IBOutlet weak var submitReview: UIButton!
    
    @IBAction func confirmButton(_ sender: Any) {
    
        haptic.setupImpactHaptic(style: .light)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        configNavBar()
        
        setupFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadAsyncImage(from: currentMovie ?? Movie.stubbedMovie) { image in
            self.posterImage.image = image
            self.posterBlurImage.image = image
        }
        
        //dao.loadTags()
       // dao.loadMovie(movie: movieID, to: self)
        
        setupMovie()
        //submitReview.isEnabled = false
        //submitReview.backgroundColor = UIColor(named: "Button")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 50) // The size of one cell
    }
    
    func updated() {
        
        print("running update")
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 0)  // Header size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let margin: CGFloat  = 0
        return UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin) // margin between cells
    }
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.type = .fade
            
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
        
        self.navigationController?.navigationBar.topItem?.title = currentMovie?.title
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseTagsCollectionViewCell
       
        cell.setupTag(tag: dao.tags[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    @IBAction func endReview(_ sender: Any) {
        
        do {
            
            try checkReviewSubmission()
            performSegue(withIdentifier: "endReview", sender: nil)
        
        } catch MovieReviewError.reviewIsMissing {
            
            Alert.showBasic(title: NSLocalizedString("Error Uploading Review", comment: ""), message: NSLocalizedString("Please, make sure all questions were anwsered.", comment: "") , vc: self, type: .warning)
            
        } catch {
            
            Alert.showBasic(title: NSLocalizedString("An unexpected error has ocurred.", comment: ""), message: NSLocalizedString("Please, try again.", comment: ""), vc: self, type: .error)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        
    }
    
    @IBAction func submitReview(_ sender: Any) {
  
    }
    
    func checkReviewSubmission() throws {
        
        if !responses.allResponsesOk {
            
            throw MovieReviewError.reviewIsMissing
            
        } else {
        
            selectedTags = dao.tags.filter { ($0.isSelected ?? false) }
            
            tagsSelected.append(contentsOf: [firstTag!, secondTag!])
            
            let arrayCurrentMovie = [Array(dao.movies)[dao.currentMovie]]
        
        
            let movie = MyMovie.init(movieID: arrayCurrentMovie.first!.key, tags: selectedTags, tagsSelected: tagsSelected)
            
            movie.ckSave { result in
                switch result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
                    print("error")
                }
            }
                
            print("saving movie")
            
            haptic.setupNotificationHaptic(type: .success)
           // performSegue(withIdentifier: "endReview", sender: nil)
            
            
        }
  
    }
    
    
    
    @IBAction func selectResponse(_ sender: UIButton) {
        
        response(sender: sender)
        
    }
    
    func response(sender: UIButton) {
        
        switch sender.tag {
        case 0:
            buttonSetup(senderResponse: confirmButton, senderNonResponse: denyButton)
            self.firstTag = fetchTagsSelected(from: .passInBechdelTest)
            responses.response1 = true
        case 1:
            buttonSetup(senderResponse: denyButton, senderNonResponse: confirmButton)
            self.firstTag = fetchTagsSelected(from: .doesntPassInBechdelTest)
            responses.response1 = false
        case 2:
            buttonSetup(senderResponse: confirmButton2, senderNonResponse: denyButton2)
            self.secondTag = fetchTagsSelected(from: .womanAsMainProtagonist)
            responses.response2 = true
        case 3:
            buttonSetup(senderResponse: denyButton2, senderNonResponse: confirmButton2)
            self.secondTag = fetchTagsSelected(from: .womanIsNotAsMainProtagonist)
            responses.response2 = false
        default:
            break
            
        }
        
        saveResponse()
        
    }
    
    func saveResponse() {
        
        if responses.allResponsesOk {
            
            submitReview.isEnabled = true
            submitReview.backgroundColor = UIColor(named: "AccentColor")
            
        } else {
            
            //haptic.setupNotificationHaptic(type: .error)
            
            
        }
        
        print(responses.allResponsesOk)
        
    }
    
    func buttonSetup(senderResponse: UIButton, senderNonResponse: UIButton) {
        senderResponse.backgroundColor = UIColor(named: "AccentColor")
        senderNonResponse.backgroundColor = UIColor(named: "Button")
    }
    
    func setupFlowLayout() {
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 80, height: 40)
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
    }
    
    func configNavBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        
    }
    
    func fetchTags(from recordName: String) -> Tag? {
        
        var tag : Tag?
        
        Tag.ckLoad(with: recordName) { result in
            switch result {
            case .success(let result):
                tag = result as? Tag
            case .failure(let error):
                print(error)
            }
            
        }
        
        return tag
        
    }
    
    func fetchTagsSelected(from value: TagValue) -> TagSelected? {
        
        var tag : TagSelected?
        
        TagSelected.ckLoad(with: value.rawValue) { result in
            switch result {
            case .success(let result):
                tag = result as? TagSelected
            case .failure(let error):
                print(error)
            }
            
        }
        
        return tag
        
    }
    
    func setupMovie() {
        
        posterImage.layer.cornerRadius = 7
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = posterBlurImage.bounds
        posterBlurImage.addSubview(blurView)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    fileprivate func loadAsyncImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        if let data = movie.imageData {
            if let currentImage = UIImage(data: data) {
                completion(currentImage)
            }
        }
        else if let url = movie.posterURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    movie.imageData = data
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(data: data) {
                            completion(currentImage)
                        }
                    }
                }
            }
        }
    }
    
}

class TestResponse {
    var response1: Bool?
    var response2: Bool?
    var response3: [Tag] = []
    
    var allResponsesOk: Bool {
        return response1 != nil && response2 != nil
    }
    
}

