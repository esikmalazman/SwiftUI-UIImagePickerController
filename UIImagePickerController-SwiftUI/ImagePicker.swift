//
//  ImagePicker.swift
//  UIImagePickerController-SwiftUI
//
//  Created by Ikmal Azman on 21/02/2023.
//

import UIKit
import SwiftUI


/// `UIViewControllerRepresentable`: Protocol that allow to Wrap UIVC into SwiftUI
struct ImagePicker : UIViewControllerRepresentable {
    
    
    /// `selectedImage`: Binding property that store selected image and pass to the source of truth, i.e @State
    @Binding var selectedImage : UIImage
    
    /// `presentationMode`: Environment property that allow to read and change the View state. In this case, we check presentationMode of this View state environment which we can use to dismiss the VC
    @Environment(\.presentationMode) private var presentationMode
    
    /// `sourceType`: variable to store source type we want to access from UIImagePickerController, i.e Camera, Photos Library
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    /// `makeUIViewController()`: method that require to configure initial state of the UIKit VC, in this case UIImagePickerController
    /// - Returns: UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        /// Create a UIImageController object with its configuration
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        /// Assign Coordinator object of UIViewControllerRepresentable to handle UIImagePickerController Delegate.
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    
    /// `updateUIViewController()`: method that called when state of app changes which effect the UIKit VC, i.e. UIImagePickerController.
    ///  We can use this method to update the UIImagePickerController, but it is optional. If nothing to update, we can leave the method empty
    /// - Parameters:
    ///   - uiViewController: UIImagePickerController
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    /// `makeCoordinator()`: method allow to communicate UIKit VC delegate with SwiftUI. In this case, we provide the Coordinator object that have implementation for `UIImagePickerControllerDelegate`.
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

extension ImagePicker {
    
    /// To adopt protocol in wrapper of specific UIKit VC,  we need to make a `Coordinator` object which acts as a bridge between the VC Delegate and SwiftUI. Then, we need to provide the `Coordinator` object to UIViewControllerRepresentable method  which is `makeCoordinator()` method.
    /// This `Coordinator` adopt protocol of `UIImagePickerControllerDelegate & UINavigationControllerDelegate`.
    /// It also implement the method of  `UIImagePickerControllerDelegate` which is `imagePickerController(_ picker:, didFinishPickingMediaWithInfo info:)` which will be call when image selected.
    final class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent : ImagePicker
        
        
        /// The init takes ImagePicker object, so we can pass selectedImage & use it presentation mode to dismiss  the View
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            /// Retrieve the image
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            /// Assign the image to Parent of Coordinator
            parent.selectedImage = image
            
            /// Dismiss the Photo Library
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
