//
//  ViewController.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let viewModel = LaunchViewModel()
    private var rocketId = ""
    
    @IBOutlet weak var segmentedControlYear: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchLaunches()
        self.updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRocketDetail" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.rocketId = self.rocketId
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as! LaunchTableViewCell
        cell.lblDate.text = viewModel.launches[indexPath.row].dateUTC!
        cell.lblLaunchNumber.text = viewModel.launches[indexPath.row].launchpad!
        cell.lblDescription.text = viewModel.launches[indexPath.row].details!

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.rocketId = viewModel.launches[indexPath.row].rocket!
        
        performSegue(withIdentifier: "segueRocketDetail", sender: self)
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

