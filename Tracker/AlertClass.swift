//
//  AlertClass.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit


class AlertClass {
    
    func presentAlertWhenLoginFail(fromViewController controller: UIViewController) -> UIViewController {
        
        let alert = UIAlertController(title: "Login Error", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        return alert
    }
    
    func presentAlertWhenNewUser(fromViewController controller: UIViewController, action: @escaping () -> ()) -> UIViewController {
        
        let alert = UIAlertController(title: "Success Registration", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back To Login View", style: .default, handler: { (_) in
            action()
        }))
        return alert
    }
    
    func presentAlertWhenNewPassword(fromViewController controller: UIViewController, action: @escaping () -> ()) -> UIViewController {
        
        let alert = UIAlertController(title: "Now You Have New Password", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back To Login View", style: .default, handler: { (_) in
            action()
        }))
        return alert
    }
}
