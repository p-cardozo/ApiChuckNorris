//
//  REST.swift
//  ChuckNorrisJokeAPI
//
//  Created by Patricia dos Santos Cardozo on 07/12/20.
//

import Foundation

enum JokeError {
    case url
    case taskError(error: Error) 
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class JokeREST {

    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()

    private static let session = URLSession(configuration: configuration)

    class func jokeRequest(onComplete: @escaping (Joke) -> Void, onError: @escaping (JokeError) -> Void, categoria: String){
        
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random?category=\(categoria)") else {
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
                        let jokes = try JSONDecoder().decode(Joke.self, from: data)
                        onComplete(jokes)
                    } catch{
                        print(error)
                        onError(.invalidJSON)
                    }
                }else{
                    onError(.responseStatusCode(code: response.statusCode))
                }
            }
            else{
                return onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }

}
