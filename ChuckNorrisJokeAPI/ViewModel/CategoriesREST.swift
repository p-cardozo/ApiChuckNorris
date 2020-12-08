//
//  CategoryREST.swift
//  ChuckNorrisJokeAPI
//
//  Created by Patricia dos Santos Cardozo on 07/12/20.
//

import Foundation

enum CategoriesError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class CategoriesREST {
    
    private static let basePath = "https://api.chucknorris.io/jokes/categories"
    typealias Category =  [String]
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadCategories(onComplete: @escaping ([String]) -> Void, onError: @escaping (CategoriesError) -> Void){
        guard let url = URL(string: basePath) else {
            return onError(.url)
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?,error: Error?) in
            if error == nil{
                guard let response = response as? HTTPURLResponse else{
                    return onError(.noResponse)
                    
                }
                if response.statusCode == 200{
                    guard let data = data else {
                        return onError(.noData)
                        
                    }
                    do{
                        let categories = try JSONDecoder().decode(Category.self, from: data)
                        onComplete(categories)
                    } catch{
                        onError(.invalidJSON)
                    }
                    
                }else{
                    onError(.responseStatusCode(code: response.statusCode))
                }
                
            }else{
                return onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
}
