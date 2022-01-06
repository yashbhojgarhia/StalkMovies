//
//  RequestHandler.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation

public class RequestHandler {
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        session = URLSession.init(configuration: config)
    }
    
    func sendRequest<T: Codable>(_ decoder: T.Type, request: RequestBuilder, completionHandler: @escaping (Result<T,Error>) -> Void) {
        if let url = request.resultingEndURL() {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let err = error {
                    completionHandler(.failure(err))
                    return
                }
                guard let mime = response?.mimeType, mime == "application/json" else {
                    completionHandler(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: ConstantKeys.SOMETHING_WENT_WRONG])))
                    return
                }
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedNowPlayingModel = try decoder.decode(T.self, from: jsonData)
                        completionHandler(.success(decodedNowPlayingModel))
                    } catch {
                        completionHandler(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: ConstantKeys.SOMETHING_WENT_WRONG])))
                    }
                }
            }
            task.resume()
        }
    }
}
