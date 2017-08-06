# rxCompletedBindingIssue

This repository reproduces an issue where a later binding stream which has completed causes the initial binding to be "completed" as well.

1. Run the app.
2. Click the button. 
3. Click the button again - no response.

This is because it seems the subscription in `viewDidLoad` is not active anymore.
The button ran this code:

```
        let d = PublishSubject<AppInput>()
        self.c.amb(d).take(1).bindTo(self.vm.appInput).disposed(by: self.bag)
        d.onNext(.showOptions) // Completes D. vm.appInput is completed as well.
```
