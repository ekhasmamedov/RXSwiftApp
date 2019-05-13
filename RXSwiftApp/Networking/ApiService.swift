import Foundation
import RxSwift

struct API {
    static let baseUrl = "https://swapi.co/api/"
}

enum APIClientError: Error {
    case CouldNotDecodeJSON
    case BadStatus(status: Int)
    case Other(Error)
}

protocol NetworkService {
    func data<T: Decodable>(resource: APIRequest) -> Observable<T>
}

final class ApiService: NetworkService {
    private let baseURL: String
    private let session: URLSession
    
    init(baseURL: String = API.baseUrl,
         configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
    
    func data<T: Decodable>(resource: APIRequest) -> Observable<T> {
        guard let url = URL(string: API.baseUrl) else {
            return Observable.empty()
        }
        let request = resource.request(with: url)
        
        return Observable.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(APIClientError.Other(error))
                } else {
                    guard let HTTPResponse = response as? HTTPURLResponse else {
                        fatalError("Couldn't get HTTP response")
                    }
                    
                    if 200 ..< 300 ~= HTTPResponse.statusCode {
                        do {
                            let response: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                            observer.onNext(response)
                        } catch let error {
                            observer.onError(error)
                        }
                        
                        observer.onCompleted()
                    }
                    else {
                        observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

