import UIKit
import SDWebImage
import SquareFlowLayout
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let placeholderImage = UIImage(systemName: "photo")
//    let layout = CustomCollecti
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "gridCell", bundle: nil), forCellWithReuseIdentifier: "gridCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = SquareFlowLayout()
        flowLayout.flowDelegate = self
//        flowLayout.
        self.collectionView.collectionViewLayout = flowLayout
        //UICollectionViewFlowLayout()//createLayout()
        //        placeholderImage.
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
        tableCell.imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground, completed: nil)
        tableCell.imageView.contentMode = .scaleAspectFill
        return tableCell
    }
}

extension ViewController: SquareFlowLayoutDelegate{
    func shouldExpandItem(at indexPath: IndexPath) -> Bool {
        return indexPath.row % 7 == 1
    }
    
    
}
