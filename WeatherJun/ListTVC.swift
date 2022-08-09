//
//  ListTVCTableViewController.swift
//  WeatherJun
//
//  Created by Павел Яковенко on 09.08.2022.
//

import UIKit

class ListTVCTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchWeather()
        
    }
    
    func fetchWeather(){
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat = 59.938955? lon = 30.315644"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("809df148-c11c-4b50-83f1-ab4e90af598a", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}
