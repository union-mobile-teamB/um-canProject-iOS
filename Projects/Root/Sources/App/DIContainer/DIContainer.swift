//
//  DIContainer.swift
//  Root
//
//  Created by 강현준 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Swinject

public class DIContainer {
    
    public static let shared: DIContainer = DIContainer()
    
    public let container = Container()
    
    private init() { }
    
    public func inject() {
        registerDataSource()
        registerRepository()
        registerUseCase()
    }
    
    private func registerDataSource() {
        // Exam
        container.register(StubDataSource.self) { _ in DefaultStubDataSource() }
    }
    
    private func registerRepository() {
        // Exam
        container.register(StubRepository.self) { resolver in
            let repository = DefaultStubRepository(
                dataSource: resolver.resolve(StubDataSource.self)!
            )
            
            return repository
        }
    }
    
    private func registerUseCase() {
        // Exam
        container.register(StubUseCase.self) { resolver in
            let usecase = DefaultStubUseCase(
                repository: resolver.resolve(StubRepository.self)!
            )
            
            return usecase
        }
    }
    
    
}
