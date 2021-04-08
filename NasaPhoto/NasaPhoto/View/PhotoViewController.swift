//
//  ViewController.swift
//  NasaPhoto
//
//  Created by bushra on 07/04/21.
//  Copyright © 2021 bushra. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    let viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.title = "Loading..."
        self.descriptionLabel.text = "Please wait..."
        self.copyrightLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadAstronomyPictures()
    }
    
    func setupUI(_ photo:PhotoInfo) {
        if Reachability.isConnectedToNetwork() {
            let url = URL(string: photo.url)!
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.photo.image = image
                        let yourDataImagePNG = image.pngData()
                        UserDefaults().set(yourDataImagePNG, forKey: "image")
                        UserDefaults().synchronize()
                        
                        self?.title = photo.title
                        self?.descriptionLabel.text = photo.explanation
                        self?.descriptionLabel.sizeToFit()
                        self?.descriptionLabel.adjustsFontSizeToFitWidth = true
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async { [weak self] in
                if let imageData = UserDefaults.standard.object(forKey: "image") as? Data {
                    self?.photo.image = UIImage(data: imageData,scale:1.0)
                }
                self?.title = photo.title
                self?.descriptionLabel.text = photo.explanation
                self?.descriptionLabel.sizeToFit()
                self?.descriptionLabel.adjustsFontSizeToFitWidth = true
                
            }
        }
        
    }
}

extension PhotoViewController: PhotoViewModelProtocol {
    func didloadAstronomyPictures() {
        if let photo = self.viewModel.astronomyPicture {
            if photo.mediaType == "image" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if photo.date == dateFormatter.string(from: Date()) {
                    setupUI(photo)
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.descriptionLabel.text = "We are not connected to the internet, showing you the last image we have."
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4) ) {
                            self?.setupUI( photo)
                        }
                    }
                    
                }
                
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.title = "No media found"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM-dd-yyyy"
                let errorDate = dateFormatter.string(from: Date())
                self?.descriptionLabel.text = "No media found for \(errorDate)"
            }
        }
        
    }
    
}
