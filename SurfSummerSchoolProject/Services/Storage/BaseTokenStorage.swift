//
//  BaseTokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

struct BasetokenStorage: TokenStorage {
    
    // MARK: - Nested Types
    
    private enum Constants {
        static let applicationNameInKeyChain = "com.surf.education.project"
        static let tokenKey = "token"
        static let tokenDateKey = "tokenDate"
    }
    
    // MARK: - Private Properties
    
    private var unprotectedStorage: UserDefaults {
        UserDefaults.standard
    }
    
    // MARK: - Token Storage
    
    func getToken() throws -> TokenContainer {
        
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        
        var tokenInResult: AnyObject?
        let status = SecItemCopyMatching(queryDictionaryForSavingToken as CFDictionary, &tokenInResult)
        
        try throwErrorFromStatuIfNeeded(status)
        
        guard let data = tokenInResult as? Data else {
            throw Error.tokenWasNotFoundInKeyChainOrCantRepresentAsData
        }
        
        let retrivingToken = try JSONDecoder().decode(String.self, from: data)
        let tokenSavingDate = try getSavingTokenDate()
        
        return TokenContainer(token: retrivingToken, recevingDate: tokenSavingDate)
        
    }
    
    func set(newToken: TokenContainer) throws {
        try removetokenFromConteiner()
        let tokenInData = try JSONEncoder().encode(newToken.token)
        let queryDictionaryForSavingToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: tokenInData as AnyObject
        ]
        
        let status = SecItemAdd(queryDictionaryForSavingToken as CFDictionary, nil)
        
        try throwErrorFromStatuIfNeeded(status)
        
        saveTokenSavingDate(.now)
    }
    
    func removetokenFromConteiner() throws {
        let queryDictionaryForDeleteToken: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.tokenKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
        ]
        
        let status = SecItemDelete(queryDictionaryForDeleteToken as CFDictionary)
        
        try throwErrorFromStatuIfNeeded(status)
        
        removeTokenSavingData()
    }
}

private extension BasetokenStorage {
    
    enum Error: Swift.Error {
        case unknownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case tokenWasNotFoundInKeyChainOrCantRepresentAsData
        case tokeDateWasNotFound
    }
    
    func getSavingTokenDate() throws -> Date {
        guard let savingDate = unprotectedStorage.value(forKey: Constants.tokenDateKey) as? Date else {
            throw Error.tokeDateWasNotFound
        }
        
        return savingDate
    }
    
    func saveTokenSavingDate(_ newDate: Date) {
        unprotectedStorage.set(newDate, forKey: Constants.tokenDateKey)
    }
    
    func removeTokenSavingData() {
        unprotectedStorage.set(nil, forKey: Constants.tokenDateKey)
    }
    
    func throwErrorFromStatuIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess || status == -25300 else {
            throw Error.unknownError(status: status)
        }
        
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
}
