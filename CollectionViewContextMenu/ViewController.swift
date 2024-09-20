//
//  ViewController.swift
//  CollectionViewContextMenu
//
//  Created by Saadet Şimşek on 12/09/2024.
//

import UIKit

class ViewController: UIViewController {
    
    let imageName = Array(1...6).map {"image\($0)"}
    
    var favorites = [Int]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(named: imageName[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2)-4,
                      height: (view.frame.size.width/2)-4)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) {[weak self] _ in
            let open = UIAction(title: "Open",
                                image: UIImage(systemName: "link"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                             //   attributes: .disabled,
                                state: .off) { _ in
                print("Tapped")
            }
            
            let copy = UIAction(title: "Copy",
                                image: UIImage(systemName: "link"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                             //   attributes: .disabled,
                                state: .off) { _ in
                print("Tapped copy ")
            }
            
            let favorite = UIAction(title: self?.favorites.contains(indexPath.row) == true ? "Remove Favorite" : "Favorite",
                                image: UIImage(systemName: "star"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                             //   attributes: .disabled,
                                state: .off) { [weak self]_ in
                if self?.favorites.contains(indexPath.row) == true {
                    self?.favorites.removeAll(where:{ $0 == indexPath.row})
                }
                else{
                    self?.favorites.append(indexPath.row)
                }
                print("Tapped Favorite")
            }
            
            let search = UIAction(title: "Search",
                                image: UIImage(systemName: "magnifyingglass"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                             //   attributes: .disabled,
                                state: .off) { _ in
                print("Tapped Search")
            }
            
            
            return UIMenu(title: "Actions",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [open, favorite, search, copy]
            )
        }
        return config
    }
    
}
