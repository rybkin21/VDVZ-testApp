//
//  ProductData.swift
//  VDVZ-testApp
//
//  Created by Ivan Rybkin on 28.08.2024.
//

import Foundation

struct ProductData: Codable {
    let id: String
    let name: String?
    let detailPicture: String?
    let extendedPrice: [ExtendedPrice]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case detailPicture = "DETAIL_PICTURE"
        case extendedPrice = "EXTENDED_PRICE"
    }
}


