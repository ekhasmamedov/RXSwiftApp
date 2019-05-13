import Foundation

enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

protocol APIRequest {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension APIRequest {
    var method: Method {
        return .GET
    }
    
    var parameters: [String: String] {
        return [:]
    }
}

extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        let URL = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
