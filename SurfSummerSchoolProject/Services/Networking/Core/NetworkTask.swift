//
//  NetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

protocol NetworkTask {
    
    associatedtype Input: Encodable
    associatedtype Output: Decodable
    
    var baseURL: URL? { get }
    var path: String { get }
    var completedURL: URL? { get }
    var method: NetworkMethod { get }
    
    func performRequest(
        input: Input,
        _ onResponceWasReceirved: @escaping (_ result: Result<Output, Error>) -> Void
    )
}

extension NetworkTask {
    
    var completedURL: URL? {
        baseURL?.appendingPathComponent(path)
    }
}
