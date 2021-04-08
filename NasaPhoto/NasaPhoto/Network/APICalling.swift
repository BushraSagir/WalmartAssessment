//
//  APICalling.swift
//  NasaPhoto
//
//  Created by bushra on 08/04/21.
//  Copyright © 2021 bushra. All rights reserved.
//

import UIKit
class APICalling {
    var dateToSearch: Date = Date()
    var model:PhotoInfo?

//    var model = UserDefaults.standard.getObject(forKey: "lastPhoto", castTo: PhotoInfo.self)
    func parseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dateToSearch)
    }
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let request = APIRequester().request()
        if Reachability.isConnectedToNetwork() {
             let task = URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
                 do {
                    self?.model = try JSONDecoder().decode(PhotoInfo.self, from: data ?? Data())
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(self?.model) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "SavedPhoto")
                    }
                    completion(self?.model)
                 } catch let error {
                    print(error)
                 }
             }
             task.resume()
        } else {
            if let data = UserDefaults.standard.data(forKey: "SavedPhoto") {
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()

                    // Decode Model
                    model = try decoder.decode(PhotoInfo.self, from: data)

                } catch {
                    print("Unable to Decode Photo (\(error))")
                }
            }
            completion(model)
        }
        
    }

}
