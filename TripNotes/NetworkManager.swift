//
//  NetworkManager.swift
//  
//
//  Created by John Park on 12/5/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static func getCities(input: String) -> [City] {
//DEBUG        print("attempted1")
        // GoogleAPI
        let googlePlacesAPI: String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        let space: String = "%20"
        let googleAPIkey: String = "&key=AIzaSyCympdqfdlfyrj-tJ8XzE5YFiWpaZCD8pU"
        
        var cities: [City] = []
        let input: String = "input=" + input.replacingOccurrences(of: " ", with: space)
        let url: String = googlePlacesAPI + input + googleAPIkey
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case let .success(data):
                    let json = JSON(data)
//DEBUG                    print("attempted2")
                    if json["predictions"].array?.first?["description"].string != nil {
                        var counter: Int = 0
                        while counter != json["predictions"].array?.count {
                            let ret: String = (json["predictions"].array?[counter]["description"].string)!
                            print(ret)
                            cities.append(City(label: ret, notes: ""))
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
