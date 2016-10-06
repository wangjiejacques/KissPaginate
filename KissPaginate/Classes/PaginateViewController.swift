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

    public var elements: [AnyObject] {
        return presenter.elements
    }

    var presenter: PaginatePresenter!
    private var refreshControl: UIRefreshControl!
    private var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet public weak var tableView: UITableView!

    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter = PaginatePresenter(paginateView: self)
        presenter.start()
    }

    public func refreshElements() {
        presenter.refreshElements()
    }

    public func loadNextPage() {
        presenter.loadNextPage()
    }
}

extension PaginateViewController: PaginateView {

    public func addRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(presenter, action: #selector(PaginatePresenter.refreshElements), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)

        bottomRefresh = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        bottomRefresh.color = UIColor.grayColor()
        tableView.tableFooterView = bottomRefresh
    }

    public func startFullScreenRefresh() {
        showActivityIndicator(inView: tableView)
    }

    public func endFullScreenRefresh() {
        hideActivityIndicator(inView: tableView)
    }

    public func endRefreshing() {
        refreshControl.endRefreshing()
        endFullScreenRefresh()
    }

    public func stopBottomRefresh() {
        bottomRefresh.stopAnimating()
        bottomRefresh.frame.size.height = 0
    }

    public func startBottomRefresh() {
        bottomRefresh.startAnimating()
        bottomRefresh.frame.size.height = 70
        tableView.contentSize.height += bottomRefresh.frame.size.height
    }


    public func reloadElements() {
        self.tableView.reloadData()
        var contentOffset = self.tableView.contentOffset
        contentOffset.y += 10
        self.tableView.setContentOffset(contentOffset, animated: true)
    }

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


extension PaginateViewController {
    public func getElement<T>(type: T.Type, at index: Int) -> T {
        return elements[index] as! T
    }

    public func getElements<T>(type: T.Type) -> [T] {
        return elements.map { $0 as! T }
    }
}
