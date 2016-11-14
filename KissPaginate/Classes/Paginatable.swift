//
//  Paginatable.swift
//  Pods
//
//  Created by WANG Jie on 06/10/2016.
//
//

import Foundation

public protocol Paginatable: class {
    func addRefresh()

    func endRefreshing()

    func startFullScreenRefresh()

    func endFullScreenRefresh()

    func stopBottomRefresh()

    func startBottomRefresh()

    func reloadElements()

    /// Override this method to implement your web service call.
    var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (Error) -> Void) -> Void { get }

    /// Override this method to show/hide a view if there are elements returned by the web service
    ///
    /// - parameter noElement: if we have elements returned by web service or not.
    func displayNoElementIfNeeded(noElement: Bool)
}
