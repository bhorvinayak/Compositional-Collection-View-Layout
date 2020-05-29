/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Orthogonal scrolling section example
*/

import UIKit

class OrthogonalScrollingViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orthogonal Sections"
        configureHierarchy()
        configureDataSource()
    }
}

extension OrthogonalScrollingViewController {

    //   +-----------------------------------------------------+
    //   | +---------------------------------+  +-----------+  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |     1     |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  +-----------+  |
    //   | |               0                 |                 |
    //   | |                                 |  +-----------+  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |     2     |  |
    //   | |                                 |  |           |  |
    //   | |                                 |  |           |  |
    //   | +---------------------------------+  +-----------+  |
    //   +-----------------------------------------------------+

    /// - Tag: Orthogonal
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            let smallItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .fractionalHeight(1.0)))
            smallItem.contentInsets = .init(top: 60, leading: 8, bottom: 0, trailing: 8)
            
            let smallItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                       heightDimension: .fractionalHeight(0.5)),
                                                                    subitem: smallItem, count: 2)
            
            let smallItemMegaGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                                         heightDimension: .fractionalHeight(1.0)),
                                                                      subitem: smallItemGroup, count: 2)
            
            let bigItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                    heightDimension: .fractionalHeight(1.0)))
            bigItem.contentInsets = .init(top: 60, leading: 20, bottom: 20, trailing: 20)
            let bigItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                                   heightDimension: .fractionalHeight(1.0)),
                                                                subitem: bigItem, count: 1)
            
            let topMegaGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2.0),
                                                                                                     heightDimension: .fractionalHeight(1.0)),
                                                                  subitems: [bigItemGroup, smallItemMegaGroup])
            
            let section = NSCollectionLayoutSection(group: topMegaGroup)
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        
        return layout

    }
}

extension OrthogonalScrollingViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.isDirectionalLockEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in

            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell
                else { fatalError("Cannot create new cell") }

            cell.contentView.backgroundColor = .none
            cell.productImage.image = UIImage(named: "immitation")
            cell.productImage.layer.cornerRadius = 20
            cell.productImage.layer.masksToBounds = true
            let indexPath = IndexPath(item: 0, section: 0);
            
            //decide item dimension
            if let cell2 = collectionView.cellForItem(at: indexPath)
            {
                NSLayoutConstraint.activate([
                cell.productImage.widthAnchor.constraint(equalToConstant: 150),
                cell.productImage.heightAnchor.constraint(equalToConstant: 125)

                ])
                
            }else{
                NSLayoutConstraint.activate([
                cell.productImage.widthAnchor.constraint(equalToConstant: 150),
                cell.productImage.heightAnchor.constraint(equalToConstant: 400)

                ])
            }
            
            // Return the cell.
            return cell
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 5
        for section in 0..<1 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            print("maxIdentifier: \(maxIdentifier)")
            print("identifierOffset: \(identifierOffset)")
            print("itemsPerSection: \(itemsPerSection)")
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension OrthogonalScrollingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
