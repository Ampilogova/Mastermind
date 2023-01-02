//
//  NSObject.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import Foundation

extension NSObject {

    public var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }

    public static var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
