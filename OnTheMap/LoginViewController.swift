//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Ada Ji on 11/18/15.
//  Copyright © 2015 Ada Ji. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: KeyboardHandlingViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BorderedButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var facebookLoginButton: BorderedButton!
        
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setControlsEnabled(true)
        setLoginButtonEnabled(false)
        
        // Try auto login
        tryAutoLogin()
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonTouch(sender: UIButton) {
        setControlsEnabled(false)
        login()
    }
    
    // Clicking on the Sign Up link will open Safari to the Udacity sign-in page.
    @IBAction func signupButtonTouchUp(sender: UIButton) {
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signin")!)
    }
    
    // MARK: Login
    
    // Login automatically if user has logged in from this device before
    func tryAutoLogin() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let email = userDefaults.valueForKey("email") as? String {
            emailTextField.text = email
            if let password = userDefaults.valueForKey("password") as? String {
                passwordTextField.text = password
                
                if !email.isEmpty && !password.isEmpty {
                    login()
                }
            }
        }
    }
    
    func login() {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Logging in..."
        
        UdacityClient.sharedInstance().autheticateUdacityWithViewController(self) {
            success, errorString in
            if success {
                // Save/update email and password
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(self.emailTextField.text!, forKey: "email")
                userDefaults.setValue(self.passwordTextField.text!, forKey: "password")
                userDefaults.synchronize()

                let mainTBC = self.storyboard!.instantiateViewControllerWithIdentifier("MainTabBarController") as! UITabBarController
                
                dispatch_async(dispatch_get_main_queue(), {
                    hud.hide(true)
                    
                    mainTBC.tabBar.tintColor = UIColor.orangeColor() // Change tab bar tint color to orange
                    self.presentViewController(mainTBC, animated: true, completion: nil)
                })
            } else {
                // Display error
                let alertController = UIAlertController(title: nil, message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    self.setControlsEnabled(true)
                    self.setLoginButtonEnabled(false)
                }))

                dispatch_async(dispatch_get_main_queue(), {
                    hud.hide(true)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
                
                print(errorString)
            }
        }
    }
    
    // MARK: Configure UI
    
    func configureUI() {
        facebookLoginButton.backgroundColor = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1.0)
        facebookLoginButton.backingColor = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1.0)
        
        loginButton.backgroundColor = UIColor(red: 238/255.0, green: 62/255.0, blue: 10/255.0, alpha: 1.0)
        loginButton.backingColor = UIColor(red: 238/255.0, green: 62/255.0, blue: 10/255.0, alpha: 1.0)
        loginButton.highlightedBackingColor = UIColor.redColor()
    }
    
    func setLoginButtonEnabled(enabled: Bool) {
        loginButton.enabled = enabled
        
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    func setControlsEnabled(enabled: Bool) {
        emailTextField.enabled = enabled
        passwordTextField.enabled = enabled
        setLoginButtonEnabled(enabled)
        facebookLoginButton.enabled = enabled
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // Clear password before editing begins
        if textField == passwordTextField {
            textField.text = ""
            setLoginButtonEnabled(false)
        }
        
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // Disable login button if email or password is empty
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !(range.location == 0 && string == "") {
            setLoginButtonEnabled(true)
        } else {
            setLoginButtonEnabled(false)
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            setControlsEnabled(false)
            login()
        }
        
        return true
    }
    
}



















