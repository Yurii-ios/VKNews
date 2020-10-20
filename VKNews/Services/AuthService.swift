//
//  AuthService.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 17/10/2020.
//

import Foundation
import VK_ios_sdk


protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    private let appId = "7629997"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    func wakeUpSession() {
        // Права доступа определяют возможность использования токена для работы с тем или иным разделом данных.
        let scope = ["offline"]
        
        VKSdk.wakeUpSession(scope) { [weak self] (authorizationState, error) in
            switch authorizationState {
            case .unknown:
                print("unknown")
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .pending:
                print("pending")
            case .external:
                print("external")
            case .safariInApp:
                print("safariInApp")
            case .webview:
                print("webview")
            case .authorized:
                print("authorized")
                self?.delegate?.authServiceSignIn()
            case .error:
                print("error")
            @unknown default:
                print("default")
                self?.delegate?.authServiceSignInFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
        delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
