//
//  NetworkManager.swift
//  TripNotes
//
//  Created by John Park on 11/30/17.
//  Copyright © 2017 John Park. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    //Powered by Google
    let googlePlacesAPI: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    let space: String = "%20"
    let googleAPIkey: String = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
    
    func getCities(parameter: String) -> [City] {
        var cities: [City] = []
        let input: String = "input=" + parameter.replacingOccurrences(of: " ", with: space)
        let url: String = googlePlacesAPI + input + googleAPIkey
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
                    if (json["predictions"].array?.first?["description"].string) != nil {
                        var counter: Int = 0
                        while counter != json["predictions"].array?.count {
                            let description: String = (json["predictions"].array?[counter]["description"].string)!
                            cities.append(City(description: description))
                            counter += 1
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        return cities
    }
}
