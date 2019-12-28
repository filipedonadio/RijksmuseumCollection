//
//  DefaultRequestManager.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

struct DefaultRequestManager: RequestManager {

    func execute<T: Decodable>(request: NetworkRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let endpointUrl = Environment.baseURL.appendingPathComponent(request.path)

        guard var urlComponents = URLComponents(url: endpointUrl, resolvingAgainstBaseURL: true) else {
            completion(.failure(NetworkError.invalidEndpoint))
            return
        }

        var queryItems = [
            URLQueryItem(name: "key", value: Environment.apiKey),
        ]

        if let parameters = request.parameters {
            queryItems.append(contentsOf: parameters)
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidEndpoint))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(NetworkError.network))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.network))
                return
            }

            let decoder = JSONDecoder()

            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkError.decoding))
            }
        }

        dataTask.resume()
    }
}
