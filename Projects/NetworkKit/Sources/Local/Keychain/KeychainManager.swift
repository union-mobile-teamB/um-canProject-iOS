//
//  KeychainManager.swift
//  NetworkKit
//
//  Created by 이태권 on 5/14/24.
//  Copyright © 2024 TuistTemplate. All rights reserved.
//

import Foundation

///Key의 종류를 구분한 타입
enum KeyType: String {
    case userID
    case accessToken
    case refreshToken
}

///KeychainManager를 위한 프로토콜 인터페이스
protocol KeychainManageable {
    func save(key: String, value: String, type: KeyType) -> Bool
    func find(key: String, type: KeyType) -> String?
    func delete(key: String, type: KeyType) -> Bool
}

///Keychain API를 활용하는 클래스 매니저
public class KeychainManager: KeychainManageable {
    
    //MARK: - Singleton
    static let shared = KeychainManager()
    private init () { }
    
    //MARK: - Properties
    private let keySecurityClass = kSecClassGenericPassword
    
    //MARK: - Private Methods
    /// 에러 방출 메서드
    private func logError(_ status: OSStatus) {
        let description = SecCopyErrorMessageString(status, nil)
        print(description ?? "Keychain ERROR.")
    }
    
    /// 키체인에 키를 새로 추가하는 메서드
    private func update(account: String, value: Data) -> Bool {
        let updateQuery: [CFString: Any] = [kSecValueData: value]
        let searchQuery: [CFString: Any] = [
            kSecClass: keySecurityClass,
            kSecAttrAccount: account
        ]
        let status = SecItemUpdate(searchQuery as CFDictionary, updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            logError(status)
            return false
        }
    }
    
    //MARK: - Protocol Methods
    
    /// 키체인에 값을 저장 (새로운 키를 추가하거나 존재하는 키에 대한 값을 변경)
    /// - Parameters:
    ///   - key: 키체인에서 조회를 하기 위한 키 (ex. userID, productID)
    ///   - value: 키체인에 실제로 저장할 값 (ex. accessToken, refreshToken)
    ///   - type: 키체인에서 조회할 키의 종류
    /// - Returns: 키체인에 저장되었는지에 대한 Bool
    func save(key: String, value: String, type: KeyType) -> Bool {
        guard let valueData = value.data(using: .utf8) else { return false }
        
        let account = key + type.rawValue // value의 저장 방지를 위해
        let query: [CFString: Any] = [
            kSecClass: keySecurityClass,
            kSecAttrAccount: account,
            kSecValueData: valueData
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(account: account, value: valueData)
        } else {
            logError(status)
            return false
        }
    }
    
    func find(key: String, type: KeyType) -> String? {
        let account = key + type.rawValue
        let query: [CFString: Any] = [
            kSecClass: keySecurityClass,
            kSecAttrAccount: account,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            logError(status)
            return nil
        }
        
        guard
            let existingItem = item as? [String: Any],
            let data = existingItem[kSecValueData as String] as? Data,
            let token = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return token
    }
    
    func delete(key: String, type: KeyType) -> Bool {
        let account = key + type.rawValue
        let searchQuery: [CFString: Any] = [
            kSecClass: keySecurityClass,
            kSecAttrAccount: account
        ]
        let status = SecItemDelete(searchQuery as CFDictionary)
        
        if status == errSecSuccess {
            return true
        } else {
            logError(status)
            return false
        }
    }
}
