//
//  PaginateViewController.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

import UIKit


/// generic classes not works well

public class PaginateViewController: UIViewController {

    public typealias GetElementsSuccessHandler = (elements: [AnyObject], hasMoreElements: Bool) -> Void

    public var elements: [AnyObject]!
    private var refreshControl: UIRefreshControl!
    private var bottomRefresh: UIActivityIndicatorView!
    private var hasMoreElements = true
    private var currentPage = 0
    private var isLoadingNextPage = false
    private var isRefreshing = false
    @IBOutlet public weak var tableView: UITableView!

    override public func viewDidLoad() {
        elements = []
        super.viewDidLoad()
        addRefresh()
    }


    /// Override this method to implement your web service call.
    public var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        preconditionFailure()
    }


    /// Override this method to show/hide a view if there are elements returned by the web service
    ///
    /// - parameter noElement: if we have elements returned by web service or not.
    public func displayNoElementIfNeeded(noElement: Bool) {
        preconditionFailure()
    }

    private func addRefresh() {
        refreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(refreshElements), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)

        bottomRefresh = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        bottomRefresh.color = UIColor.grayColor()
        stopBottomRefresh()
        tableView.tableFooterView = bottomRefresh
        startFullScreenRefresh()
    }

    private func stopBottomRefresh() {
        bottomRefresh.stopAnimating()
        bottomRefresh.frame.size.height = 0
    }

    private func startBottomRefresh() {
        bottomRefresh.startAnimating()
        bottomRefresh.frame.size.height = 70
        tableView.contentSize.height += bottomRefresh.frame.size.height
    }

    public func startFullScreenRefresh() {
        showActivityIndicator(inView: tableView)
    }

    public func endFullScreenRefresh() {
        hideActivityIndicator(inView: tableView)
    }

    private func endRefreshing() {
        refreshControl.endRefreshing()
        isRefreshing = false
        endFullScreenRefresh()
    }



    /// call this method to refresh elements.
    public func refreshElements() {
        if isRefreshing {
            return
        }
        isRefreshing = true
        getElementsClosure(page: 0, successHandler: { (elements, hasMoreElements) in
            self.currentPage = 0
            self.hasMoreElements = hasMoreElements
            self.elements = elements
            self.tableView.reloadData()
            self.endRefreshing()
            self.displayNoElementIfNeeded(elements.count == 0)
        }) { (error) in
            self.endRefreshing()
        }
    }


    /// call this method to load next page.
    public func loadNextPage() {
        if isLoadingNextPage {
            return
        }
        guard hasMoreElements else {
            return
        }
        isLoadingNextPage = true
        startBottomRefresh()
        getElementsClosure(page: currentPage+1, successHandler: { (elements, hasMoreElements) in
            self.elements = self.elements + elements
            self.hasMoreElements = hasMoreElements
            self.stopBottomRefresh()
            self.tableView.reloadData()
            var contentOffset = self.tableView.contentOffset
            contentOffset.y += 10
            self.tableView.setContentOffset(contentOffset, animated: true)
            self.currentPage += 1
            self.isLoadingNextPage = false
        }) { (error) in
            self.isLoadingNextPage = false
            self.stopBottomRefresh()
        }
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
