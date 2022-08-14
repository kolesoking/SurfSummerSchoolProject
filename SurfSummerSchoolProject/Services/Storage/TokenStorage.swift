//
//  TokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

protocol TokenStorage {

    func getToken() throws -> TokenContainer
    func set(newToken: TokenContainer) throws

}
