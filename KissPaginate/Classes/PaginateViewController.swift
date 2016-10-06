//
//  PaginateViewController.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

import UIKit


public typealias GetElementsSuccessHandler = (elements: [AnyObject], hasMoreElements: Bool) -> Void

/// generic classes not works well

public class PaginateViewController: UIViewController {
    public var presenter: PaginatePresenter!
    public var refreshControl: UIRefreshControl!
    public var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet public weak var tableView: UITableView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter = PaginatePresenter(paginatable: self)
        presenter.start()
    }
}

extension PaginateViewController: PaginateView {
    /// Override this method to implement your web service call.
    public var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        preconditionFailure("Override this method")
    }

    /// Override this method to show/hide a view if there are elements returned by the web service
    ///
    /// - parameter noElement: if we have elements returned by web service or not.
    public func displayNoElementIfNeeded(noElement: Bool) {
        preconditionFailure("Override this method")
    }
}
