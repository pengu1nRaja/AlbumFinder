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
    
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(AlbumCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        setupSearchBar()
        setupNavigationBar()
    }
    
    // MARK: - Search view setup
    
    private func setupNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
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
