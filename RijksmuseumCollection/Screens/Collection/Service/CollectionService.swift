//
//  CollectionService.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

protocol CollectionService {
    
    typealias Completion = (CollectionResponse) -> Void
    func fetch(type: CollectionObjectType?, page: Int?, completion: @escaping Completion)
}
