import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTitleNavigationBar(title: String) {
        self.navigationItem.title = title
    }
}
