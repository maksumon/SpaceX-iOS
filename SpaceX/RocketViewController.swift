//
//  RocketViewController.swift
//  SpaceX
//
//  Created by Mohammad Ashraful Kabir on 29/01/2022.
//

import UIKit

class RocketViewController: UIViewController {

    var rocketId: String?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageViewRocket: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnWikiLink: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onWikiPressed(_ sender: Any) {
    }
}
