//
//  WithPaginateView.swift
//  KissPaginate
//
//  Created by WANG Jie on 06/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KissPaginate

class WithPaginateView: UIViewController, PaginateView {

    var presenter: PaginatePresenter!
    var refreshControl: UIRefreshControl!
    var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noElementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PaginatePresenter(paginatable: self)
        presenter.start()
        tableView.dataSource = self
        refreshElements()
    }

    var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements: elements, hasMoreElements: true)
        }
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.hidden = !noElement
    }
}

extension WithPaginateView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        let element = getElement(String.self, at: indexPath.row)
        cell.textLabel?.text = element
        if elements.count == indexPath.row + 1 {
            loadNextPage()
        }
        return cell
    }
}
