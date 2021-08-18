//
//  Constants.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import Foundation

enum Constants {
    
    static let baseURL:       String     =   "https://spacelaunchnow.me/api/3.5.0/"
    static let astronautsList: String    =   "astronaut/?format=json"

    static func astronautDetails(id: Int) -> String {
        baseURL + "astronaut/\(id)/?format=json"
    }
}
