//
//  RegistrationViewController.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController {
    
    
    @IBOutlet var newLogin: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var registrationButton: UIButton!
    
    var canCreateNewUser = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoardWhenTapped()
        checkLoginAndPasswordSymbolsCount()
    }
    
    
    private func checkLoginAndPasswordSymbolsCount() {
    let registrationObserve = Observable.combineLatest(newLogin.rx.text, newPassword.rx.text)
        registrationObserve.map { ($0 ?? "").count >= 2 && ($1 ?? "").count >= 6}
        .bind { [weak self] checkRegistrationButton in
            self?.registrationButton?.isEnabled = checkRegistrationButton
        }
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func createNewUser(_ sender: Any) {
        
        guard let loginText = newLogin.text else {return}
        guard let passwordText = newPassword.text else {return}
        
        if !loginText.isEmpty && !passwordText.isEmpty {
            let allUsert = DBUserClass().loadUserData()
            for i in allUsert {
                if i.login == newLogin.text {
               // DBClass().deleteDataForKey(i.login)
                    canCreateNewUser = false
                    self.present(AlertClass().presentAlertWhenNewPassword(fromViewController: self, action: {self.dismiss(animated: true, completion: nil)}), animated: true, completion: nil)
            }
                
        }
            
             DBUserClass().saveUserData(User(login: loginText, password: passwordText))
            
            if canCreateNewUser {
                self.present(AlertClass().presentAlertWhenNewUser(fromViewController: self, action: {self.dismiss(animated: true, completion: nil)}), animated: true, completion: nil)
                  canCreateNewUser = true
            }
            
    }
    
    }

}
