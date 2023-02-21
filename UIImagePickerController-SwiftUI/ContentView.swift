//
//  ContentView.swift
//  UIImagePickerController-SwiftUI
//
//  Created by Ikmal Azman on 21/02/2023.
// https://www.appcoda.com/swiftui-camera-photo-library/

import SwiftUI

struct ContentView: View {
    /// `isShowPhotoLibrary`: variable to control visibility of the photo library
    @State var isShowPhotoLibrary = false
    
    /// ` image`: variable to store selected image
    @State var image = UIImage()
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            Button {
                /// Toggle the state of `isShowPhotoLibrary`
                self.isShowPhotoLibrary.toggle()
            } label: {
                Label("Photo Library", systemImage: "photo")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        /// in `iOS 14 and above`, we should user PHViewController to access photo library.
        /// .sheet(): modifier to present a sheet(Present Modally)
        /// isPresented: Binding boolean value to determin if the sheet should be presented or else
        .sheet(isPresented: $isShowPhotoLibrary) {
            /// Present the image picker with access to Photo Library. To access Camera, we need to change the sourceType to `.camera` and add the `Privacy Usage Description`
            ImagePicker(selectedImage: $image, sourceType: .photoLibrary)
            
            // ImagePicker(selectedImage: $image, sourceType: .camera)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
