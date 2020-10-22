//
//  Images.swift
//  Eyes
//
//  Created by Lucas Frazão on 22/10/20.
//

import UIKit
import Foundation

//@IBDesignable
class Blur: UIImageView {

    @IBInspectable var blurImage:UIImage?{
        didSet{
            updateImage(imageBlur: blurImage!)
        }
    }


    func updateImage(imageBlur:UIImage){
        let imageToBlur:CIImage = CIImage(image: imageBlur)!
        let blurFilter:CIFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(imageToBlur, forKey: "inputImage")
        let resultImage:CIImage = blurFilter.value(forKey: "outputImage")! as! CIImage
        //self.contentMode = .scaleAspectFill
        self.image = UIImage(ciImage: resultImage)
        
    }



    }
