//
//  ItemRequest.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import Foundation

class ItemRequest: NetworkRequest {

    init(objectNumber: String) {
        super.init(path: "collection/\(objectNumber)", parameters: nil)
    }
}
