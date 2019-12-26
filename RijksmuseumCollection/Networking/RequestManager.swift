//
//  RequestManager.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

protocol RequestManager {

    func execute<T: Decodable>(request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}
