//
//  GradientView.swift
//  Articlyy
//
//  Created by Kunal Verma on 09/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation
import UIKit

class GradientButton: UIButton {
    override func draw(_ rect: CGRect) {
        addLeftToRightGradient()
        self.layer.cornerRadius = rect.height / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func addLeftToRightGradient(colors : [CGColor] = [#colorLiteral(red: 0.337254902, green: 0.5176470588, blue: 0.9607843137, alpha: 1),#colorLiteral(red: 0.3764705882, green: 0.7764705882, blue: 0.9529411765, alpha: 1)]){
        self.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
