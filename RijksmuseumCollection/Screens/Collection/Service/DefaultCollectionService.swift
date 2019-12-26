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

    func fetch(type: CollectionObjectType?, completion: @escaping CollectionService.Completion) {
        let request = CollectionRequest(type: type)

        requestManager.execute(request: request) { response in
            completion(response)
        }
    }
}
