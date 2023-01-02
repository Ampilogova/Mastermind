//
//  UIView .swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/23/22.
//

import UIKit

extension UIView {
    
    public func makeRounded() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
    public func makeRoundedButton() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
