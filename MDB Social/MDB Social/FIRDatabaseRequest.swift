//
//  FIRDatabaseRequest.swift
//  MDB Social
//
//  Created by Michael Lin on 2/25/21.
//

import Foundation
import FirebaseFirestore

class FIRDatabaseRequest {
    
    static let shared = FIRDatabaseRequest()
    
    let db = Firestore.firestore()
    
    func setUser(_ user: User, completion: (()->Void)?) {
        guard let uid = user.uid else { return }
        do {
            try db.collection("users").document(uid).setData(from: user)
            completion?()
        }
        catch { }
    }
    
    func setEvent(_ event: Event, completion: (()->Void)?) {
        guard let id = event.id else { return }
        
        do {
            try db.collection("events").document(id).setData(from: event)
            completion?()
        } catch { }
    }
    
    /* TODO: Events getter */
    
    func getEvent(_ event: Event, completion: (()->Void)?) {
        guard let id = event.id else { return }
        
        do {
            try db.collection("events").document(id).getDocument { (document, error) in
                let result = Result {
                    try document?.data(as: User.self)
                    }
                    switch result {
                    case .success(let city):
                        if let city = city {
                        } else {
                            // A nil value was successfully initialized from the DocumentSnapshot,
                            // or the DocumentSnapshot was nil.
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        // A `City` value could not be initialized from the DocumentSnapshot.
                        print("Error decoding city: \(error)")
                    }
            }
            completion?()
        } catch { }
    }
}
