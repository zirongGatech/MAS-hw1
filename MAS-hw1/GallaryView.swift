//
//  ProfileView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

let testData = [
    MyImage(author: "ren", uploadTime: "2020-01-01 00:00:00", filename:"temp"),
    MyImage(author: "zirong", uploadTime: "2020-01-02 00:00:00", filename:"temp"),
    MyImage(author: "ren", uploadTime: "2020-01-03 00:00:00", filename:"temp")
]

struct GallaryView: View {
    
    @EnvironmentObject var signinViewModel: SignInViewModel
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType
        = .camera
    
    @State var image: UIImage?
    @State var imagelist: [UIImage] = [UIImage]()
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    ScrollView{
                        
                    }
                }
                
                Button("Upload"){
                    print("Upload succeed")
                    print(Auth.auth().currentUser?.email ?? "")
                }
                Spacer()
                Button(action: {signinViewModel.signOut()}, label: {
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
        GallaryView()
    }
}
