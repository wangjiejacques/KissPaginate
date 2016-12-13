#
# Be sure to run `pod lib lint KissPaginate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KissPaginate'
  s.version          = '0.3.10'
  s.summary          = 'Simplify your implementation of tableView paginate.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
```
class ViewController: PaginateViewController {
    @IBOutlet weak var noElementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshElements()
    }

    override var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: Error) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: Error) -> Void) {
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
```
                       DESC

  s.homepage         = 'https://github.com/WANGjieJacques/KissPaginate'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WANG Jie' => 'jacques09125715@gmail.com' }
  s.source           = { :git => 'https://github.com/WANGjieJacques/KissPaginate.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KissPaginate/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KissPaginate' => ['KissPaginate/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
