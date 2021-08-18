//
//  HomeViewController.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import RxSwift
import RxCocoa
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail",
           let detailVC = segue.destination as? AstronautDetailViewController,
           let model = sender as? AstronautModel {
            detailVC.viewModel = AstronautDetailViewModel(modelId: model.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(onSortTapped))
        self.bindTableView()
    }
    
    //MARK: Local Methods
    private func bindTableView() {
        viewModel.astronauts
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "AstronautTableViewCell")) { _,model, cell in
                guard let astronautCell = cell as? AstronautTableViewCell else {
                    return
                }
                astronautCell.configure(model)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AstronautModel.self)
            .subscribe { [weak self] model in
                self?.performSegue(withIdentifier: "show_detail", sender: model.element)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: IBActions
    @objc
    func onSortTapped() {
        viewModel.onSortTapped()
    }
}
