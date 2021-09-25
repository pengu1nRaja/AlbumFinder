//
//  DetailAlbumViewController.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import UIKit

class DetailAlbumViewController: UITableViewController {
    
    private let cellID = "cell"
    
    var album: Album?
    
    var tracks = [Album]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var spinnerView: UIActivityIndicatorView! = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomHeaderSection.self,
                           forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.sectionHeaderHeight = 200
        tableView.backgroundView = spinnerView
    }
    
    @objc func closeWindows() {
        dismiss(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        
        cell.textLabel?.text = tracks[indexPath.row].trackName
        spinnerView.stopAnimating()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "sectionHeader") as? CustomHeaderSection
        
        view?.title.text = album?.collectionName ?? "Без названия"
        view?.artistName.text = album?.artistName ?? "Без названия"
        view?.trackCountLabel.text = "Количество треков: \(album?.trackCount ?? 0)"
        view?.doneButton.addTarget(self, action: #selector(closeWindows), for: .touchUpInside)
        
        let imageUrl = album?.artworkUrl100 ?? ""
        
        view?.image.fetchImage(from: imageUrl)
        
        return view
    }
}
