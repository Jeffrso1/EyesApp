//
//  CloudKitViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 17/11/20.
//

import UIKit

class CloudKitViewController: UIViewController {

    var cloudKitImage: UIImageView = {
        
        let image = UIImageView()
    
        image.clipsToBounds = true
        image.tintColor = .white
        
        let mediumConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold, scale: .large)
        let mediumCheckmark = SFSymbols.cloudKit?.applyingSymbolConfiguration(mediumConfig)
        image.image = mediumCheckmark
        
        return image
        
    }()
    
    var header: UILabel = {
        
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
        
    }()
    
    var body: UILabel = {
      
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
        
        
        
    }()
    
    var continueButton: UIButton = {
        
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        uiButton.backgroundColor = UIColor(named: "AccentColor")
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        uiButton.sizeToFit()
        
        uiButton.titleLabel?.numberOfLines = 1
        uiButton.titleLabel?.adjustsFontSizeToFitWidth = true
        uiButton.titleLabel?.lineBreakMode = .byClipping
        uiButton.titleLabel?.textAlignment = .center
        
        uiButton.addTarget(self, action: #selector(goToHome(sender:)), for: .touchUpInside)
         
        uiButton.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 0, bottom: 15.0, right: 0)
        
        uiButton.layer.cornerRadius = 7
        
        return uiButton
    }()
    
    var goToSettingsButton: UIButton = {
        
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        uiButton.backgroundColor = UIColor.systemBlue
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        uiButton.sizeToFit()
        
        uiButton.titleLabel?.numberOfLines = 1
        uiButton.titleLabel?.adjustsFontSizeToFitWidth = true
        uiButton.titleLabel?.lineBreakMode = .byClipping
        uiButton.titleLabel?.textAlignment = .center
        
        uiButton.addTarget(self, action: #selector(goToSettings(sender:)), for: .touchUpInside)
         
        uiButton.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 0, bottom: 15.0, right: 0)
        
        uiButton.layer.cornerRadius = 7
        
        return uiButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(cloudKitImage)
        view.addSubview(header)
        view.addSubview(body)
        view.addSubview(continueButton)
        view.addSubview(goToSettingsButton)
        
        setupCloudKitIcon()
        setupHeader()
        setupBody()
        setupContinueButton()
        setupSettingsButton()
        
    }
    
    
    private func setupCloudKitIcon() {
        
        cloudKitImage.translatesAutoresizingMaskIntoConstraints = false
        
        cloudKitImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //cloudKitImage.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 30).isActive = true
        cloudKitImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
    }
    
    
    private func setupHeader() {
        
        header.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        header.text = NSLocalizedString("iCloud Integration", comment: "")
        header.textAlignment = .center
        
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true

        
        NSLayoutConstraint(item: header, attribute: .top, relatedBy: .equal, toItem: cloudKitImage, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        
    }
    
    private func setupBody() {
        
        body.text = NSLocalizedString("iCloud Description", comment: "")
        body.textAlignment = .center
        body.numberOfLines = 0
        
        body.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        body.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        
        NSLayoutConstraint(item: body, attribute: .top, relatedBy: .equal, toItem: header, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        
    
    }
    
    private func setupSettingsButton() {
        
        if FileManager.default.ubiquityIdentityToken != nil {
            
            goToSettingsButton.isHidden = true
            
        }
        
        goToSettingsButton.setTitle(NSLocalizedString("Go to Settings App", comment: "Settings App"), for: .normal)
        
        goToSettingsButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        goToSettingsButton.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -15).isActive = true
        
        goToSettingsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        goToSettingsButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
    }
    
    
    private func setupContinueButton() {
        
        continueButton.setTitle(NSLocalizedString(NSLocalizedString("Get Started", comment: ""), comment: ""), for: .normal)
        
        continueButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        
        continueButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
    }

    @objc func goToSettings(sender: UIButton) {
     
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
        
        
    }
    
    
    
    @objc func goToHome(sender: UIButton){
        
        UserDefaults.standard.set(true, forKey: "firstLaunch")
        performSegue(withIdentifier: "goToHome", sender: self)
        
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
