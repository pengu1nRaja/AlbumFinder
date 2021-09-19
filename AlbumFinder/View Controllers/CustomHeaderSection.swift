//
//  CustomHeaderSection.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 20.09.2021.
//

import UIKit

class CustomHeaderSection: UITableViewHeaderFooterView {
    
    let title: UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        title.numberOfLines = 2
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .left
        return title
    } ()
    
    let trackCountLabel: UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 14)
        return title
    }()
    
    let artistName: UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return title
    }()

    let image: ImageViewManager = {
        let image = ImageViewManager()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    } ()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Закрыть", for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        contentView.addSubview(image)
        contentView.addSubview(doneButton)
        contentView.addSubview(stackView)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            doneButton.heightAnchor.constraint(equalToConstant: 30),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(artistName)
        stackView.addArrangedSubview(trackCountLabel)
    }

}
