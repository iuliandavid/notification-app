//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by iulian david on 11/24/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

   
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard  let attachment = notification.request.content.attachments.first else {
            return
        }
        
        //Because the notification is outside the application sandbox we need to access it accession security scoped resource
        if attachment.url.startAccessingSecurityScopedResource(){
            if let imageData = try? Data.init(contentsOf : attachment.url) {
            image.image = UIImage(data: imageData)
            }
        }
    }

}
