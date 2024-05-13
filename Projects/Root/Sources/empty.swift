import UIKit

open class BaseViewController: UIViewController {
    
    let label = UILabel()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Base"
        view.addSubview(label)
        self.view.backgroundColor = .white
        
        label.font = .systemFont(ofSize: 20)
        label.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
    }
}
