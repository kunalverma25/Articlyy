//
//  ViewController.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    var pulsator: Pulsator!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setupPulseAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.layoutIfNeeded()
        pulsator.position = startButton.layer.position
    }
    
    @IBAction func startReview(_ sender: UIButton) {
        
    }

}

extension StartVC {
    func setupPulseAnimation() {
        pulsator = Pulsator()
        pulsator.numPulse = 3
        pulsator.radius = 300
        pulsator.backgroundColor = UIColor(red: 0, green: 0.455, blue: 0.756, alpha: 1).cgColor
        startButton.layer.superlayer?.insertSublayer(pulsator, below: startButton.layer)
        pulsator.start()
    }
}
