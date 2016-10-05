# KissPaginate

[![CI Status](http://img.shields.io/travis/WANGjieJacques/KissPaginate.svg?style=flat)](https://travis-ci.org/WANGjieJacques/KissPaginate)
[![Version](https://img.shields.io/cocoapods/v/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)
[![License](https://img.shields.io/cocoapods/l/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)
[![Platform](https://img.shields.io/cocoapods/p/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```swift
class ViewController: PaginateViewController {
    @IBOutlet weak var noElementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        /// refresh the elements
        refreshElements()
    }

    override var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        /// web service mock.
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
            /// load the next page here.
            loadNextPage()
        }
        return cell
    }
}
```
## Requirements

## Installation

KissPaginate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KissPaginate'
```

## Author

WANG Jie, jacques09125715@gmail.com

## License

KissPaginate is available under the MIT license. See the LICENSE file for more info.
