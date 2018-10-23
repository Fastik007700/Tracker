//
//  SaveLoadToDiscClass.swift
//  Tracker
//
//  Created by Mikhail on 15/10/2018.
//  Copyright © 2018 Mikhail. All rights reserved.
//

import Foundation
import UIKit


class SaveLoadToDiscClass {
    
    func saveImage(image: UIImage, name: String) {
        guard let data = UIImageJPEGRepresentation(image, 1) else {return}
        
        let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        do {
            try data.write(to: (directory?.appendingPathComponent("\(name).jpg"))!)
        }
        catch {
            print("error")
        }
    }
    
    
    func getSavedImage(named: String) -> UIImage? {
        if let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func deleteImage(name:String) {
        
          if let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            try? FileManager.default.removeItem(at: directory)
        }
        
    }
}
