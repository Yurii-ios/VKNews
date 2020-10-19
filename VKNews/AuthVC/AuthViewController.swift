//
//  ViewController.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 17/10/2020.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    
    private var authServices: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        // delaem 4erez singlton 4tobu authServices sozdawalsia tilko odin raz
        authServices = SceneDelegate.shared().authServices
        view.backgroundColor = .blue
        
    }
    
    @IBAction func signInTouch(_ sender: UIButton) {
        authServices.wakeUpSession()
    }
}

