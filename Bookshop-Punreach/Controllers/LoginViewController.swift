//
//  LoginViewController.swift
//  Bookshop-Punreach
//
//  Created by Punreach Rany on 2021/01/15.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        validateField()
        login()
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "signUp")
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    
    func validateField() {
        if email.text?.isEmpty == true {
            print("No text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password field")
            return
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            self?.checkUserInfo()
            
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        }
    }
    
}
