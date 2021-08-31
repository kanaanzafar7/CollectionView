import UIKit
import SDWebImage
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let placeholderImage = UIImage(systemName: "photo")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "gridCell", bundle: nil), forCellWithReuseIdentifier: "gridCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = ViewController.createLayout()
//        placeholderImage.
    }
    
    
    static func createLayout () -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1)) )
        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
//        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
        
        let tripletItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
//        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        // Group
        
        let verticalStackGroup  = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitem: verticalStackItem, count: 2)
       
//        verticalStackGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.45)), subitem: tripletItem, count: 3)
//        tripletGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)

        let threeCells = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.55)), subitems: [
            item,verticalStackGroup
        ])
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.75)), subitems: [tripletGroup,
                                                                                                                                                                                     threeCells])
        // Section
        let section = NSCollectionLayoutSection(group: group)
        //return
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 100
//        return StaticInfo.imagesList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tableCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCellId", for: indexPath) as! GridCell
        let url = URL(string: StaticInfo.imagesList[indexPath.row % StaticInfo.imagesList.count ])!
//        tableCell.clipsToBounds = true
        tableCell.imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground, completed: nil)
        tableCell.imageView.contentMode = .scaleAspectFill
//        tableCell.imageView.backgroundColor = .clear
       return tableCell
    }
}

//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//    
//}
