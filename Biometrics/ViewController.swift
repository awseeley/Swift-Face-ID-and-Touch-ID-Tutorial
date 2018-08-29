//
//  ViewController.swift
//  Biometrics
//
//  Created by Andrew Seeley on 28/8/18.
//  Copyright © 2018 Seemu. All rights reserved.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet var txtSecret: UITextField!
    @IBOutlet var imgBio: UIImageView!
    @IBOutlet var lblSecret: UILabel!
    
    let keychain = Keychain(service: "seemu.Biometrics")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(biometricType == .touchID) {
            imgBio.image = UIImage(named: "TouchID")
        } else if(biometricType == .faceID) {
            imgBio.image = UIImage(named: "FaceID")
        } else if(biometricType == .none) {
            print("No biometric capabilities :(")
        }
        
    }
    
    @IBAction func storeSecret(_ sender: Any) {
        DispatchQueue.global().async {
            do {
                try self.keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .set(self.txtSecret.text!, key: "secret")
            } catch let error {
                print(error)
            }
        }
    }
    
    @IBAction func getSecret(_ sender: Any) {
        DispatchQueue.global().async {
            do {
                let secret = try self.keychain
                .authenticationPrompt("Authenticate to find out the secret")
                .get("secret")
                self.lblSecret.text = "The secret is: \(secret!)"
            } catch let error {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

