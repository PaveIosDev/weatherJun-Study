//
//  addCity.swift
//  WeatherJun
//
//  Created by Павел Яковенко on 24.08.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func alertPlusCity(name: String, placeHolder: String, completionHandler: @escaping (String) -> Void){
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            completionHandler(text)
        }
        
        alertController.addTextField {(tf) in
            tf.placeholder = placeHolder
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel) { (_) in}
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
