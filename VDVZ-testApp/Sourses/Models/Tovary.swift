import UIKit

// MARK: - Model

struct Tovary: Codable {
    let id: Int
    let name: String
    let productData: [ProductData]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case productData = "data"
    }
}



