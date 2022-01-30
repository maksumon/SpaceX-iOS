//
//  RocketViewController.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class RocketViewController: UIViewController {
    private var viewModel: RocketViewModel!
    private let disposeBag = DisposeBag()
    
    var rocketId: String?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageViewRocket: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnWikiLink: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = RocketViewModel(rocketId: rocketId!)
        viewModel
            .rocket
            .drive(onNext: {[unowned self] (_) in
                self.activityIndicator.stopAnimating()
                self.setUIControlsVisibility(isHidden: false)
                self.updateUI()
            })
            .disposed(by: disposeBag)
        viewModel
            .isFetching
            .drive(onNext: {[unowned self] (_) in
                self.activityIndicator.startAnimating()
                self.setUIControlsVisibility(isHidden: true)
            })
            .disposed(by: disposeBag)
        viewModel
          .error
          .drive(onNext: {[unowned self] (error) in
              if error != nil {
                  self.activityIndicator.stopAnimating()
                  self.setUIControlsVisibility(isHidden: true)
                  Utils.showErrorAlert(at: self, with: error!)
              }
           }).disposed(by: disposeBag)
    }

    @IBAction func onWikiPressed(_ sender: Any) {
        let rocket = viewModel.getRocket()
        
        guard let url = URL(string: (rocket?.wikipedia)!) else { return }
        UIApplication.shared.open(url)
    }
    
    private func setUIControlsVisibility(isHidden: Bool) {
        self.imageViewRocket.isHidden = isHidden
        self.lblName.isHidden = isHidden
        self.lblDescription.isHidden = isHidden
        self.btnWikiLink.isHidden = isHidden
    }
    
    private func updateUI() {
        self.activityIndicator.stopAnimating()
        
        let rocket = viewModel.getRocket()
        
        self.imageViewRocket.kf.setImage(
            with: URL(string: rocket?.flickrImages?.first ?? ""),
            placeholder: UIImage(named: "Placeholder"),
            options: nil,
            progressBlock: nil,
            completionHandler: nil
        )
        
        self.lblName.text = rocket?.name!
        self.lblDescription.text = rocket?.details!
    }
}
