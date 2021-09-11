//
//  CameraView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct CameraView: View {
    
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
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage=Storage.storage()
        storage.reference().child("temp").putData(imageData, metadata: nil){
            (data, err) in
            if let err = err{
                print("an error has occured - \(err.localizedDescription)")
                
            }else{
                print("image uploaded successfully")
            }
        }
    }else{
        print("could not unwrap/case image to data")
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
