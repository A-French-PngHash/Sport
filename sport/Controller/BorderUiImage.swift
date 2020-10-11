//
//  BorderUiImage.swift
//  sport
//
//  Created by Titouan Blossier on 10/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

import UIKit

extension UIImage {
    func drawOutlie(imageKeof: CGFloat = 1.01, color: UIColor) -> UIImage? {

        let outlinedImageRect = CGRect(x: 0.0, y: 0.0,
                                   width: size.width * imageKeof,
                                   height: size.height * imageKeof)

        let imageRect = CGRect(x: size.width * (imageKeof - 1) * 0.5,
                           y: size.height * (imageKeof - 1) * 0.5,
                           width: size.width,
                           height: size.height)

        UIGraphicsBeginImageContextWithOptions(outlinedImageRect.size, false, imageKeof)

        draw(in: outlinedImageRect)

        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        context.setBlendMode(.sourceIn)
        context.setFillColor(color.cgColor)
        context.fill(outlinedImageRect)
        draw(in: imageRect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
