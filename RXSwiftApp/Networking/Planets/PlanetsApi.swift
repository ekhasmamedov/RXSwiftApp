import Foundation

enum PlanetsApi {
    case Planets
}

extension PlanetsApi: APIRequest {
    var path: String {
        return "planets"
    }
}
