//
//  AstronautTableViewCell.swift
//  SpaceLaunch
//
//  Created by Shahjahan Rana on 16/8/21.
//

import UIKit
import RxCocoa
import RxSwift

class AstronautTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!

    private var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(_ model: AstronautModel) {
        self.nameLabel.text = model.name
        self.nationalityLabel.text = model.nationality
        if let thumbnailUrl = model.profile_image_thumbnail {
            ImageFetcher.shared
                .getImageFromURL(urlString: thumbnailUrl)
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
