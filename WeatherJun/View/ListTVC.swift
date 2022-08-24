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
    var filterCiryArray = [Weather]()
    
    var nameCitiesArray = ["Москва", "Санкт-Петербург", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]

    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    
    @IBAction func pressPlusButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeHolder: "Введите название города") { [self] (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
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

        if isFiltering {
            return filterCiryArray.count
        }
        
        
        
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell

    var weather = Weather()
        
        if isFiltering {
            weather = filterCiryArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
    
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [self] (_, _, completionHandler) in
            let editingRow = self.nameCitiesArray[indexPath.row]
            
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                if isFiltering {
                    self.filterCiryArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)

                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCiryArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = filter
            } else {
                let cityWeather = citiesArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = cityWeather
            }
        }
    }
}

extension ListTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
    filterCiryArray = citiesArray.filter{
        $0.name.contains(searchText)
    }
    tableView.reloadData()
    }
}
