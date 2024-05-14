//
//  StubDataSource.swift
//  Root
//
//  Created by 강현준 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Combine

protocol StubDataSource {
    func fetchDataSource() -> AnyPublisher<(), Error>
}

struct DefaultStubDataSource: StubDataSource {
    func fetchDataSource() -> AnyPublisher<(), Error> {
        return Future { promise in
            promise(.success(()))
        }.eraseToAnyPublisher()
    }
}
