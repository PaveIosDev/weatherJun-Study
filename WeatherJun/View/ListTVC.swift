//
//  ListTVCTableViewController.swift
//  WeatherJun
//
//  Created by Павел Яковенко on 09.08.2022.
//

import UIKit

class ListTVC: UITableViewController {

    let networkWeatherManager = NetworkWeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.fetchWeather()
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "1", for: indexPath)

        // Configure the cell...

        return cell
    }

}
