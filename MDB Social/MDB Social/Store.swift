//
//  Store.swift
//  MDB Social
//
//  Created by Neel Ayon Sen on 13/4/21.
//

import Foundation
import Firebase

class Store {

    static let shared = Store()
       
    let storage = Storage.storage()
       
    let metadata: StorageMetadata = {
           let newMetadata = StorageMetadata()
           newMetadata.contentType = "image/jpeg"
           return newMetadata
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
