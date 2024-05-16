//
//  APIEndpoint.swift
//  NetworkKit
//
//  Created by 이태권 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation
import Moya

/// Moya를 활용한 Endpoint
enum APIEndpoint {
    /// 요청 시 DTO가 필요 없을 경우
    case refreshToken
    
    /// 요청 시  DTO가 필요할 경우
//    case postCreate(model: PostRequestDTO)
//    case userJoin(model: UserJoinRequestDTO)
//    case userSignin(model: UserSigninRequestDTO)
//    case CAN_CreateJSON(model: CAN_CreateRequestDTO)
//    case CAN_CreateMultipart(model: Can_CreateRequestDTO)
}

extension APIEndpoint: TargetType {
    
    /// 서버의 Base URL 설정
    var baseURL: URL {
        return URL(string: "https://can.project/api")! /// URL 설정하기
    }
    
    /// API Path 설정
    var path: String {
        switch self {
        case .refreshToken:
            return "refresh"
//        case .userJoin:
//            return "join"
//        case .userSignin:
//            return "login"
//        case .DTOCreateJSON:
//            JSONEncoder.encode(<#T##self: JSONEncoder##JSONEncoder#>)
//            return "JSON"
//        case .CAN_CreateMultipart:
//            return "Multipart"
        }
    }
    
    /// HTTP 메서드
    var method: Moya.Method {
        switch self {
        case .refreshToken:
            return .get
//        case .userJoin, .userSignin, .CAN_CreateJSON, .CAN_CreateMultipart:
//            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .refreshToken:
            return .requestPlain
//        case .userJoin(let data):
//            return .requestJSONEncodable(data)
//        case .userSignin(let data):
//            return .requestJSONEncodable(data)
//        case .CAN_CreateMultipart(let dto):
//            var multiFormData: [MultipartFormData] = []
//            dto.imageDataList.forEach { imageData in
//                multiFormData.append(
//                    MultipartFormData(
//                        provider: .data(imageData),
//                        name: "file",
//                        fileName: "dto.jpeg",
//                        mimeType: "image/jpeg"
//                    )
//                )
//            }
//            multiFormData.append(
//                MultipartFormData(
//                    provider: .data(dto.content.data(using: .utf8)!),
//                    name: "content"
//                )
//            )
//            multiFormData.append(
//                MultipartFormData(
//                    provider: .data(
//                        dto.productID.data(using: .utf8)!
//                    ),
//                    name: "product_id"
//                )
//            )
//            return .uploadMultipart(multiFormData)
        }
    }
    
    // 서버에서 요청 시 헤더를 추가로 요청할 경우
    var headers: [String : String]? {
        /// 1) 헤더가 필요 없을 때
        ///     [:]
        /// 2) 서버의 설정에서 JSON 헤더를 넣어야 할 때
        ///     ["Content-Type": "application/json"]
        /// 3) 서버의 설정에서 Multipart 헤더를 넣어야 할 때
        ///     ["Content-Type": "multipart/form-data"]
        ///     ....
        switch self {
        case .refreshToken:
            return [:]
//        case .CAN_Create_JSON:
//            return ["Content-Type": "application/json"]
//        case .CAN_Create_Multipart:
//            return ["Content-Type": "multipart/form-data"]
        }
    }
}

