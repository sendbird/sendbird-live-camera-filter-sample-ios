//
//  SignInViewController.swift
//  SendbirdLiveBanubaSample
//
//  Created by Minhyuk Kim on 2022/12/12.
//

import UIKit
import SendbirdLiveSDK

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.delegate = self
    }
    
    @IBOutlet var userIdTextField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        guard let userId = userIdTextField.text else { return }
        
        SendbirdLive.authenticate(userId: userId) { result in
            switch result {
            case .success:
                self.performSegue(withIdentifier: "SignIn", sender: nil)
            case .failure:
                break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
