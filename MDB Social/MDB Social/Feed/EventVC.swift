//
//  EventVC.swift
//  MDB Social
//
//  Created by Neel Ayon Sen on 11/3/21.
//

import UIKit

class EventVC: UIViewController {
    
    static let reuseIdentifier: String = String(describing: EventVC.self)

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
        view.backgroundColor = .purple
        view.addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(photoLabel)
        stack.addArrangedSubview(startLabel)
        stack.addArrangedSubview(rsvpLabel)
        stack.addArrangedSubview(creatorLabel)
        stack.addArrangedSubview(startDateLabel)
        stack.addSubview(backButton)
        // Do any additional setup after loading the view.
    }
    
    private let nameLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 30)
         label.textColor = .white
         label.textAlignment = .center
         label.numberOfLines = 1

         label.text = "Name: "
         return label
     }()
     
     private let descriptionLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 30)
         label.textColor = .white
         label.textAlignment = .center
         
         label.numberOfLines = 1
         label.text = "Health: "
         return label
     }()
     
     private let photoLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 30)
         label.textColor = .white
         label.textAlignment = .center
         label.numberOfLines = 1
         label.text = "Types: "
         return label
     }()
     
     private let startLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 30)
         label.textColor = .white
         label.textAlignment = .center
         label.numberOfLines = 1
         label.text = "Attack: "
         return label
     }()
     
    private let creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Attack: "
        return label
    }()
    private let rsvpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Attack: "
        return label
    }()
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Attack: "
        return label
    }()
    
    private let backButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.isUserInteractionEnabled = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    @objc func didTapBack(_ sender: UIButton) {
        backButton.showLoading()

        guard let window = UIApplication.shared
                .windows.filter({ $0.isKeyWindow }).first else { return }
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
        window.rootViewController = vc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
