//
//  Utils.swift
//  Pods
//
//  Created by WANG Jie on 06/10/2016.
//
//

import Foundation

public func delay(_ delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
