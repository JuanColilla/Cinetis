//
//  UIImageView+Extension.swift
//  IF-BasetisAPP
//
//  Created by Ivet Acosta on 20/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(from imageURL: String, placeholderImageName: String) {
        self.image = UIImage(named: placeholderImageName)
        if let url = URL(string: imageURL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
