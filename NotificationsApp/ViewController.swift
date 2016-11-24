//
//  ViewController.swift
//  NotificationsApp
//
//  Created by iulian david on 11/23/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 1. REQUEST PERMISSION 
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification Granted")
            } else {
                print(error?.localizedDescription ?? "An error occured")
            }
                })
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton ){
        scheduleNotification(inSeconds: 5, completion: {
            success in
            if success {
                print("Succesfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) ->()){
        //Add an attachment
        let myImage = "alex"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "png") else {
            completion(false)
            return
        }
        
        var attachment:UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        //Create the content
        let notif = UNMutableNotificationContent()
        //We need to set up a title, subtile and a body
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "Testing the new iOS 10 options"
        
        //finally add attachemnt to notification
        notif.attachments = [attachment]
        
        //ONLY FOR EXTENSION
        notif.categoryIdentifier = notificationCategory
        
        
        
        // We need a trigger
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        //We need a request
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        //setup to the usenotification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

