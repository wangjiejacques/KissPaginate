//
//  PaginateViewController.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

import UIKit


public typealias GetElementsSuccessHandler = (_ elements: [Any], _ hasMoreElements: Bool) -> Void

/// generic classes not works well

open class PaginateViewController: UIViewController, PaginateView {
    open var paginatePresenter: PaginatePresenter!
    open var refreshControl: UIRefreshControl!
    open var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet open weak var tableView: UITableView!

    override open func viewDidLoad() {
        super.viewDidLoad()
        paginatePresenter = PaginatePresenter(paginatable: self)
        paginatePresenter.start()
    }
}

extension PaginateViewController {
    /// Override this method to implement your web service call.
    open var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (Error) -> Void) -> Void {
        preconditionFailure("Override this method")
    }

    /// Override this method to show/hide a view if there are elements returned by the web service
    ///
    /// - parameter noElement: if we have elements returned by web service or not.
    open func displayNoElementIfNeeded(noElement: Bool) {
        preconditionFailure("Override this method")
    }
}
