import Foundation
import RxSwift
import RxCocoa

protocol PlanetsViewModelType {
    var planets: Observable<[Planet]> { get }
}

class PlanetsViewModel: PlanetsViewModelType {
    
    let service: NetworkService
    
    init(service: NetworkService = ApiService()) {
        self.service = service
    }
    
    var planets: Observable<[Planet]> {
        let resource = PlanetsApi.Planets
        let response: Observable<PlanetsResponse> = service.data(resource: resource)
        let planets: Observable<[Planet]> = response
            .map { $0.results ?? [] }
            .observeOn(MainScheduler.instance)
        return planets
    }
}
