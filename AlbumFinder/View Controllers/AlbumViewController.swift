//
//  AlbumViewController.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 18.09.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

@available(iOS 13.0, *)
class AlbumViewController: UICollectionViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var albums = [Album](){
        didSet {
            if albums.count == 0 {
                if (searchController.searchBar.text != "") {
                    emptyResult.isHidden = false
                    emptyResult.text = "По вашему запросу ничего не найдено"
                } else {
                    emptyResult.text = "Пожалуйста, введите поисковой запрос"
                    emptyResult.isHidden = false
                }
            } else {
                emptyResult.isHidden = true
            }
        }
    }
    
    var themeColor: UIColor = .white
    
    let emptyResult: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, введите поисковой запрос"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(AlbumCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupSearchBar()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if overrideUserInterfaceStyle == .light {
            themeColor = .white
            collectionView.backgroundColor = themeColor
            navigationController?.navigationBar.standardAppearance.backgroundColor = themeColor
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = themeColor
        } else {
            themeColor = .systemFill
            collectionView.backgroundColor = themeColor
            navigationController?.navigationBar.standardAppearance.backgroundColor = themeColor
            navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = themeColor
        }
    }
    
    func setConstraints(){
        view.addSubview(emptyResult)
        
        emptyResult.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyResult.widthAnchor.constraint(equalToConstant: view.frame.width),
            emptyResult.heightAnchor.constraint(equalToConstant: view.frame.width),
            emptyResult.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyResult.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Search view setup
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    // MARK:- UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        
        let imageUrl = albums[indexPath.row].artworkUrl100
        
        cell.backgroundColor = .clear
        cell.albumImage.fetchImage(from: imageUrl!)
        cell.spinnerView.stopAnimating()
        cell.albumTitleLabel.text = albums[indexPath.row].collectionName
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailAlbumViewController()
        let album = albums[indexPath.row]
        let albumID = album.collectionId
        
        detailVC.album = album
        
        
        NetworkManager.shared.fetchAlbumDetails(from: albumID) {(searchResults) in
            guard let tracksCount = searchResults?.results else { return }
            for track in tracksCount {
                if track.wrapperType != "collection" {
                    detailVC.tracks.append(track)
                }
            }
        }
        
        present(detailVC, animated: true)
    }
}

@available(iOS 13.0, *)
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.width / 2) - 16,
            height: (view.frame.width / 2) - 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

// MARK: - UISearchBarDelegate

@available(iOS 13.0, *)
extension AlbumViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkManager.shared.fetchData(from: searchText) { (searchResults) in
            self.albums = searchResults?.results ?? []
            self.collectionView.reloadData()
        }
    }
}
