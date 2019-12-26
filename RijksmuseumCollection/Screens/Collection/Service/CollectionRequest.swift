//
//  CollectionRequest.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

class CollectionRequest: NetworkRequest {

    init(type: CollectionObjectType?) {
        var params = [URLQueryItem]()

        let imageOnlyQueryItem = URLQueryItem(name: "imgonly", value: "True")
        params.append(imageOnlyQueryItem)

        if let type = type {
            let typeQueryItem = URLQueryItem(name: "type", value: type.rawValue)
            params.append(typeQueryItem)
        }

        super.init(path: "collection", parameters: params)
    }
}
