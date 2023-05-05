//
//  PhotoSelector.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import Foundation
import UIKit

class PhotoSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var VC: ViewController
    var model: PosterSetUpModel

    init(presentOver: ViewController, imageFor: PosterSetUpModel){
        VC = presentOver
        model = imageFor
        super.init()
    }
    
    func openPhotoPicker() {
        print("Opening photo picker")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            VC.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("picked image")
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        model.setUpPosterWithImage(image)
        picker.dismiss(animated: true)
    }
    
}
