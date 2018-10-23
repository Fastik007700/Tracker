//
//  LoginRouter.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit


class MainRouter: BaseRouter {
    
    func toLogin() {
        let controller = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        controller.removeFromParentViewController()
        show(controller)
    }
    
    func toPhoto() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelfieViewController")
        controller.removeFromParentViewController()
        show(controller)
    }
}
