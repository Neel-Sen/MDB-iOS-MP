//
//  EventVC.swift
//  MDB Social
//
//  Created by Neel Ayon Sen on 11/3/21.
//

import UIKit
import Foundation
import FirebaseStorage
import FirebaseFirestore

class EventVC: UIViewController {
    //displays all events
    private let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .equalSpacing
            stack.spacing = 20
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        var currEvent: Event? {
            didSet {
                let gsReference: StorageReference = FIRStorage.shared.storage.reference(forURL: currEvent!.photoURL)
                gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("bad stuff happened: \(error)")
                      } else {
                        self.imageView.image = UIImage(data: data!)
                      }
                }
                
                nameEvent.text = currEvent!.name
                rsvpd.text = "RSVP'd: \(currEvent?.rsvpUsers.count ?? 0)"
                let docRef = FIRDatabaseRequest.shared.db.collection("users").document(currEvent!.creator)
                docRef.getDocument(completion: { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting docuemnt of event creator: \(err)")
                    } else {
                        guard let user = try? querySnapshot?.data(as: User.self) else {
                            print("error in getting user of creator")
                            return
                        }
                        self.nameCreator.text = "Creator: " + user.fullname
                        
                    }
                })
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm E, d MMM y"
                date.text = "Date: " + formatter.string(from: currEvent!.startDate)
                desc.text = currEvent?.description
                
                for id in currEvent!.rsvpUsers {
                    if (FIRAuthProvider.shared.currentUser?.uid == id) {
                        isRsvpd = true
                        break
                    }
                }
                if (currEvent?.creator == FIRAuthProvider.shared.currentUser?.uid) {
                    isCreator = true
                    print("current user is the creator")
                }
            }
        }
        
        private var isCreator: Bool = false
        
        private var isRsvpd: Bool = false
        
        private var imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        private var nameEvent: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var nameCreator: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 20)
            label.textColor = .gray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var date: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .gray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var rsvpd: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .gray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var desc: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .gray
            label.textAlignment = .center
            label.numberOfLines = 0 //unlimited # lines
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var rsvpBtn: UIButton = {
            let btn = UIButton()
            btn.backgroundColor = UIColor(red: 141/255, green: 153/255, blue: 174/255, alpha: 1)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
            btn.layer.cornerRadius = 20
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        private var deleteEvent: UIButton = {
            let btn = UIButton()
            btn.layer.cornerRadius = 15
            btn.backgroundColor = UIColor(red: 217/255, green: 4/255, blue: 41/255, alpha: 1)
            btn.setTitle("Delete Event", for: .normal)
            btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            btn.isHidden = true
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        private let contentEdgeInset = UIEdgeInsets(top: 70, left: 20, bottom: 30, right: 20)
        
        override func viewDidLoad() {
            view.backgroundColor = UIColor(red: 193/255, green: 211/255, blue: 254/255, alpha: 1)
            
            view.addSubview(deleteEvent)
            deleteEvent.addTarget(self, action: #selector(didTapDeleteEvent(_:)), for: .touchUpInside)
            NSLayoutConstraint.activate([
                deleteEvent.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
                deleteEvent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                deleteEvent.widthAnchor.constraint(equalToConstant: 110)
            ])
            
            if (isCreator) {
                deleteEvent.isHidden = false
            }
            
            if (isRsvpd) {
                rsvpBtn.setTitle("Cancel RSVP", for: .normal)
            } else {
                rsvpBtn.setTitle("RSVP!", for: .normal)
            }
            
            view.addSubview(stack)
            stack.addArrangedSubview(nameEvent)
            stack.addArrangedSubview(imageView)
            stack.addArrangedSubview(nameCreator)
            stack.addArrangedSubview(date)
            stack.addArrangedSubview(desc)
            stack.addArrangedSubview(rsvpd)
            stack.addArrangedSubview(rsvpBtn)
            rsvpBtn.addTarget(self, action: #selector(didTapRsvp(_:)), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentEdgeInset.left),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -contentEdgeInset.right),
                stack.topAnchor.constraint(equalTo: view.topAnchor, constant: contentEdgeInset.top),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
            
            
        }
        
        @objc func didTapRsvp(_ sender: UIButton) {
            let eventRef = FIRDatabaseRequest.shared.db.collection("events").document(currEvent!.id!)
            print("path:" + eventRef.path)
            if (isRsvpd) {
                isRsvpd = false
                for i in 0..<currEvent!.rsvpUsers.count {
                    if currEvent?.rsvpUsers[i] == FIRAuthProvider.shared.currentUser?.uid {
                        eventRef.updateData([
                            "rsvpUsers": FieldValue.arrayRemove([currEvent!.rsvpUsers[i]])
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                        currEvent?.rsvpUsers.remove(at: i)
                        break
                    }
                }
                
                rsvpBtn.setTitle("RSVP!", for: .normal)
            } else {
                isRsvpd = true
                eventRef.updateData([
                    "rsvpUsers": FieldValue.arrayUnion([(FIRAuthProvider.shared.currentUser?.uid)!])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }

                currEvent?.rsvpUsers.append((FIRAuthProvider.shared.currentUser?.uid)!)
                rsvpBtn.setTitle("Cancel RSVP", for: .normal)
            }
            
    //        eventRef.updateData(["rsvpUsers": currEvent!.rsvpUsers], completion: { err in
    //            if let err = err {
    //                print("Error updating document: \(err)")
    //            } else {
    //                print("Document successfully updated")
    //            }
    //        })
    //        eventRef.updateData([
    //            "rsvpUsers": currEvent!.rsvpUsers
    //        ]) { err in
    //            if let err = err {
    //                print("Error updating document: \(err)")
    //            } else {
    //                print("Document successfully updated")
    //            }
    //        }
        }
        
        @objc func didTapDeleteEvent(_ sender: UIButton) {
            let eventRef = FIRDatabaseRequest.shared.db.collection("events").document(currEvent!.id!)
            eventRef.delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            dismiss(animated: true, completion: nil)
        }
        

}
