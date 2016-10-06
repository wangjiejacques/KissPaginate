//
//  ViewController.swift
//  KissPaginate
//
//  Created by WANG Jie on 10/05/2016.
//  Copyright (c) 2016 WANG Jie. All rights reserved.
//

import UIKit
import KissPaginate

class ViewController: PaginateViewController {

    @IBOutlet weak var noElementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshElements()
    }

    override var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements: elements, hasMoreElements: true)
        }
    }

    override func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.hidden = !noElement
    }
}

extension ViewController: UITableViewDataSource {
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
