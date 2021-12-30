//
//  FirebaseManager.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

class FirestoreManager: ObservableObject{
    @Published var scansArray: [Scans] = []
    
    init(){
        fetchAllScans()
    }
    
    func fetchAllScans(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("\(uid)").getDocuments { querySnapshots, error in
            if let err = error{
                print(err.localizedDescription)
                return
            }
            if let qSnaps = querySnapshots{
                for doc in qSnaps.documents{
                    print(doc.documentID)
                    if doc.data() != nil{
                        let data = doc.data()
                        print("Heres the data -> \(data)")
                        let image = WebImage(url: URL(string: data["image"] as! String))
                        self.scansArray.append(
                            Scans(prediction: data["prediction"] as! String,
                                  lungsImage: image,
                                  covPerc: data["covidPerc"] as? Double ?? 0.0,
                                  pnePerc: data["pneumoniaPerc"] as? Double ?? 0.0,
                                  norPerc: data["normalPerc"] as? Double ?? 0.0,
                                  date: data["date"] as! String)
                        )
                    }
                    
                }
            }
        }
    }
}
