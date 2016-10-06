//
//  Utils.swift
//  Pods
//
//  Created by WANG Jie on 06/10/2016.
//
//

import Foundation

public func delay(delay: Double = 0, closure: ()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
