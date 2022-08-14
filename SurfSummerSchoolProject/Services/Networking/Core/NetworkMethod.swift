//
//  NetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

enum NetworkMethod: String {
    
    case get
    case post
    
}

extension NetworkMethod {
    
    var method: String {
        rawValue.uppercased()
    }
}
