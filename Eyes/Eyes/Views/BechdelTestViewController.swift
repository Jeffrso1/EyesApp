//
//  BechdelTestViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import UIKit
import CloudKitMagicCRUD

class BechdelTestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let button = TagButton()
    
    let responses = TestResponse()
    
    var question = Question(question: "Does this movie passes in the Bechdel Test?", answers: ["Yes", "No"], checkAnswers: 0)
    
    var movieID: Int = 0
    
    var tags : [Tag] = []
    
    var tag: Tag?
    
    let loadTags = dao.loadTags()

    //weak var delegate: ProtagonistViewController!
    
    //let circularLayoutObject = CustomCircularCollectionViewLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var confirmButton:UIButton!
    @IBOutlet var denyButton:UIButton!
    @IBOutlet var confirmButton2:UIButton!
    @IBOutlet var denyButton2:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        dao.loadTags()
        collectionView.delegate = self
        collectionView.dataSource = self
        
       // collectionView.collectionViewLayout = circularLayoutObject
        
    }

    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseTagsCollectionViewCell
        
        cell.tagButton.setTitle(loadTags[indexPath.row].displayName_enUS, for: .normal)
        cell.tagButton.sizeToFit()
        
        cell.tagButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 30.0, bottom: 5.0, right: 30.0)
        
        cell.tagButton.layer.cornerRadius = 7
        
        print(cell.tagButton.titleLabel?.text)
        
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
        
       // self.performSegue(withIdentifier: "bechdelSegue", sender: self)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}


class TestResponse {
    var response1: Bool?
    var response2: Bool?
    var response3: [Tag] = []
    
    var allResponsesOk: Bool {
        return response1 != nil && response2 != nil
    }
    
}

