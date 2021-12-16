//
//  String+Extension.swift
//  IF-BasetisAPP
//
//  Created by Fatima Syed on 04/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
