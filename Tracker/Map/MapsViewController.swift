//
//  MapsViewController.swift
//  
//
//  Created by Mikhail on 18.09.2018.
//

import UIKit
import GoogleMaps
import CoreLocation
import RxSwift

class MapsViewController: UIViewController{
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var router: MainRouter!
    private var locationManager = LocationManager.locationManager
    private var coordinates: CLLocationCoordinate2D?
    private var showYourLocationBool = true
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var coordinatesArray: [CLLocationCoordinate2D] = []
    private var gMBounds: GMSCoordinateBounds?
    var userName = ""
    private var imageForMarKer: UIImage?
    private var marker: GMSMarker?
    
    @IBOutlet var photoIcon: UIButton!
    

    
    private let alert = UIAlertController(title: "Ошибка", message: "Отключите слежение", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        if let loadImage = SaveLoadToDiscClass().getSavedImage(named: "avatar.jpg") {
            imageForMarKer = loadImage
        }
        
        photoIcon.layer.cornerRadius = photoIcon.frame.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("Here is your map \(userName)")
    }
    
    
    
    @IBAction func beginAction(_ sender: Any) {
        showYourLocationBool = true
        route?.map = nil
        locationManager.startUpdatingLocation()
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        DBCoordinatesClass().deleteData()
    }
    
    
    @IBAction func stopAction(_ sender: Any) {
        showYourLocationBool = false
        locationManager.stopUpdatingLocation()
        coordinatesArray.removeAll()
    }
    
    
    @IBAction func takeSelfie(_ sender: Any) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {return}
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func showLastAction(_ sender: Any) {

        let array = DBCoordinatesClass().loadData()
        if !showYourLocationBool {
            route?.map = nil
            route = GMSPolyline()
            routePath = GMSMutablePath()
            route?.map = mapView
            print(array)
            for i in array {
                routePath?.add(CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude))
                gMBounds?.includingCoordinate(CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude))
            }
            if let m = gMBounds {
                let newCamera = GMSCameraUpdate.fit(m, withPadding: 10)
                print("OK")
                mapView.animate(with: newCamera)
            }
            route?.path = routePath
        }
            
        else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func configureteMap() {
        if let m = coordinates {
            let camera = GMSCameraPosition.camera(withTarget: m, zoom: 15)
            mapView.animate(to: camera)
        }
    }
    
    func configureLocationManager() {
        locationManager.location
            .asObservable()
            .bind { [weak self] location in
                if let location = location {
                    self?.removeMarker()
                    self?.addMarker(location: location.coordinate)
                    self?.routePath?.add(location.coordinate)
                    self?.route?.path = self?.routePath
                    let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
                    self?.mapView.animate(to: position)
                }
        }
     
    }
    
    func addMarker(location: CLLocationCoordinate2D ) {
            marker = GMSMarker(position: location)
            marker?.map = mapView
        
        if let image = imageForMarKer {
            let markerNewView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            markerNewView.layer.masksToBounds = true
            let imageview = UIImageView(image: image)
            imageview.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
            markerNewView.addSubview(imageview)
        
            
            markerNewView.layer.cornerRadius = markerNewView.frame.size.width/2

            marker?.iconView = markerNewView
        }
    }
    func removeMarker() {
        marker?.map = nil
        marker = nil
    }
    

    
    @IBAction func backToLogin(_ sender: Any) {
        if UserDefaults().bool(forKey: "alwaysOnline") {
       router.toLogin()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
         UserDefaults().set(false, forKey: "alwaysOnline")

    }
    
}


extension MapsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        SaveLoadToDiscClass().deleteImage(name: "avatar")
        let image = extractImage(from: info)
        imageForMarKer = image ?? UIImage()
        SaveLoadToDiscClass().saveImage(image: image ?? UIImage(), name: "avatar")
        picker.dismiss(animated: true, completion: nil)
        self.removeMarker()
        locationManager.location.asObservable().bind { [weak self] location in
            if let location = location {
                self?.removeMarker()
            self?.addMarker(location: location.coordinate)
                
            }
        }
        
    }
    
    
    private func extractImage(from info: [String:Any]) -> UIImage? {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            return image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            return image
        }
        else {
            return nil
        }
    }
    
    
}


