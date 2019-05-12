import Foundation
import RxSwift
import RxCocoa

protocol PlanetsViewModelType {
    
}

class PlanetsViewModel: PlanetsViewModelType {
    let planets = [
        Planet(name: "Planet 1"),
        Planet(name: "Planet 2")
    ]
    
    lazy var data: Driver<[Planet]> = {
        return Observable.of(planets).asDriver(onErrorJustReturn: [])
    }()
}
