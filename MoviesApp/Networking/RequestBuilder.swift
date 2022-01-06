//
//  RequestBuilder.swift
//  MoviesApp
//
//  Created by Yash Bhojgarhia on 08/08/21.
//

import Foundation

typealias RequestParameters = [String: String]

protocol RequestBuilder {
    var baseURL: String { get }
    var path : String { get }
    var parameters: RequestParameters? { get }
    func resultingEndURL() -> URL?
}
extension RequestBuilder {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    func resultingEndURL() -> URL? {
        var resultingURL = baseURL
        resultingURL.append(path)
            if let paramDic = parameters {
                resultingURL.append("?")
                paramDic.forEach { (key, value) in
                    resultingURL.append("\(key)=\(value)&")
                }
                resultingURL = String(resultingURL.dropLast())
            }
        return URL(string: resultingURL)
    }
}
