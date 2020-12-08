//
//  Fact.swift
//  ChuckNorrisJokeAPI
//
//  Created by Patricia dos Santos Cardozo on 08/12/20.
//

import Foundation

class ChangeJoke {

    struct  Result: Codable {
        var value: String

    }
    var quote = ""
    var url = "https://api.chucknorris.io/jokes/random?category=dev"
    
    func getData(completed: @escaping ()->()) {
        let urlString = url
        print("We are accessing the url \(urlString)")

        //Create URL
        guard let url = URL(string: urlString) else {
            print("ERROR! Could not create a url from \(urlString)")
            completed()
            return
        }

        //Create a session
        let session = URLSession.shared

        //Get Data
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                
            }
            do{
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("***QUOTE: \(result.value)")
                self.quote = result.value
            }catch{
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }

        task.resume()
    }
}
