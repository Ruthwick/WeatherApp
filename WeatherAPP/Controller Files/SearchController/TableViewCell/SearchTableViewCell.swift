//
//  SearchTableViewCell.swift
//  WeatherAPP
//
//  Created by Ruthwick S Rai on 01/06/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    func configure(filteredCities: SearchCellViewModel) {
        cityName.text = filteredCities.city
        countryName.text = filteredCities.country
        self.backgroundColor = .clear
    }

}
