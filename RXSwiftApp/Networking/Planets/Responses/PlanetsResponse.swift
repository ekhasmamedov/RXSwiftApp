import Foundation

struct PlanetsResponse: Codable {
    var count: Int? = 0
    var results: [Planet]? = []
}
