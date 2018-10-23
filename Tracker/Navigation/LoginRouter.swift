//
//  MainRouter.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit



class LoginRouter: BaseRouter {
    
    func toMain(userName: String) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapsViewController") as? MapsViewController
        controller?.userName = userName
        controller?.removeFromParentViewController()
        show(controller ?? UIViewController())
    }
    
    func toRegistration() {
        let controller = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController")
        controller.modalTransitionStyle = .flipHorizontal
        show(controller)
    }

}


