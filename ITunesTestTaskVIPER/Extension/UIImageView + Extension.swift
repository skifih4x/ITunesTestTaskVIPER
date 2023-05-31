//
//  UIImageView + Extension.swift
//  ITunesTestTaskVIPER
//
//  Created by Артем Орлов on 31.05.2023.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
