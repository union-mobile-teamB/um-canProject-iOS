//
//  StubRepository.swift
//  Root
//
//  Created by 강현준 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Combine

protocol StubRepository {
    func fetchRepository() -> AnyPublisher<(), Error>
}

struct DefaultStubRepository: StubRepository {
    let dataSource: StubDataSource
    
    init(dataSource: StubDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchRepository() -> AnyPublisher<(), Error> {
        return dataSource.fetchDataSource()
    }
}
