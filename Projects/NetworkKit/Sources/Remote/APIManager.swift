//
//  APIManager.swift
//  NetworkKit
//
//  Created by 이태권 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Combine
import Moya

protocol APIManageable {
    func request<T: Decodable>(api: TargetType, responseType: T.Type, isWithToken: Bool) -> AnyPublisher<T, Error>
}

final class APIManager {
    
    //MARK: - Singleton
    static let shared = APIManager()
    private init() { }
    
    //MARK: - Properties
    static let interceptor = RefreshInterceptor.shared
    static let session = Session()
    
    // 인터셉터
    // 로그
    // 리턴타입 제네릭으로받아서
    ///
    func request<T: Decodable>(
        api: TargetType,
        responseType: T.Type,
        isWithToken: Bool = true
    ) -> AnyPublisher<T, Error> {
        
        let session = Session(
            session: <#T##URLSession#>,
            delegate: <#T##SessionDelegate#>,
            rootQueue: <#T##DispatchQueue#>
        )
        
        let plugins = [NetworkLoggerPlugin(
            configuration: .init(
                logOptions: .verbose
            )
        )]
        
        let provider = MoyaProvider<CanAPI>(
            session: session,
            plugins
        )
        
//        let publisher =
        
        return provider
    }
}
