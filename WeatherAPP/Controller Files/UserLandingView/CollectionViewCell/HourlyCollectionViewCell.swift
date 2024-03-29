//
//  HourlyCollectionViewCell.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 31/05/23.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourlyImageVew: UIImageView!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyTime: UILabel!
    // Move the cell to a sperate xib file rather than putting in the collectionview in storyboard
    func configure(hourly: Hourly, indexPath: Int) {
        hourlyTemp.textColor = .white
        hourlyTime.textColor = .white
        hourlyImageVew.contentMode = .scaleAspectFit
        hourlyImageVew.image = UIImage(named: "\(hourly.weather.first!.icon)-1.png")
        hourlyTemp.text = "\(hourly.temp.doubleToString())°"
    }
}
