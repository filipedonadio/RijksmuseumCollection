//
//  CollectionViewModel.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 27/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

protocol CollectionViewModelDelegate: class {

    func onFetchCompleted(with collection: [ItemPreview])
    func onFetchFailed(with reason: String)
}

final class CollectionViewModel {

    weak var delegate: CollectionViewModelDelegate?
    private var collectionService: DefaultCollectionService
    private let downloadGroup = DispatchGroup()
    var items = [ItemPreview]()

    init(collectionService: DefaultCollectionService) {
        self.collectionService = collectionService
    }

    private func downloadImages(from collection: Collection) {
        items.removeAll()
        
        for object in collection.artObjects {
            downloadGroup.enter()

            guard let imageUrl = URL(string: object.webImage.url.replacingOccurrences(of: "=s0", with: "=w200")) else { return }

            let dataTask = URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, response, error) in
                if error != nil {
                    print("Error loading the image from URL: \(imageUrl)")
                }

                guard let data = data else { return }
                self?.items.append(ItemPreview(image: data, title: object.title, subtitle: object.principalOrFirstMaker))
                self?.downloadGroup.leave()
            }

            dataTask.resume()
        }
    }

    func fetchCollection(type: CollectionObjectType) {
        collectionService.fetch(type: type) { [weak self] response in

            switch response {

            case .failure(let error):
                self?.delegate?.onFetchFailed(with: error.reason)

            case .success(let collection):
                self?.downloadImages(from: collection)
                self?.downloadGroup.notify(queue: .main) { [weak self] in
                    if let items = self?.items {
                        self?.delegate?.onFetchCompleted(with: items)
                    }
                }
            }
        }
    }
}
