//
//  ItemService.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import Foundation

protocol ItemService {

    typealias Completion = (ItemResponse) -> Void
    func fetch(objectNumber: String, completion: @escaping Completion)
}
