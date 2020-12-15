//
//  AlbumViewController.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import UIKit

final class AlbumViewController: UIViewController {
        
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var albums: [Album] = []
    private let stateView = StateView()
  
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        stateView.networkMonitor()
        
        setupCollectionView()
        setupSearchController()
        initStateView()
    }
    
    // MARK: - Private Methods
    
    private func initStateView() {
        view.addSubview(stateView)
        stateView.centerInSuperview(size: .init(width: view.frame.width, height: view.frame.height))
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupLayout()
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: AlbumCell.reuseId)
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 3)
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16.0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
    }
    
    private func setupSearchController() {
        navigationItem.title = "Search Album"
        navigationController?.navigationBar.tintColor = .appleRed
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.textColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).keyboardAppearance = .dark
    }
    
    private func request(_ searchText: String) {
        API.request(album: searchText.removeSpaces()) { [weak self] in
            switch $0 {
            case .success(let albums):
                if albums.albums.isEmpty { self?.stateView.currently(.invalidResult) }
                self?.albums = albums.albums.sorted(by: { $0.collectionName < $1.collectionName })
                self?.collectionView.reloadData()
                
                guard Reachability.isConnectedToNetwork() else {
                    self?.stateView.currently(.error)
                    return
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension AlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.reuseId, for: indexPath) as! AlbumCell
        cell.configure(albums[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = AlbumDetailViewController(album: albums[indexPath.item])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - SearchBarDelegate

extension AlbumViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard Reachability.isConnectedToNetwork() else {
            self.stateView.currently(.error)
            return
        }
        searchText.isEmpty ? stateView.currently(.empty) : stateView.currently(.validResult)
        request(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard Reachability.isConnectedToNetwork() else {
            self.stateView.currently(.error)
            return
        }
        stateView.currently(.empty)
    }
}
