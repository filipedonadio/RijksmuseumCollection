//
//  Item.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import Foundation

struct Item: Decodable {

    let acquisition: Acquisition
    let copyrightHolder: String?
    let dating: Dating
    let label: Label
    let materials: [String]
    let objectNumber: String?
    let objectTypes: [String]
    let principalOrFirstMaker: String?
    let productionPlaces: [String]
    let subTitle: String?
    let techniques: [String]
    let title: String?
    let webImage: WebImage?
}
