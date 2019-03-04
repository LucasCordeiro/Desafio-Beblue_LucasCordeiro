//
//  MarsRoverPhotoCollectionViewCell.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 04/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie

class MarsRoverPhotoCollectionViewCell: UICollectionViewCell {

    //
    // MARK: - Outlets -
    @IBOutlet weak var marsRoverImageViewOutlet: UIImageView!
    @IBOutlet weak var loadingAnimationView: LOTAnimationView!

    //
    // MARK: - Life Cycle Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //
    // MARK: - Configure Methods -
    func configureCell(photoUrl: URL) {

        loadingAnimationView.isHidden = false
        loadingAnimationView.loopAnimation = true
        loadingAnimationView.play()
        marsRoverImageViewOutlet?.sd_setImage(with: photoUrl,
                                              placeholderImage: nil,
                                              options: .continueInBackground,
                                              completed: { [weak self] (_, error, _, _) in
            DispatchQueue.main.async {
                self?.loadingAnimationView.stop()
                self?.loadingAnimationView.isHidden = true
                if error != nil {
                    self?.marsRoverImageViewOutlet.image = #imageLiteral(resourceName: "mars.png")
                }
            }
        })
    }
}
