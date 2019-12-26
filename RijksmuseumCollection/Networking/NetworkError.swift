//
//  NetworkError.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case network
    case decoding
    case invalidEndpoint

    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching the data"
        case .decoding:
            return "An error occurred while decoding the data"
        case .invalidEndpoint:
            return "Invalid URL"
        }
    }
}
