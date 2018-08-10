//
//  Popup.swift
//  Articlyy
//
//  Created by Kunal Verma on 09/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation
import UIKit

class Popup {
    private var alertWindow: UIWindow
    static var shared = Popup()
    
    init() {
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.isHidden = true
    }
    
    private func showAlert(title: String?, message: String?, showCancel: Bool = false, completion: @escaping () -> ()) {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                DispatchQueue.main.async {
                    self.alertWindow.isHidden = true
                    completion()
                }
        })
        controller.addAction(yesAction)
        
        if showCancel {
            let noAction = UIAlertAction(
                title: "Cancel",
                style: .destructive,
                handler: { _ in
                    DispatchQueue.main.async {
                        self.alertWindow.isHidden = true
                    }
            })
            controller.addAction(noAction)
        }
        
        self.alertWindow.isHidden = false
        alertWindow.rootViewController?.present(controller, animated: false)
        
    }
}
