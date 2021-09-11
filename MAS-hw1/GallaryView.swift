//
//  ProfileView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation

import SwiftUI

struct GallaryView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType
        = .camera
    
    @State var image: UIImage?
    @State var imagelist: [UIImage] = []
    var username: String
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    ScrollView{
                        
                    }
                }
                
                Button("Upload"){
                    print("Upload succeed")
                    print(self.username)
                }
                Spacer()
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("sign out").foregroundColor(.red)
                    })
                Spacer()
                
                .navigationBarTitle(Text("Gallary"), displayMode: .inline)
                .navigationBarItems(trailing: HStack{
                    NavigationLink(
                        destination: CameraView(),
                        label: {
                            Text("Upload photo")
                        })
                })
            }
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(image: $image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GallaryView(username: String("aaa"))
    }
}
