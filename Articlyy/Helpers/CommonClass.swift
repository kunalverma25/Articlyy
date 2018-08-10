//
//  CommonClass.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation
import Toaster
import KVNProgress

class CommonFunctions {
    
    static func showLoader() {
        let conf = KVNProgressConfiguration.default()
        conf?.isFullScreen = false
        KVNProgress.setConfiguration(conf)
        KVNProgress.show()
    }
    
    static func hideLoader() {
        KVNProgress.dismiss()
    }
    
    static func showToast(msg: String, _ completion : (()->())? = nil) {
        if let currentToast = ToastCenter.default.currentToast {
            currentToast.cancel()
        }
        let toast = Toast(text: msg)
        toast.show()
    }
    
}
