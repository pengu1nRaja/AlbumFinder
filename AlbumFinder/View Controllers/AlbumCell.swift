//
//  AlbumCell.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import UIKit


class AlbumCell: UICollectionViewCell {
    
    var albumImage: ImageViewManager = {
        let image = ImageViewManager()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    } ()
    
    var spinnerView: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinnerView.center = contentView.center
        
        layoutSubviews()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let albumTitleLabel: UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        title.shadowOffset = CGSize(width: 1, height: 1)
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowRadius = 7
        title.layer.shadowOpacity = 1
        title.layer.shadowOffset = CGSize(width: 4, height: 4)
        title.layer.masksToBounds = false
        title.numberOfLines = 2
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .left
        return title
    } ()
    
    func setup() {
        self.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0, 0.3, 1]
        gradientMaskLayer.frame = albumImage.bounds
        albumImage.layer.mask = gradientMaskLayer

        self.addSubview(albumImage)
        self.addSubview(albumTitleLabel)
        self.addSubview(spinnerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frameWidth = contentView.frame.size.width
        
        albumTitleLabel.frame = CGRect(
            x: 8,
            y: frameWidth / 2 - 10,
            width: frameWidth - 16,
            height: frameWidth - 40)
        
        albumImage.frame = CGRect(
            x: 0,
            y: 0,
            width: frameWidth,
            height: frameWidth)
    }
}
