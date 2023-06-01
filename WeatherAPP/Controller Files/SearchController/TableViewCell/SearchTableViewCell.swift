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
    
    // Move the cell to a sperate xib file rather than putting in the tableView in storyboard
    
    func configure(filteredCities: SearchCellViewModel) {
        cityName.text = filteredCities.city
        countryName.text = filteredCities.country
        self.backgroundColor = .clear
    }

}
