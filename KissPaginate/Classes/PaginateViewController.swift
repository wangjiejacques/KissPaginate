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

class PaginateViewController: UIViewController {

    typealias GetElementsSuccessHandler = (elements: [AnyObject], hasMoreElements: Bool) -> Void

    var elements: [AnyObject]!
    private var refreshControl: UIRefreshControl!
    private var bottomRefresh: UIActivityIndicatorView!
    private var hasMoreElements = true
    private var currentPage = 0
    private var isLoadingNextPage = false
    private var isRefreshing = false
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        elements = []
        super.viewDidLoad()
        addRefresh()
    }

    var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        preconditionFailure()
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        preconditionFailure()
    }

    private func addRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.greenColor()
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

    func startFullScreenRefresh() {

    }

    func endFullScreenRefresh() {
        
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
        isRefreshing = false
        endFullScreenRefresh()
    }



    // if you want to show elements in view did load, call this method.
    func refreshElements() {
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


    // you should call this method manually.
    func loadNextPage() {
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
    func getElement<T>(type: T.Type, at index: Int) -> T {
        return elements[index] as! T
    }

    func getElements<T>(type: T.Type) -> [T] {
        return elements.map { $0 as! T }
    }
}
