//
//  DefaultItemService.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import Foundation

class DefaultItemService: ItemService {

    let requestManager: RequestManager

    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }

    func fetch(objectNumber: String, completion: @escaping ItemService.Completion) {
        let request = ItemRequest(objectNumber: objectNumber)

        requestManager.execute(request: request) { response in
            completion(response)
        }
    }
}
