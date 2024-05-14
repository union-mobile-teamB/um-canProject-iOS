//
//  BaseViewController.swift
//  Root
//
//  Created by 강현준 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import UIKit
import Combine

open class StubViewController: UIViewController {
    
    let viewModel: StubViewModel = .init()
    
    private var subscription = Set<AnyCancellable>()
    
    open override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        viewModel.fetchData()
            .sink { completion in
                
            } receiveValue: { _ in
                print("received Value!!")
            }
            .store(in: &subscription)
    }
    
}

public class StubViewModel {
    let useCase: StubUseCase
    
    init() {
        self.useCase = DIContainer.shared.container.resolve(StubUseCase.self)!
    }
    
    func fetchData() -> AnyPublisher<(), Error> {
        return useCase.fetchData()
    }
}
