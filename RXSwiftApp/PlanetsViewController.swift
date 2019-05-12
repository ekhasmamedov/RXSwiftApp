import UIKit
import RxSwift
import RxCocoa

class PlanetsViewController: UIViewController {
    private struct Constants {
        static let cellId: String = "Cell"
    }
    
    let disposeBag = DisposeBag()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
        }
    }
    
    var viewModel: PlanetsViewModel = PlanetsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }
    
    private func setupObservables() {
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: Constants.cellId)) { _, planet, cell in
                cell.textLabel?.text = planet.name
            }
            .disposed(by: disposeBag)
    }
}

