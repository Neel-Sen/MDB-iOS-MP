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
    
    func getEvents() -> [Event] {
        var eventsList: [Event] = []
        let _ = db.collection("events").addSnapshotListener{querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error getting documents from snapshot")
                return }
            for document in documents {
                
                guard let receivedEvent = try? document.data(as: Event.self) else {
                    print("document event doesn't exist")
                    return
                }
                eventsList.append(receivedEvent)
            }
        }
        return eventsList
    }
}
