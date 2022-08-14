//
//  BaseNetworkTask.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 13.08.2022.
//

import Foundation

struct BaseNetworkTask<AbstractInput: Encodable, AbstractOutput: Decodable>: NetworkTask {
    
    // MARK: - NetworkTask
    
    typealias Input = AbstractInput
    typealias Output = AbstractOutput
    
    var baseURL: URL? {
        URL(string: "https://pictures.chronicker.fun/api")
    }
    
    let path: String
    let method: NetworkMethod
    let session: URLSession = URLSession(configuration: .default)
    let isNeedInjectToken: Bool
    var urlCach: URLCache {
        URLCache.shared
    }
    
    var tokenStorage: TokenStorage {
        BasetokenStorage()
    }
    
    // MARK: - Initializetion
    
    init(isNeedInjectToken: Bool, method: NetworkMethod, path: String) {
        self.isNeedInjectToken = isNeedInjectToken
        self.path = path
        self.method = method
    }
    
    // MARK: - NetworkTask
    
    func performRequest(
        input: AbstractInput,
        _ onResponceWasReceirved: @escaping (_ result: Result<AbstractOutput, Error>) -> Void
    ) {
        do {
            let request = try getRequest(with: input)
            if let cachedResponse = getCachedReponseFromCash(by: request) {
                let mappedModel = try JSONDecoder().decode(AbstractOutput.self, from: cachedResponse.data)
                onResponceWasReceirved(.success(mappedModel))
                
                return
            }
            
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    onResponceWasReceirved(.failure(error))
                } else if let data = data {
                    do {
                        let mappetModel = try JSONDecoder().decode(AbstractOutput.self, from: data)
                        onResponceWasReceirved(.success(mappetModel))
                        saveResponseToCache(response, cachedData: data, by: request)
                    } catch {
                        onResponceWasReceirved(.failure(error))
                    }
                } else {
                    onResponceWasReceirved(.failure(NetworkTaskError.unknownError))
                }
            }.resume()
        } catch {
            onResponceWasReceirved(.failure(error))
        }
        
    }
}

// MARK: - EmptyModel

extension BaseNetworkTask where Input == EmptyModel {
    
    func performRequest(_ onResponceWasReceirved: @escaping (_ result: Result<AbstractOutput, Error>) -> Void) {
        performRequest(input: EmptyModel(), onResponceWasReceirved)
    }
}

// MARK: - Cache Logic

private extension BaseNetworkTask {
    
    func getCachedReponseFromCash(by request: URLRequest) -> CachedURLResponse? {
        return urlCach.cachedResponse(for: request)
    }
    
    func saveResponseToCache(_ response: URLResponse?, cachedData: Data?, by request: URLRequest) {
        guard let response = response, let cachedData = cachedData else {
            return
        }
        
        let cachedURLResponse = CachedURLResponse(response: response, data: cachedData)
        urlCach.storeCachedResponse(cachedURLResponse, for: request)
    }
}

// MARK: - Private Methods

private extension BaseNetworkTask {
    
    enum NetworkTaskError: Error {
        case unknownError
        case urlWasNotFound
        case urlComponentWasNotCreated
        case parametersIsNotValidJSONObject
    }
    
    func getRequest(with parameters: AbstractInput) throws -> URLRequest {
        guard let url = completedURL else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        var request: URLRequest
        
        switch method {
        case .get:
            let newURL = try getURLWithQueryParameters(for: url, parameters: parameters)
            request = URLRequest(url: newURL)
        case.post:
            request = URLRequest(url: url)
            request.httpBody = try getParametersForBody(from: parameters)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isNeedInjectToken {
            request.addValue("Token \(try tokenStorage.getToken())", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.method
        
        return request
    }
    
    func getParametersForBody(from encodableParameters: AbstractInput) throws -> Data {
        return try JSONEncoder().encode(encodableParameters)
    }
    
    func getURLWithQueryParameters(for url: URL, parameters: AbstractInput) throws -> URL {
        guard var urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkTaskError.urlComponentWasNotCreated
        }
        
        let parametersInDataRepresenention = try JSONEncoder().encode(parameters)
        let parametersInDictionaryRepresentention = try JSONSerialization.jsonObject(with: parametersInDataRepresenention)
        
        guard let parametersInDictionaryRepresentention = parametersInDictionaryRepresentention as? [String: Any] else {
            throw NetworkTaskError.parametersIsNotValidJSONObject
        }
        
        let queryItems = parametersInDictionaryRepresentention.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        urlComponets.queryItems = queryItems
        
        guard let newURLWithQuery = urlComponets.url else {
            throw NetworkTaskError.urlWasNotFound
        }
        
        return newURLWithQuery
    }
    
}
