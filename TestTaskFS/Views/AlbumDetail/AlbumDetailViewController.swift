//
//  AlbumDetailViewController.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 11.12.2020.
//

import UIKit

final class AlbumDetailViewController: UIViewController {
      
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView()
    private var album: Album
    private var tracks: [Track] = []
    private var sections = [
        Section(sectionCell: .description),
        Section(sectionCell: .track),
        Section(sectionCell: .extra)
    ]
    
    // MARK: - Private Nested
    
    private struct Section {
        enum SectionCell {
            case description
            case track
            case extra
        }
        
        let sectionCell: SectionCell
    }
    
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
        view.backgroundColor = .background
        
        setupCollectionView()
        setupActivityIndicator()
        request()
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupLayout()
        collectionView.register(AlbumDescriptionCell.self, forCellWithReuseIdentifier: AlbumDescriptionCell.reuseId)
        collectionView.register(AlbumTrackCell.self, forCellWithReuseIdentifier: AlbumTrackCell.reuseId)
        collectionView.register(AlbumExtraInfoCell.self, forCellWithReuseIdentifier: AlbumExtraInfoCell.reuseId)
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            var height: CGFloat
            
            switch self.sections[section].sectionCell {
            case .description: height = self.view.frame.height
            case .track:       height = 40
            case .extra:       height = 50
            }
            
            let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(height))
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview(size: .init(width: view.frame.width, height: view.frame.height))
        activityIndicator.centerInSuperview()
        activityIndicator.color = .white
        activityIndicator.backgroundColor = .background
        activityIndicator.startAnimating()
    }
      
    private func request() {
        API.request(albumTracks: String(album.collectionId)) { [weak self] in
            switch $0 {
            case .success(let tracks):
                let trackAl = tracks.tracks.dropFirst()
                self?.tracks = Array(trackAl)
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - CollectionViewDataSource & CollectionViewDelegate

extension AlbumDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section].sectionCell {
        case .description: return 1
        case .track:       return tracks.count
        case .extra:       return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section].sectionCell {
        case .description:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDescriptionCell.reuseId, for: indexPath) as! AlbumDescriptionCell
            cell.configure(album)
            return cell
        case .track:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCell.reuseId, for: indexPath) as! AlbumTrackCell
            cell.configure(tracks[indexPath.item])
            return cell
        case .extra:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumExtraInfoCell.reuseId, for: indexPath) as! AlbumExtraInfoCell
            cell.configure(album: album, tracks: tracks)
            return cell
        }
    }
}
