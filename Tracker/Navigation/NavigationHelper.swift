//
//  NavigationHelper.swift
//  Tracker
//
//  Created by Mikhail on 01/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import UIKit


protocol StoryboardIdetifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdetifiable { }


extension StoryboardIdetifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}


extension UIStoryboard {
    
    func instantiaveViewController<T: UIViewController>(_ : T.Type) -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
            else {
                fatalError("navigation Error")
        }
        return viewController
    }
}

