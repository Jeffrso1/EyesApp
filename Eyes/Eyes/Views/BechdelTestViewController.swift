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
    
    var question = Question(question: "Does this movie passes in the Bechdel Test?", answers: ["Yes", "No"], checkAnswers: 0)
    
    var movieID: Int = 0
    
    var tags : [Tag] = []
    
    var tag: Tag?
    
    let loadTags = dao.loadTags()

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterBlurImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var confirmButton:UIButton!
    @IBOutlet var denyButton:UIButton!
    @IBOutlet var confirmButton2:UIButton!
    @IBOutlet var denyButton2:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        configNavBar()
        setupFlowLayout()
        dao.loadTags()
        dao.loadMovie(movie: movieID, to: self)
    
        posterImage.layer.cornerRadius = 7
        
        collectionView.delegate = self
        collectionView.dataSource = self
 
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = posterBlurImage.bounds
        posterBlurImage.addSubview(blurView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: 50) // The size of one cell
    }

    func updated() {
            loadAsyncImage(from: dao.movie ?? Movie.stubbedMovie) { image in
            self.posterImage.image = image
            self.posterBlurImage.image = image
            }
            self.navigationController?.navigationBar.topItem?.title = dao.movie?.title
            print("running update")
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 0)  // Header size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let frame : CGRect = self.view.frame
        let margin: CGFloat  = 0
        return UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin) // margin between cells
    }
    

    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseTagsCollectionViewCell
        
        cell.tagButton.setTitle(loadTags[indexPath.row].displayName_enUS, for: .normal)
   
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "bechdelSegue" {
            //let vc = segue.destination as! ProtagonistViewController

            print("Carregando Tag")
            tag = dao.loadTag(with: "BA4EA6EF-56A8-1809-F5C8-915B535EDF59")
            print(tag?.displayName_ptBR)
            print("Finalizado Tag")

            self.tags.append(tag!)
            
           // vc.tags = self.tags
           // vc.movieID = self.movieID

        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
    
    }
    
    @IBAction func selectResponse(_ sender: UIButton) {
    
        response(sender: sender)
        
        print("button working")
    
    }

    func response(sender: UIButton) {
        
        switch sender.tag {
            case 0:
                buttonSetup(senderResponse: confirmButton, senderNonResponse: denyButton)
                responses.response1 = true
            case 1:
                buttonSetup(senderResponse: denyButton, senderNonResponse: confirmButton)
                responses.response1 = false
            case 2:
                buttonSetup(senderResponse: confirmButton2, senderNonResponse: denyButton2)
                responses.response2 = true
            case 3:
                buttonSetup(senderResponse: denyButton2, senderNonResponse: confirmButton2)
                responses.response2 = false
            default:
                break

        }
        
    }

    func saveResponse() {
        
        if responses.allResponsesOk {
            
            
            
        } else {
            
            
        }

    }
    
    func buttonSetup(senderResponse: UIButton, senderNonResponse: UIButton) {
        
        senderResponse.backgroundColor = UIColor(named: "AccentColor")
        senderNonResponse.backgroundColor = UIColor(named: "Button")
    }
    
    func setupFlowLayout() {
        
        var flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
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

