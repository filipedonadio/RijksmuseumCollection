//
//  ItemViewModel.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 09/01/20.
//  Copyright © 2020 Filipe Donadio. All rights reserved.
//

import Foundation

protocol ItemViewModelDelegate: class {

    func onLoading()
    func onFetchCompleted(with artObject: ItemDisplayable)
    func onFetchFailed(with reason: String)
}

final class ItemViewModel {

    weak var delegate: ItemViewModelDelegate?
    private var itemService: DefaultItemService

    init(itemService: DefaultItemService) {
        self.itemService = itemService
    }

    private func formatData(item: Item) {
        // Download item image
        if let imageUrl = URL(string: item.webImage.url.replacingOccurrences(of: "=s0", with: "=w500")) {
            let dataTask = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if error != nil {
                    print("Error loading the image from URL: \(imageUrl)")
                }

                if let imageData = data {

                    // Format data for each section
                    var sections = [Section]()

                    // Identification Section
                    var identificationSectionInfo = [Info]()

                    if let title = item.title {
                        identificationSectionInfo.append(Info(title: "Title", data: title))
                    }

                    if !item.objectTypes.isEmpty {
                        var typeString = [String]()
                        for type in item.objectTypes {
                            typeString.append(type)
                        }

                        identificationSectionInfo.append(Info(title: "Object type", data: typeString.joined(separator: ", ").capitalized))
                    }

                    if let objectNumber = item.objectNumber {
                        identificationSectionInfo.append(Info(title: "Object number", data: objectNumber))
                    }

                    if let description = item.label.description {
                        identificationSectionInfo.append(Info(title: "Description", data: description))
                    }

                    if !identificationSectionInfo.isEmpty {
                        sections.append(Section(name: "Identification", info: identificationSectionInfo))
                    }

                    // Creation Section
                    var creationSectionInfo = [Info]()

                    if let artist = item.principalOrFirstMaker {
                        creationSectionInfo.append(Info(title: "Artist", data: artist.capitalized))
                    }

                    if !item.productionPlaces.isEmpty {
                        var places = [String]()
                        for place in item.productionPlaces {
                            places.append(place)
                        }

                        creationSectionInfo.append(Info(title: "Place", data: places.joined(separator: ", ").capitalized))
                    }

                    if let dating = item.dating.presentingDate {
                        creationSectionInfo.append(Info(title: "Dating", data: dating))
                    }

                    if !creationSectionInfo.isEmpty {
                        sections.append(Section(name: "Creation", info: creationSectionInfo))
                    }

                    // Material and Technique
                    var materialAndTechiniqueInfo = [Info]()

                    if !item.materials.isEmpty {
                        var materials = [String]()
                        for material in item.materials {
                            materials.append(material)
                        }

                        materialAndTechiniqueInfo.append(Info(title: "Material", data: materials.joined(separator: ", ").capitalized))
                    }

                    if !item.techniques.isEmpty {
                        var techniques = [String]()
                        for technique in item.techniques {
                            techniques.append(technique)
                        }

                        materialAndTechiniqueInfo.append(Info(title: "Technique", data: techniques.joined(separator: ", ").capitalized))
                    }

                    if let subTitle = item.subTitle {
                        materialAndTechiniqueInfo.append(Info(title: "Measurements", data: subTitle))
                    }

                    if !materialAndTechiniqueInfo.isEmpty {
                        sections.append(Section(name: "Material and Technique", info: materialAndTechiniqueInfo))
                    }

                    // Acquisition and rights
                    var acquisitionInfo = [Info]()

                    if let creditLine = item.acquisition.creditLine {
                        acquisitionInfo.append(Info(title: "Credit line", data: creditLine))
                    }

                    if var acquisition = item.acquisition.method {
                        if let acquisitionDateString = item.acquisition.date {

                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            if let acquisitionDate = formatter.date(from: acquisitionDateString) {
                                formatter.dateFormat = "yyyy"
                                let acquisitionYear = formatter.string(from: acquisitionDate)
                                acquisition = "\(acquisition) \(acquisitionYear)"
                            }
                        }

                        acquisitionInfo.append(Info(title: "Acquisition", data: acquisition.capitalized))
                    }

                    if let copyrightHolder = item.copyrightHolder {
                        acquisitionInfo.append(Info(title: "Copyright", data: copyrightHolder))
                    } else {
                        acquisitionInfo.append(Info(title: "Copyright", data: "Public domain"))
                    }

                    if !acquisitionInfo.isEmpty {
                        sections.append(Section(name: "Acquisition and rights", info: acquisitionInfo))
                    }

                    DispatchQueue.main.async { [weak self] in
                        self?.delegate?.onFetchCompleted(with: ItemDisplayable(headerImage: imageData, sections: sections))
                    }
                }
            }

            dataTask.resume()
        }
    }

    func fetchItem(objectNumber: String) {
        delegate?.onLoading()

        itemService.fetch(objectNumber: objectNumber) { [weak self] response in

            switch response {

            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.onFetchFailed(with: error.reason)
                }

            case .success(let itemData):
                self?.formatData(item: itemData.artObject)
            }
        }
    }
}
