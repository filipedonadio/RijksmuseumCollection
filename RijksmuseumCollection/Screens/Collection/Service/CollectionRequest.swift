//
//  CollectionRequest.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

class CollectionRequest: NetworkRequest {

    init(type: CollectionObjectType?, page: Int?) {
        var params = [URLQueryItem]()

        let imageOnlyQueryItem = URLQueryItem(name: "imgonly", value: "True")
        params.append(imageOnlyQueryItem)

        let resultsPerPage = URLQueryItem(name: "ps", value: "20")
        params.append(resultsPerPage)

        if let type = type {
            let typeQueryItem = URLQueryItem(name: "type", value: type.rawValue)
            params.append(typeQueryItem)
        }

        if let page = page {
            params.append(URLQueryItem(name: "p", value: String(page)))
        }

        super.init(path: "collection", parameters: params)
    }
}
