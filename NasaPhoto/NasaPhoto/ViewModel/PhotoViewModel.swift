//
//  PhotoViewModel.swift
//  NasaPhoto
//
//  Created by bushra on 08/04/21.
//  Copyright © 2021 bushra. All rights reserved.
//

import UIKit

protocol PhotoViewModelProtocol {
    func didloadAstronomyPictures()
}

class PhotoViewModel: NSObject {
    var delegate: PhotoViewModelProtocol?
    var astronomyPicture: PhotoInfo?
    private let requester: APIRequester = APIRequester()
    private let apiCalling: APICalling = APICalling()
    
    func loadAstronomyPictures() {
        apiCalling.fetchPhotoInfo { (photoInfo) in
            if let photo = photoInfo {
                self.astronomyPicture = photo
                self.delegate?.didloadAstronomyPictures()
            }
        }
        
    }
    
}
