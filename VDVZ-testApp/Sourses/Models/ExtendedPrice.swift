//
//  ExtendedPrice.swift
//  VDVZ-testApp
//
//  Created by Ivan Rybkin on 28.08.2024.
//

import Foundation

struct ExtendedPrice: Codable {
    let price: Int

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
    }
}
