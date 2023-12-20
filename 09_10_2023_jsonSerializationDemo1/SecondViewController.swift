//
//  SecondViewController.swift
//  09_10_2023_jsonSerializationDemo1
//
//  Created by Vishal Jagtap on 20/12/23.
//

import UIKit
import SDWebImage
import Kingfisher

class SecondViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://via.placeholder.com/600/92c952")
        //use sdwebimage
//        imageView.sd_setImage(with: url)
        
        //use kingfisher
        imageView.kf.setImage(with: url)
    }
}
