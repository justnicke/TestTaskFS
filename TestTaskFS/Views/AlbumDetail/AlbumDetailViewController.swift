//
//  AlbumDetailViewController.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

final class AlbumDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private var album: Album
    private var tracks: [Track] = []
    
    
    // MARK: - Constructors
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
                
        setupCollectionView()
        
        API.request(albumTracks: String(album.collectionId)) { [weak self] (track, error) in
            guard let trackAl = track?.tracks.dropFirst() else { return }
            self?.tracks = Array(trackAl)
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupLayout()
        collectionView.register(AlbumDescriptionCell.self, forCellWithReuseIdentifier: AlbumDescriptionCell.reuseId)
        collectionView.register(AlbumTrackCell.self, forCellWithReuseIdentifier: AlbumTrackCell.reuseId)
        collectionView.register(AlbumExtraInfoCell.self, forCellWithReuseIdentifier: AlbumExtraInfoCell.reuseId)
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            var estimatedHeight: CGFloat
            
            switch section {
            case 0: estimatedHeight = self.view.frame.height / 3
            case 1: estimatedHeight = 40
            case 2: estimatedHeight = 50
            default: fatalError()
            }
            
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
            
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension AlbumDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return tracks.count
        case 2: return 1
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDescriptionCell.reuseId, for: indexPath) as! AlbumDescriptionCell
            cell.backgroundColor = .blue
            cell.configure(album: album)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCell.reuseId, for: indexPath) as! AlbumTrackCell
            cell.backgroundColor = .black
            cell.configure(track: tracks[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumExtraInfoCell.reuseId, for: indexPath) as! AlbumExtraInfoCell
            cell.configure(album: album, tracks: tracks)
            cell.backgroundColor = .black
            return cell
        default: return UICollectionViewCell()
        }
        

    }
}
