//
//  PushNotificationsClass.swift
//  
//
//  Created by Mikhail on 09/10/2018.
//

import Foundation
import UserNotifications

class PushNotificationsClass {
    
    private let center = UNUserNotificationCenter.current()
    private var title = String()
    private var subtitle = String()
    private var body = String()
    private var repeats = Bool()
    private var notificationIdentyfire = String()
    
    private func dateComponentSettings(hour: Int, minute: Int, second: Int) -> DateComponents {
        var returnDateComponent = DateComponents()
        returnDateComponent.minute = minute
        returnDateComponent.hour = hour
        returnDateComponent.second = second
        return returnDateComponent
    }
    
    private func checkNotificationsStatus(_ notification: @escaping () ->Void ) {
        
        func request(_ notification: @escaping () ->Void ) {
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (bool, error) in
                if bool {
                    notification()
                }
                else {
                    print("Разрешение не получено")
                }
            }
        }
        
        center.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                notification()
            case .denied:
                print("Разрешение нет")
            case .notDetermined:
                request(notification)
            case .provisional:
                print("provision ???")
            }
        }
    }
    
    private func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        return content
    }
    
    private func makeNotificationTimeIntervalTrigger(timeInterval: TimeInterval) -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
    }
    
    private func makeNotificationInDateTrigger(hour: Int, minute: Int, second: Int) -> UNNotificationTrigger {
        return UNCalendarNotificationTrigger(dateMatching: dateComponentSettings(hour: hour, minute: minute, second: second), repeats: repeats)
    }
    
    private func sendNotificationRequest(content:UNNotificationContent, trigger: UNNotificationTrigger) {
        
        let request = UNNotificationRequest(identifier: notificationIdentyfire, content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func createNotificationWithTimeInterval(timeInterval: TimeInterval) {
        
        var time = timeInterval
        // Если делать интервал меньше 60, выдаёт ошибку if repeats == true
        if time < 60 && repeats  {
            time = 60
        }
        
        checkNotificationsStatus { [weak self] in
            guard let myClass = self else {return}
            myClass.sendNotificationRequest(content: myClass.makeNotificationContent(), trigger: myClass.makeNotificationTimeIntervalTrigger(timeInterval: time))
        }
    }
    
    func createNotificationInExtractTime(hour: Int, minute: Int, second: Int) {
        
        checkNotificationsStatus { [weak self] in
            guard let myClass = self else {return}
            myClass.sendNotificationRequest(content: myClass.makeNotificationContent(), trigger: myClass.makeNotificationInDateTrigger(hour: hour, minute: minute, second: second))
        }
    }
    
    init(title: String, subtitle: String, body: String, repeats: Bool, notificationIdentyfire: String) {
        
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.repeats = repeats
        self.notificationIdentyfire = notificationIdentyfire
        
    }
}



