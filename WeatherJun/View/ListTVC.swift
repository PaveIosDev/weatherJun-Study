//
//  ListTVCTableViewController.swift
//  WeatherJun
//
//  Created by Павел Яковенко on 09.08.2022.
//

import UIKit

class ListTVC: UITableViewController {
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    let nameCitiesArray = ["Москва", "Санкт-Петербург", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]

    let networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
    }
    
    func addCities(){
        getCityWeather(citiesArray: nameCitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell

    var weather = Weather()
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)
        
        return cell
    }

}
