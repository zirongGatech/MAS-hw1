//
//  ProfileView.swift
//  MAS-hw1
//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct GallaryView: View {
    
    @EnvironmentObject var signinViewModel: SignInViewModel
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType
        = .camera
    
    @State var image: UIImage?
    @State var imagelist: [UIImage] = [UIImage]()
    
    @ObservedObject private var viewModel = ImageViewModel()
    let download_agent = DownloadImageViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.myImages){ image in
                    VStack(alignment: .leading){
                        Text(image.author) 
                            .font(.headline)
                        Text(image.uploadTime)
                            .font(.subheadline)

                        Image(uiImage: download_agent.fileImageMap[image.filename] ?? UIImage()).resizable().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
                    }.onAppear(){download_agent.download(filename: image.filename)}
                        
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
                    .onAppear(){
                        self.viewModel.fetchData()
                    }
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
