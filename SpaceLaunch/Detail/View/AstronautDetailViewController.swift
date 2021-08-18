//
//  AstronautDetailViewController.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 17/8/21.
//

import UIKit
import RxSwift

class AstronautDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    private let disposeBag = DisposeBag()
    
    var viewModel: AstronautDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        self.bindData()
    }
    
    private func bindData() {
        viewModel.astronautDetails
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] astronautDetailModel in
                self?.configure(astronautDetailModel)
            })
            .disposed(by: disposeBag)
    }

    private func configure(_ model: AstronautDetailModel?) {
        self.nameLabel.text         =   model?.name
        self.nationalityLabel.text  =   model?.nationality
        self.dobLabel.text          =   model?.date_of_birth
        self.bioLabel.text          =   model?.bio
        
        if let imageUrl = model?.profile_image {
            ImageFetcher.shared
                .getImageFromURL(urlString: imageUrl)
                .subscribe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] image in
                    self?.profileImageView.image = image
                }, onError: { [weak self] _ in
                    self?.profileImageView.image  =   UIImage(named: "user_placeholder")
                })
                .disposed(by: disposeBag)
        }
    }
    
}
