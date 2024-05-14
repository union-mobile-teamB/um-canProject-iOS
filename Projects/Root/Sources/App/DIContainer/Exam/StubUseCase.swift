//
//  StubUseCase.swift
//  Root
//
//  Created by 강현준 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Combine

protocol StubUseCase {
    func fetchData() -> AnyPublisher<(), Error>
}

struct DefaultStubUseCase: StubUseCase {
    let repository: StubRepository
    
    init(repository: StubRepository) {
        self.repository = repository
    }
    
    func fetchData() -> AnyPublisher<(), Error> {
        return repository.fetchRepository()
    }
}
