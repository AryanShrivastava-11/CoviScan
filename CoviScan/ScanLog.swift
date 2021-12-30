//
//  ScanLog.swift
//  CoviScan
//
//  Created by Aryan Shrivastava on 29/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

struct ScanLog: View {
    
    @State var covPerc = 0
    
    @ObservedObject var manager = FirestoreManager()
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(manager.scansArray) { scan in
                    RowView(scan: scan)
                }
            }
            .navigationTitle("My Scans")
            .background(Color("background2").ignoresSafeArea())
        }
        
    }
}

struct ScanLog_Previews: PreviewProvider {
    static var previews: some View {
        ScanLog()
//            .preferredColorScheme(.dark)
    }
}

struct Scans: Identifiable{
    var id = UUID()
    var prediction: String
    var lungsImage: WebImage
    var covPerc: Double
    var pnePerc: Double
    var norPerc: Double
    var date: String
}

struct RowView: View {
    var scan: Scans
    
    var body: some View {
        ZStack {
            
            HStack {
                VStack(alignment: .center) {
                    Text("\(scan.prediction)")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .bold))
                        .font(.headline)
                    //                            .background(Color.gray.offset(y:15))
//                    Image(uiImage: #imageLiteral(resourceName: "Testing Image"))
                    scan.lungsImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .padding(.horizontal)
                    
                    Text("\(scan.date)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .bold()
                }
                
                VStack {
                    VStack(alignment: .leading,spacing: 15) {
                        
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.orange)
                            Text("Covid: \(String(format: "%.2f", scan.covPerc))%")
                                .foregroundColor(.black)
                        }
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.blue)
                            Text("Pneumonia: \(String(format: "%.2f", scan.pnePerc))%")
                                .foregroundColor(.black)
                        }
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.green)
                            Text("Normal: \(String(format: "%.2f", scan.norPerc))%")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 05, y: 5)
            
            HStack {
                Spacer()
                VStack {
//                    Button {
//                       deleteFunction()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .frame(width: 36, height: 36)
//                            .foregroundColor(.primary)
//                            .background(Color("background2"))
//                        .clipShape(Circle())
//                    }
                    Spacer()
                }
            }
            .padding(30)
        }
        
        
        
    }
    private func deleteFunction(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docID = Firestore.firestore().collection("\(uid)").document().documentID
        print(docID)
        Firestore.firestore().collection("\(uid)").document("\(docID)").delete { error in
            if let err = error{
                print("Error while deleting data: \(err.localizedDescription)")
                return
            }
            print("Deletion was successful")
        }
        
    }
}
