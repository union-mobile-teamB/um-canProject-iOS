//
//  APIManager.swift
//  NetworkKit
//
//  Created by 이태권 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Combine
import CombineMoya
import Moya

///APIManager를 위한 프로토콜 인터페이스
protocol APIManageable {
    func request<T: Decodable>(endpoint: APIEndpoint, responseType: T.Type, isWithToken: Bool) -> AnyPublisher<T, Error>
}

public class APIManager: APIManageable {
    
    //MARK: - Properties
    static let interceptor = RefreshInterceptor.shared
    static let session = Session()
    
    //MARK: - Methods
    /// API에 대한 request 메서드
    /// - Parameters:
    ///   - endpoint: Moya의 TargetType 프로토콜을 채택한 endpoint
    ///   - responseType: 제네릭에 대한 메타 타입
    ///   - isWithToken: 요청 시 token의 필요 유무에 대한 분기 처리 (기본값 true)
    /// - Returns: 제네릭 AnyPublisher
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type,
        isWithToken: Bool = true // 기본값 true
    ) -> AnyPublisher<T, Error> {
        
        return Future<T, Error> { promise in
            /// 필요에 따라 logOptions의 조건을 바꿀 것
            let networkLogger = [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))] // verbose 옵션은 모든 log components 출력
            let provider = isWithToken ?
            MoyaProvider<APIEndpoint>(session: APIManager.session, plugins: networkLogger) :
            MoyaProvider<APIEndpoint>(plugins: networkLogger)
            
            provider.requestPublisher(apis)
                .sink(receiveCompletion: { completion in
                    switch completion{
                    case .finished:
                        print("RECEIVE VALUE COMPLETED")
                    case .failure:
                        print("RECEIVE VALUE FAILED")
                    }
                }, receiveValue: { response in
                    let result = try? JSONDecoder().decode([TeamStat].self, from: response.data)
                    promise(.success(result!))
                })
                .store(in: &cancelable)
            
        }.eraseToAnyPublisher()
    }
    
    /// accessToken에 대한 refresh 메서드
    /// - Parameters:
    ///   - accessToken: 회원 인증을 위한 accessToken
    ///   - refreshToken: 액세스 토큰을 갱신하기 위한 accessToken
    ///   - completion: 비동기 메서드
    func refresh(
        accessToken: String,
        refreshToken: String,
        completion: @escaping ( Result<RefreshTokenResponseDTO> ) -> Void
    ) {
        /// 필요에 따라 logOptions의 조건을 바꿀 것
        let networkLogger = [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))] // verbose 옵션은 모든 log components 출력
        let provider = MoyaProvider<APIEndpoint>(plugins: networkLogger)
        
        provider.request(.refreshToken) { result in
            let decoder = JSONDecoder()
            
            switch result {
            case .success(let response):
                let status = response.statusCode
                
                do {
                    let result = try decoder.decode(RefreshTokenResponseDTO.self, from: response.data)
                    completion(.suceessData(result))
                } catch {
                    completion(.statusCode(response.statusCode))
                }
                
                /// 서버의 응답코드에 따라 변경할 것
                if status >= 400 {
                    completion(.statusCode(response.statusCode))
                }
            case .failure(let error):
                completion(.statusCode(error.errorCode))
            }
        }
    }
}
