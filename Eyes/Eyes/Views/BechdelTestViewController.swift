//
//  BechdelTestViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import UIKit
import CloudKitMagicCRUD

class BechdelTestViewController: UIViewController {

    let responses = TestResponse()
    
    var question = Question(question: "Does this movie passes in the Bechdel Test?", answers: ["Yes", "No"], checkAnswers: 0)
    
    var movieID: Int = 0
    
    var tags : [Tag] = []
    
    var tag: Tag?

    //weak var delegate: ProtagonistViewController!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    @IBOutlet var bt1:UIButton!
    @IBOutlet var bt2:UIButton!
    @IBOutlet var bt3:UIButton!
    @IBOutlet var bt4:UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
   
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
    
    func response(sender: UIButton) {
        
        switch sender.hashValue {
            case bt1.hashValue:
                responses.response1 = true
            case bt2.hashValue:
                responses.response1 = false
            case bt3.hashValue:
                responses.response2 = true
            case bt4.hashValue:
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

