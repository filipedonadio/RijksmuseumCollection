//
//  CollectionObject.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 26/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

struct CollectionObject: Decodable {
    
    let id: String
    let title: String
    let principalOrFirstMaker: String
    let webImage: WebImage
}
