//
//  PaginateView.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

public protocol PaginateView: class {
    
    func addRefresh()

    func endRefreshing()

    func startFullScreenRefresh()

    func endFullScreenRefresh()

    func stopBottomRefresh()

    func startBottomRefresh()

    func reloadElements()

    var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void { get }

    func displayNoElementIfNeeded(noElement: Bool)
}
