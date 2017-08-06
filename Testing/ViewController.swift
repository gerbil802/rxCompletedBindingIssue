//
//  ViewController.swift
//  Testing
//
//  Created by Tal Shrestha on 02/08/2017.
//  Copyright © 2017 None. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class ViewController: NSViewController, NSMenuDelegate {
    
    var vm = ViewModel()
    var bag = DisposeBag()
    
    let a = PublishSubject<AppInput>()
    let b = PublishSubject<AppInput>()
    let c = PublishSubject<AppInput>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.of(a,b).merge().bindTo(vm.appInput).disposed(by: bag)
        
        self.vm.appState.subscribe{ event in
            guard let element = event.element else {
                return
            }
            switch element {
            case .options:
                self.showAlert()
                break
            default:
                break
            }
        }.disposed(by: bag)
        
    }

    @IBAction func action(_ sender: Any) {
        let d = PublishSubject<AppInput>()
        self.c.amb(d).take(1).bindTo(self.vm.appInput).disposed(by: self.bag)
        d.onNext(.showOptions)
    }
    
    func showAlert() {
        let alert = NSAlert()
        alert.beginSheetModal(for: self.view.window!)
    }
}

