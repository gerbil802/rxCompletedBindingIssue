//
//  ViewModel.swift
//  Testing
//
//  Created by Tal Shrestha on 02/08/2017.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum AppInput {
    case showOptions
    case didHideOptions
}

enum AppState {
    case options
    case idle
}

class ViewModel {
    
    var appInput = PublishSubject<AppInput>()
    var appState: Observable<AppState>
    
    init() {
        self.appState = self.appInput
            .debug("appState")
            .scan(.idle, accumulator: { previousState, input in
                switch input {
                case .showOptions: return .options
                case .didHideOptions: return .idle
                }
        })
    }
}
