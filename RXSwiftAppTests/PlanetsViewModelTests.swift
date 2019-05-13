import XCTest
@testable import RXSwiftApp
import RxSwift
import RxTest
import RxBlocking

class PlanetsViewModelTests: XCTestCase {
    var sut: PlanetsViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        sut = PlanetsViewModel(service: MockApiService())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        super.setUp()
    }
    
    override func tearDown() {
        scheduler = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testPlanets() {
        let scheduler = TestScheduler(initialClock: 0)
        let observer: TestableObserver<[Planet]> = scheduler.createObserver([Planet].self)
        let planets: [Planet] = []
        let expected = [
            Recorded.next(0, planets)
        ]
        
        sut.planets
            .asObservable()
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        XCTAssertEqual(expected.count, observer.events.count)
    }
}
