//
//  Environment.swift
//  RijksmuseumCollection
//
//  Created by Filipe Donadio on 25/12/19.
//  Copyright © 2019 Filipe Donadio. All rights reserved.
//

import Foundation

enum Environment {

    private enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let apiKey = "API_KEY"
        }
    }

    // MARK: Read Plist file
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }

        return dict
    }()

    // MARK: Plist values
    static let baseURL: URL = {
        guard let baseURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL not set in Plist for this environment")
        }

        guard let url = URL(string: baseURLstring) else {
            fatalError("Base URL is invalid")
        }

        return url
    }()

    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in Plist for this environment")
        }

        return apiKey
    }()
}
