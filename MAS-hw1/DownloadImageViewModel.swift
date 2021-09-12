//
//  DownloadImageViewModel.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class DownloadImageViewModel: ObservableObject {
    @Published var fileImageMap: [String: UIImage] = [:]
    
    
    
    func download(filename:String) {
        Storage.storage().reference().child(filename).getData(maxSize: 1024*1024*1024){
            (imageData, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                if let imageData = imageData{
                    if let comeimage = UIImage(data:imageData){
                        self.fileImageMap[filename] = comeimage
                    }
                    
                } else{
                    print("could not unwrap image data image")
                }
            }
        }
    }
    
}
