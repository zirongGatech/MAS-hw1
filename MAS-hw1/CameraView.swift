//
//  CameraView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI

struct CameraView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType
        = .camera
    
    @State var image: UIImage?
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("There is an image")
                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                    .resizable().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
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
                
                .navigationTitle("Camera View")
            }
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
