//
//  ImageViewModel.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ImageViewModel: ObservableObject {
    @Published var myImages = [MyImage] ()
    @Published var myImageDownload = [DownloadImageViewModel] ()
    
    private var db = Firestore.firestore()
   
    
    func fetchData(){
        db.collection("myimages").whereField("author", isEqualTo: Auth.auth().currentUser?.email ?? "").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.myImages = documents.map { (queryDocumentSnapshot) -> MyImage in
                let data = queryDocumentSnapshot.data()
                let author = data["author"] as? String ?? ""
                let uploadTime = data["uploadTime"] as? String ?? ""
                let filename = data["filename"] as? String ?? ""
//                let dt = DownloadImageViewModel()
//                dt.download(filename: filename)
                
                return MyImage(author: author, uploadTime: uploadTime, filename: filename)
            }
            
        }
    }
}
