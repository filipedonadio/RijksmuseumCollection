//
//  DefaultCollectionService.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

class DefaultCollectionService: CollectionService {

    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetch(type: CollectionObjectType?, page: Int?, completion: @escaping CollectionService.Completion) {
        let request = CollectionRequest(type: type, page: page)

        requestManager.execute(request: request) { response in
            completion(response)
        }
    }
}
