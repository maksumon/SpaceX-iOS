//
//  ViewController.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var viewModel: LaunchViewModel!
    private let disposeBag = DisposeBag()
    private var rocketId = ""
    
    @IBOutlet weak var segmentedControlYear: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = LaunchViewModel()
        viewModel.launches.drive(onNext: {[unowned self] (_) in
            self.activityIndicator.stopAnimating()
            viewModel.selectedYear = self.segmentedControlYear.titleForSegment(at: self.segmentedControlYear.selectedSegmentIndex)!
            self.updateUI()
        }).disposed(by: disposeBag)
        viewModel
            .isFetching
            .drive(onNext: {[unowned self] (_) in
                self.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        viewModel
          .error
          .drive(onNext: {[unowned self] (error) in
              if error != nil {
                  self.activityIndicator.stopAnimating()
                  self.showErrorAlert(with: error!)
              }
           }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRocketDetail" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.rocketId = self.rocketId
        }
    }
    
    @IBAction func onSegmentedIndexChange(_ sender: Any) {
        viewModel.selectedYear = self.segmentedControlYear.titleForSegment(at: self.segmentedControlYear.selectedSegmentIndex)!
        self.updateUI()
    }
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLaunches
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as! LaunchTableViewCell
        let launch = viewModel.currentLaunch(at: indexPath.row)
        
        cell.lblDate.text = launch?.dateUTC
        cell.lblLaunchNumber.text = launch?.launchpad
        cell.lblDescription.text = launch?.details

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let launch = viewModel.currentLaunch(at: indexPath.row)
        
        self.rocketId = (launch?.rocket!)!
        
        performSegue(withIdentifier: "segueRocketDetail", sender: self)
    }
}
