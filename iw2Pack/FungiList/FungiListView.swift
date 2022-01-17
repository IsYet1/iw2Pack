//
//  FungiListView.swift
//  FungiFinder
//
//  Created by Mohammad Azam on 11/3/20.
//

import SwiftUI
import UIKit
//import URLImage

enum SourceType {
    case photoLibrary
    case camera
}

struct FungiListView: View {
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var originalImage: UIImage? = nil
    @State private var name: String = ""
    @State private var showActionSheet: Bool = false
    @State private var sourceType: SourceType = .photoLibrary
    
    @StateObject private var fungiListVM = FungiListViewModel()
    
    private func saveFungi() {
        DispatchQueue.main.async {
            fungiListVM.loadingState = .loading
        }

//        if let originalImage = originalImage {
            // .resized is an extension function
//            if let resizedImage = originalImage.resized(width: 1024) {
//                if let data = resizedImage.pngData() {
//                    fungiListVM.uploadPhoto(data: data) { (url) in
//                        if let url = url {
//                            print(url)
//                            fungiListVM.save(name: name, url: url) { error in
//                                if let error = error {
//                                    DispatchQueue.main.async {
//                                        fungiListVM.loadingState = .failure
//                                    }
//                                    print(error.localizedDescription)
//                                } else {
//                                    DispatchQueue.main.async {
//                                        fungiListVM.loadingState = .success
//                                    }
//                                    fungiListVM.getAllFungiForUser()
//                                }
//                                image = nil
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                if fungiListVM.fungi.count > 0 {
                    List (fungiListVM.fungi, id: \.fungiId) {fungi in
                        FungiCell(fungi: fungi)
                    }
                } else if fungiListVM.loadingState == .success && fungiListVM.fungi.count == 0 {
//                    EmptyFungiView()
                }
                Spacer()
            }
            
//            LoadingView(loadingState: fungiListVM.loadingState)
            
            if image != nil {
                PhotoPreviewView(image: $image, name: $name, save: {
                    saveFungi()
                }) // Add shadow here. See lesson 52
            }
                       
        }.navigationTitle("Fungi")
        .navigationBarItems(trailing: Button(action: {
            // show camera
            showActionSheet = true
        }, label: {
            Image(systemName: "camera")
                .font(.title)
        })
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("Select"), message: nil, buttons: [
                .default(Text("Photo Library")) {
                    showImagePicker = true
                    sourceType = .photoLibrary
                },
                .default(Text("Camera")) {
                    showImagePicker = true
                    sourceType = .camera
                },
                .cancel()
            ])
        })
        
        
        )
        .sheet(isPresented: $showImagePicker, content: {
//            PhotoCaptureView(showImagePicker: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
        })
    .onAppear(perform: {
        fungiListVM.getAllFungiForUser()
    })
    }
}

struct FungiListView_Previews: PreviewProvider {
    static var previews: some View {
        FungiListView() //.embedInNavigationView()
    }
}

struct PhotoPreviewView: View {
    
    @Binding var image: Image?
    @Binding var name: String
    let save: () -> Void
    
    var body: some View {
        
        
        ZStack {
            VStack {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    
                    TextField("Enter name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                   
                    Button("Save") {
                        save()
                        image = nil
                    }.buttonStyle(.bordered)
            }.padding()
        }.background(Color(#colorLiteral(red: 0.904804647, green: 0.9049565196, blue: 0.904784739, alpha: 1)))
        
        .cornerRadius(10)
        .offset(y: 0)
        .padding()
        
    }
}

struct FungiCell0: View {
    
    var body: some View {
        Text("Fungi Cell")
        /*
        VStack {
            URLImage(url: URL(string: fungi.photoUrl)!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }.clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            
            Text(fungi.name)
                .font(.headline)
        } */
    }
}

struct FungiCell: View {
    let fungi: FungiViewModel
    
    var body: some View {
        VStack {
//            URLImage(URL(string: fungi.photoUrl)!) { image in
//                image.resizable().aspectRatio(contentMode: .fit)
//            }.clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            Text(fungi.name).font(.headline)
        }
    }
}
