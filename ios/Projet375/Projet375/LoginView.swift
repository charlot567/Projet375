//
//  LoginView.swift
//  Projet375
//
//  Created by Charles-Olivier Demers on 17-02-04.
//  Copyright © 2017 Factory26. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class LoginView: UIView, LoginButtonDelegate {
    
    private var loginButton: LoginButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bWidth = kWidth - kWidth / 4
        let bHeight = kHeight / 20
        loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.frame = CGRect(x: kWidth / 2 - bWidth / 2, y: 0, width: bWidth, height: bHeight)
        loginButton.delegate = self
        self.addSubview(loginButton)
        
    }
    
    /**
     Called when the button was used to login and the process finished.
     
     - parameter loginButton: Button that was used to login.
     - parameter result:      The result of the login.
     */
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
            loginFailed(social: "FB", result: result)
        case .cancelled:
            loginFailed(social: "FB", result: result)
        case .success(_, _, let accessToken):
            loginSuccess(social:"FB", userId: "\(accessToken.userId)")
        }
    
    }
    
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        logout(social: "FB")
    }

    
    func loginSuccess(social: String, userId: String) {
        print("Login Success -- \(social)")
        
        getUserInfo()
    }
    
    func loginFailed(social: String, result: LoginResult) {
        print("Login failed -- \(social). \(result)")
    }
    
    func logout(social: String) {
        print("Logout Success -- \(social)")
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
