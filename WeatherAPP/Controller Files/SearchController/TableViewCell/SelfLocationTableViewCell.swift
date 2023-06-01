//
//  SelfLocationTableViewCell.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import UIKit

class SelfLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure() {
        self.locationLabel.text = "Use current location".localize
    }
}
