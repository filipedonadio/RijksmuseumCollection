//
//  NetworkRequest.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

class NetworkRequest {

    let path: String
    let parameters: [URLQueryItem]?

    init(path: String, parameters: [URLQueryItem]?) {
        self.path = path
        self.parameters = parameters
    }
}
