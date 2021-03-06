//
//  CameraView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import CryptoKit

struct CameraView: View {
    
    private var db = Firestore.firestore()
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType
        = .camera
    
    @State var image: UIImage?
    var username: String = "anonymous"
    
    var body: some View {
        
        NavigationView {
            VStack{
                Spacer()
                
                Image(uiImage: image ?? UIImage(named: "gallery")!)
                    .resizable().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                // Button for choosing picture
                Button("Choose Picture"){
                    self.showSheet = true
                }.padding()
                .actionSheet(isPresented: $showSheet, content: {
                    ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                    .default(Text("Photo Library")){
                        self.showImagePicker = true
                        self.sourceType = .photoLibrary
                    },
                    .default(Text("Camera")) {
                        self.showImagePicker = true
                        self.sourceType = .camera
                    },
                    .cancel()])
                })
                
                
                Spacer()
                
                // Button for uploading image
                Button(action: {
                    if let thisImage = self.image {
                        uploadImage(image: thisImage)
                    } else{
                        print("couldn't upload image - no image present")
                    }
                    
                }, label: {
                    Text("Upload")
                })
                Spacer()
                    
                .navigationTitle("Pick Your Photo")


            }
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

func uploadImage(image:UIImage){
    if let imageData = image.jpegData(compressionQuality: 0.5){
        let storage=Storage.storage()
        if let email=Auth.auth().currentUser?.email {
            let time = getCurrentTime()
            let filename=getHashString(inputString: email + time) + ".jpg"
            
            // upload image
            let imgRef = storage.reference(withPath: filename)
            
            imgRef.putData(imageData, metadata: nil){
                (data, err) in
                if let err = err{
                    print("an error has occured - \(err.localizedDescription)")
                    
                }else{
                    print("image uploaded successfully")
//                    print("Meta \(data)")
                    imgRef.downloadURL { (url, err) in
                        // databse
                        let imageDictionary = [
                            "author": email,
                            "uploadTime": time,
                            "filename": filename,
                            "url": String(describing: url?.absoluteString)
                        ]
                        let docRef = Firestore.firestore().document("myimages/\(UUID().uuidString)")
                        print("Sending data")
                        docRef.setData(imageDictionary){(error) in
                            if let error = error {
                                print("error = \(error)")
                            } else {
                                print("data upload successfully")
                            }
                        }
                    }
                }
            }
            
            
            
        } else{
            print("no current user find, please quit sign in again")
        }
        
    }else{
        print("could not unwrap/case image to data")
    }
}

func getCurrentTime() -> String{
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = Date()
    return dateFormatter.string(from: date)
}

func getHashString(inputString: String) -> String{
    let inputData = Data(inputString.utf8)
    let hashed = SHA256.hash(data: inputData)
    return hashed.compactMap{ String(format: "%02x", $0)}.joined()
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
