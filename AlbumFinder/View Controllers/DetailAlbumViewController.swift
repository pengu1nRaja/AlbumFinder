//
//  DetailAlbumViewController.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import UIKit

@available(iOS 13.0, *)
class DetailAlbumViewController: UITableViewController {
    
    private let cellID = "cell"
    
    var album: Album?
    
    var tracks = [Album]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomHeaderSection.self,
                           forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.sectionHeaderHeight = 200
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
