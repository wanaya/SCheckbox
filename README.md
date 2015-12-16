SCheckbox
=========

SCheckbox is a easy control for use in your app.

How to use
=========

Put in you XIB or storyboard a UIView with class SCheckbox, connect a IBOutlet and configure.

```swift
class ViewController: UIViewController {

    @IBOutlet weak var check: SCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.check.color(UIColor.grayColor(), forState: UIControlState.Normal)
        self.check.textLabel.text = "this is a checkbox"
        self.check.addTarget(self, action: "tapCheck:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func tapCheck(checkBox: SCheckBox!){
        println("\(checkBox.checked)")
    }

}
```
