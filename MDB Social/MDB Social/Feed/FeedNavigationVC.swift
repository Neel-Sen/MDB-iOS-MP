//
//  FeedNavigationVC.swift
//  MDB Social
//
//  Created by Michael Lin on 2/25/21.
//

import UIKit
// This is for Sign Up
class FeedNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(enterNameField)
        view.addSubview(setUsernameField)
        view.addSubview(setEmailField)
        view.addSubview(setPasswordField)
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([])
        
        signupButton.layer.cornerRadius = signinButtonHeight / 2
        
        signupButton.addTarget(self, action: #selector(didTapSignIn(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
    }

    private let setEmailField: AuthTextField = {
        let tf = AuthTextField(title: "Enter Email:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let setUsernameField: AuthTextField = {
        let tf = AuthTextField(title: "Set Username:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let enterNameField: AuthTextField = {
        let tf = AuthTextField(title: "Enter Full Name:")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let setPasswordField: AuthTextField = {
        let tf = AuthTextField(title: "Set Password:")
        //hide the password?
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let signupButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.primary.cgColor
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    
    private let signinButtonHeight: CGFloat = 36
    
    @objc func didTapSignUp(_ sender: UIButton) {
        guard let email = setEmailField.text, email != "" else {
            showErrorBanner(withTitle: "Missing email",
                            subtitle: "Please provide your email address")
            return
        }
        guard let username = setUsernameField.text, username != "" else {
            showErrorBanner(withTitle: "Missing username",
                            subtitle: "Please enter a username")
            return
        }
        guard let name = enterNameField.text, name != "" else {
            showErrorBanner(withTitle: "Missing name",
                            subtitle: "Please provide your full name")
            return
        }
        guard let password = setPasswordField.text, password != "" else {
            showErrorBanner(withTitle: "Missing password",
                            subtitle: "Please enter a password")
            return
        }
        
        signupButton.showLoading()
        FIRAuthProvider.shared.signIn(withEmail: email, password: password) { [weak self] result in
            
            defer {
                self?.signupButton.hideLoading()
            }
            
            switch result {
            case .success:
                guard let window = UIApplication.shared
                        .windows.filter({ $0.isKeyWindow }).first else { return }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
            case .failure(let error):
                switch error {
                case .invalidEmail:
                    self?.showErrorBanner(withTitle: "Invalid email",
                                          subtitle: "Please check your email and try again")
                default:
                    return
                }
            }
        }
    }
}
