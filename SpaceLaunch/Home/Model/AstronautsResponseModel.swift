//
//  AstronautsResponseModel.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import Foundation

struct AstronautsResponseModel: Codable {
    let results:    [AstronautModel]?
}

struct AstronautModel: Codable {
    let id:                         Int
    let name:                       String?
    let nationality:                String?
    let profile_image_thumbnail:    String?
}
