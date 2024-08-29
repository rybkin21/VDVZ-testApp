
import Foundation

struct ResponseData: Codable {
    let status: String
    let message: String
    let tovary: [Tovary]

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case tovary = "TOVARY"
    }
}
