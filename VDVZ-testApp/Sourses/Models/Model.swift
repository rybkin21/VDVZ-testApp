import UIKit

// MARK: - Model

struct Product: Codable {
    let id: Int
    let name: String
    let imageUrl: String
}

struct Section: Codable {
    let id: Int
    let title: String
}

struct ResponseData: Codable {
    let status: String
    let sections: [Section]
    let products: [Product]
}
