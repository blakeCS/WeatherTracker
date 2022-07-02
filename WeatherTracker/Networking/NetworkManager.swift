//
//  NetworkManager.swift
//  WeatherTracker
//
//  Created by Madeline Burton on 6/29/22.
//

import Foundation


// STEP THREE: CREATE NETWORK MANAGER
final class NetworkManager<T: Codable>{
    
    // Create the request
    static func retrieveData(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        // Use an asynchronous completion handler
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print(String(describing: error!))
            // If we run in to an error, address it with each of the three enum options
            // 1. Completion error
            guard error == nil else{
                completion(.failure(.error(err:"Could not complete URL Request")))
                return
            }
            
            // 2. Invalid Response
            // A code of 200 means we retrieved the content, others will be invalid data
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            
            // 3. The data recieved does not meet the specifications/expecations and is invalid
            guard let data = data else{
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            
                // Address the potential decoding error if it made it through all guards but still is not viable
            } catch let err {
                print(String(describing:err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        
            //
        }.resume()
    }
}

enum NetworkError: Error{
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}


