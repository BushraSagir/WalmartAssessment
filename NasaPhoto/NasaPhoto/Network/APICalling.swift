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
    var model = PhotoInfo.sharedInstance
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
                    completion(self?.model)
                 } catch let error {
                    print(error)
                 }
             }
             task.resume()
        } else {
            completion(model)
        }
        
    }

}
