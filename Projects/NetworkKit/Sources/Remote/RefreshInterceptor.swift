//
//  RefreshInterceptor.swift
//  NetworkKit
//
//  Created by 이태권 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Alamofire
import Moya

public class RefreshInterceptor: RequestInterceptor {
    
    //MARK: - Singleton
    static let shared = RefreshInterceptor()
    private init() { }
    
    //MARK: - Properties
    private let keychain = KeychainManager.shared
    
    //MARK: - Protocol Methods
    /// 네트워크 요청 시 intercept 할 메서드
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        
        /// **
        /// 1) "userID"로 키체인에 실제 userID 조회
        /// 2) "\(userID)accessToken"으로 키체인에 실제 access token 조회
        /// 3) "\(userID)refreshToken"으로 키체인에 실제 refresh token 조회
        ///
        /// Q. 1번은 왜 필요한지?
        /// A. 다른 유저가 기존의 토큰 사용에 대한 위험성 방지
        /// 1번이 없을 경우, A 유저의 로그아웃 이후 B 유저가 로그인 할 시 B가 A의 Token으로 요청하게 된다.
        guard
            let userID = keychain.find(key: "", type: .userID),
            let accessToken = keychain.find(key: userID, type: .accessToken),
            let refreshToken = keychain.find(key: userID, type: .refreshToken)
        else {
            completion(.success(urlRequest))
            return
        }
        
        /// 필요한 HTTP Header 추가
        var urlRequest = urlRequest
//        urlRequest.setValue(accessToken, forHTTPHeaderField: _)
//        urlRequest.setValue(refreshToken, forHTTPHeaderField: _)
        
        completion(.success(urlRequest))
    }
    
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        /// 키체인에 보관한 userID와 accessToken, refreshToken을 언래핑
        /// 이 중에서 하나라도 없을 경우 retry 하지 않고 error 방출
        guard
            let userID = keychain.find(key: "", type: .userID),
            let accessToken = keychain.find(key: userID, type: .accessToken),
            let refreshToken = keychain.find(key: userID, type: .refreshToken)
            //let statusCode = request.response?.statusCode, statusCode == 419 // 응답코드가 있을 경우 추가하기
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        /// 리프래시 요청에 대한 분기 처리
        APIManager.shared.refresh(
            accessToken: accessToken,
            refreshToken: refreshToken
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            /// 기존의 액세스 토큰을 새로운 액세스 토큰으로 변경
            case .suceessData(let data):
                if keychain.save(key: userID, value: data.accessToken, type: .accessToken) {
                    completion(.retry)
                }
            
            /// 리프래시 토큰 만료 시 에러 방출 및 retry 종료
            case .statusCode(_):
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
