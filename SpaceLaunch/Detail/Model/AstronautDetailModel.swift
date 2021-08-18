//
//  AstronautDetailModel.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 17/8/21.
//

import Foundation

struct AstronautDetailModel: Codable, Equatable {
    let name:                       String?
    let nationality:                String?
    let date_of_birth:              String?
    let profile_image:              String?
    let bio:                        String?
}
