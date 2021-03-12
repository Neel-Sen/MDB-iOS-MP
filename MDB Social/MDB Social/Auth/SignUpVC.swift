//
//  SignUpVC.swift
//  MDB Social
//
//  Created by Neel Ayon Sen on 10/3/21.
//

import UIKit
import NotificationBannerSwift

class SignUpVC: UIViewController {
//MARK: Can make this a stackview and copy directly from SignInVC
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)

    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    
    private let signupButtonHeight: CGFloat = 36

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 25

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .background
        /*enterNameField.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        view.addSubview(enterNameField)
        //setUsernameField.frame = CGRect(x: 300, y: 600, width: 200, height: 100)
        view.addSubview(setUsernameField)
        //setEmailField.frame = CGRect(x: 300, y: 900, width: 200, height: 80)
        view.addSubview(setEmailField)
        //setPasswordField.frame = CGRect(x: 300, y: 1100, width: 200, height: 80)
        view.addSubview(setPasswordField)
        //signupButton.frame = CGRect(x: 500, y: 1250, width: 100, height: 100)
        view.addSubview(signupButton) */
        // Do any additional setup after loading the view.
        
        //collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30))
        //collectionView.allowsSelection = true
        //collectionView.allowsMultipleSelection = false
        
        /*NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            enterNameField.topAnchor.constraint(equalTo: collectionView.topAnchor),
            setUsernameField.topAnchor.constraint(equalTo: enterNameField.bottomAnchor),
            setEmailField.topAnchor.constraint(equalTo: setUsernameField.bottomAnchor)
            
        ])*/
        view.addSubview(stack)
        stack.addArrangedSubview(enterNameField)
        stack.addArrangedSubview(setEmailField)
        stack.addArrangedSubview(setUsernameField)
        stack.addArrangedSubview(setPasswordField)
        
        NSLayoutConstraint.activate([ //this constraint makes shit weird
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: contentEdgeInset.left),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentEdgeInset.right),
                stack.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 60)
        ])
        view.addSubview(signupButton)
        NSLayoutConstraint.activate([
            signupButton.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            signupButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 30),
            signupButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: signupButtonHeight)
        ])
        signupButton.layer.cornerRadius = signupButtonHeight / 2
        signupButton.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
        
    
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
                            subtitle: "Please provide a password for your account")
            return
        }
        
        signupButton.showLoading()
        FIRAuthProvider.shared.signUp(email: email, password: password, fullName: name, username: username) { [weak self] result in
            
            defer {
                self?.signupButton.hideLoading()
            }
            
            switch result {
            case .success:
                guard let window = UIApplication.shared
                        .windows.filter({ $0.isKeyWindow }).first else { return }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() //should go back to feedvc
                window.rootViewController = vc
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
            case .failure(let error):
                switch error {
                case .emailAlreadyInUse:
                    self?.showErrorBanner(withTitle: "Email is already in use",
                                          subtitle: "Please use a different email")
                case .missingFields:
                    self?.showErrorBanner(withTitle: "There are missing fields", subtitle: "Please fill out all fields")
                case .weakPassword:
                    self?.showErrorBanner(withTitle: "Password is too weak", subtitle: "Please enter a password containing at least 1 letter, 1 number, and 1 special character")
                case .internalError:
                    self?.showErrorBanner(withTitle: "An internal error occured",
                                          subtitle: "Please try again later")
                default:
                    return
                }
            }
        }
    }
    private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
        guard bannerQueue.numberOfBanners == 0 else { return }
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                subtitleFont: subtitle != nil ?
                                                    .systemFont(ofSize: 14, weight: .regular) : nil,
                                                style: .warning)
        
        banner.show(bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                    cornerRadius: 10,
                    shadowColor: .primaryText,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 10)
    }
    
}
