import Foundation
import RxTest
import RxSwift
@testable import RXSwiftApp

class MockApiService: NetworkService {
    func data<T: Decodable>(resource: APIRequest) -> Observable<T> {
        return Observable.empty()
    }
}
