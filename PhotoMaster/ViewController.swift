//
//  ViewController.swift
//  PhotoMaster
//
//  Created by Yuma Ishibashi on 2021/05/12.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTappedCameraButton() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func onTappedTextButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedIllustButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    @IBAction func onTappedUploadButton() {
        if photoImageView.image != nil {
            
            let activityVC = UIActivityViewController(activityItems: ["Photo master!",photoImageView.image!], applicationActivities: nil)
            if UIDevice.current.userInterfaceIdiom == .pad {
                let screenSize = UIScreen.main.bounds
                activityVC.popoverPresentationController?.sourceView = self.view
                activityVC.popoverPresentationController?.sourceRect = CGRect(x:screenSize.size.width/2, y: screenSize.size.height-200, width: 0, height: 0)
            }
            
            self.present(activityVC, animated: true, completion: nil)
        }else {
            print("画像がありません")
        }
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    func drawText(image: UIImage) -> UIImage{
        let text = "LifeisTech!"
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedString.Key.foregroundColor: UIColor.red
        ]
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x:0, y:0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        let maskImage = UIImage(named:  "furo_ducky")!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x:0, y:0, width: image.size.width, height: image.size.height))
        let maskRect = CGRect(x: image.size.width - UIImage(named:  "furo_ducky")!.size.width,
                              y: image.size.height - UIImage(named:  "furo_ducky")!.size.height,
                              width: UIImage(named:  "furo_ducky")!.size.width, height: UIImage(named:  "furo_ducky")!.size.height)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

