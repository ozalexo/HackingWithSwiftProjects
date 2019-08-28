#  Project P008_7SwiftyWords

## Challenge 003

1. Attempt to implement counter of attempts like this:
   ```
    let maxAttempts = 10
    var attemptsRemaining = maxAttempts {
        didSet {
            attemptsLabel.text = "Attempts remaining: \(attemptsRemaining)"
        }
    }
   ```

Got the following error: `Cannot use instance member 'maxAttempts' within property initializer; property initializers run before 'self' is available`

Found that I need an initializer in the class. Tried to use `lazy var`, but lazy vars can't be observable (didSet).
Found answer here https://www.hackingwithswift.com/example-code/language/fixing-class-viewcontroller-has-no-initializers

2. Let's made win-loose decision matrix like this:

![Screen Shot 2019-08-22 at 17 52 23](https://user-images.githubusercontent.com/661889/63866078-598d2380-c9bb-11e9-8b24-adc08d276acb.png)

3. Got issue with changing UIButton's title during level up: Old title shown right after button appering anf then replacing to new title. Fixed bu changing buttons' type from .system to .custom and nmodifying 'for' at setTitle like this:
`letterButton.setTitleColor(UIColor.systemBlue, for: UIControl.State())` to set title for all available buttons' states. 
Do not understand yet, why original exmaple https://github.com/twostraws/HackingWithSwift/tree/master/project8 has no such issue, it seems like it doesn't change button type during switching `isHidden` property.
