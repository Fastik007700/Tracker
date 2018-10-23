//
//  LoginViewController.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet var login: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet weak var router: LoginRouter!
    private var authorizationSuccess = false
    @IBOutlet var alwaysLoginOnOff: UISwitch!
    @IBOutlet var alwaysLoginLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyBoardWhenTapped()
        alwaysLoginOnOff.isOn = false
        checkPasswordAndLogin()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        login.text?.removeAll()
        password.text?.removeAll()
        UIView.animate(withDuration: 0.4
            , animations: {
                self.alwaysLoginOnOff.alpha = 0
                self.alwaysLoginLabel.alpha = 0
        })
        self.loginButton.isEnabled = false  
    }
    
    
    func checkPasswordAndLogin() {
        
        self.alwaysLoginOnOff.alpha = 0
        self.alwaysLoginLabel.alpha = 0
        
        Observable
        .combineLatest(
        login.rx.text,
        password.rx.text
        )
            .map { ($0 ?? "").count >= 2 && ($1 ?? "").count >= 6}
            .bind { [weak self] checkResult in
                
                self?.loginButton.isEnabled = checkResult
                
                if checkResult {
                    UIView.animate(withDuration: 0.4
                        , animations: {
                            self?.alwaysLoginOnOff.alpha = 1
                            self?.alwaysLoginLabel.alpha = 1
                    })
                }
                else {
                    UIView.animate(withDuration: 0.4
                        , animations: {
                            self?.alwaysLoginOnOff.alpha = 0
                            self?.alwaysLoginLabel.alpha = 0
                    })
                }
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        var authorizedUserName = ""
        let allUsert = DBUserClass().loadUserData()
        print(allUsert)
        for i in allUsert {
            if i.login == login.text && i.password == password.text {
                authorizationSuccess = true
                authorizedUserName = i.login
            }
        }
        
        if authorizationSuccess {
            if alwaysLoginOnOff.isOn {
                UserDefaults().set(true, forKey: "alwaysOnline")
            }
            router.toMain(userName: authorizedUserName)
            authorizationSuccess = false
        }
        else {
            self.present(AlertClass().presentAlertWhenLoginFail(fromViewController: self), animated: true, completion: nil)
            login.text?.removeAll()
            password.text?.removeAll()
            
            UIView.animate(withDuration: 0.4
                , animations: {
                    self.alwaysLoginOnOff.alpha = 0
                    self.alwaysLoginLabel.alpha = 0
            })
             self.loginButton.isEnabled = false
        }
    }
    
    
    @IBAction func registrationAction(_ sender: Any) {
        router.toRegistration()
    }
    
}



