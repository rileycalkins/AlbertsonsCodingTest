//
//  ModelObjects.swift
//  AlbertsonsCodingTest
//
//  Created by Riley Calkins on 11/22/22.
//

import Foundation

struct AcronymResponse: Codable {
    let sf: String
    let lfs: [LongForm]
}
struct AcronymRequest: Codable {
    let sf: String
    let lf: String
}

struct LongForm: Codable {
    let lf: String
    let freq: Int
    let since: Int
    let vars: [Variation]
}

struct Variation: Codable {
    let lf: String
    let freq: Int
    let since: Int
}
