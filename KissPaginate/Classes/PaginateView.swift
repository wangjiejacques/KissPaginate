//
//  PaginateView.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

public protocol PaginateView: Paginatable {
    var paginatePresenter: PaginatePresenter! { get set }
    var refreshControl: UIRefreshControl! { get set }
    var bottomRefresh: UIActivityIndicatorView! { get set }
    weak var tableView: UITableView! {get set }

    func reloadElements()
    func refreshElements()
    func getElement<T>(_ type: T.Type, at index: Int) -> T
    func getElements<T>(_ type: T.Type) -> [T]
}

extension PaginateView where Self: UIViewController {

    public var elements: [Any] {
        return paginatePresenter.elements
    }

    public func addRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(paginatePresenter, action: #selector(PaginatePresenter.refreshElements), for: .valueChanged)
        tableView.addSubview(refreshControl)

        bottomRefresh = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        bottomRefresh.color = UIColor.gray
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
        // without this code, somethings the bottom cell is not showing.
        var contentOffset = self.tableView.contentOffset
        guard contentOffset.y > 0 else {
            return
        }
        contentOffset.y += 10
        self.tableView.setContentOffset(contentOffset, animated: true)
    }

    public func refreshElements() {
        paginatePresenter.refreshElements()
    }

    public func loadNextPage() {
        paginatePresenter.loadNextPage()
    }

    public func getElement<T>(_ type: T.Type, at index: Int) -> T {
        return elements[index] as! T
    }

    public func getElements<T>(_ type: T.Type) -> [T] {
        return elements.map { $0 as! T }
    }
}
