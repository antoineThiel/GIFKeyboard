//
//  Modal.swift
//  GIFKeyboard
//
//  Created by Antoine Thiel on 05/03/2022.
//
import UIKit
import Foundation

class GIFModal: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let apiUtils:ApiUtils = ApiUtils()
    var urls = [String]()
    
    var searchBar:UITextField! = nil
    var customView:UIView! = nil
    var layout:UICollectionViewFlowLayout!
    var collectionView:UICollectionView!
    let reuseIdentifier:String = "Cell"
    var myCell:UICollectionViewCell!
    
    class func newInstanceCustom(customView:UIView, searchBar:UITextField, collectionView:UICollectionView, collectionViewLayout:UICollectionViewFlowLayout) -> GIFModal
    {
        let controller = GIFModal()
        controller.customView = customView
        controller.searchBar = searchBar
        controller.collectionView = collectionView
        controller.layout = collectionViewLayout
        return controller
    }
    
    class func newInstanceDefault(customView: UIView) -> GIFModal {
        let controller = GIFModal()
        controller.customView = customView
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.searchBar == nil {
            self.getDefaultSearchBar()
        }
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
        
        if self.layout == nil {
            self.getDefaultLayout()
        }
        
        if self.collectionView == nil {
            self.getDefaultCollection()
        }
        
        self.collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        self.view.addSubview(self.collectionView)
        
    }
    
    func getDefaultLayout() -> Void {
        let screenWidth = view.frame.width
        self.layout = UICollectionViewFlowLayout.init()
        self.layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        self.layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 10
    }
    
    func getDefaultCollection() -> Void {
        self.collectionView = UICollectionView(frame: CGRect(x: 20, y: 80, width: 300, height: 400), collectionViewLayout: UICollectionViewFlowLayout.init())
        self.collectionView!.collectionViewLayout = layout
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        self.collectionView.backgroundColor = UIColor.clear
    }
    
    func getDefaultSearchBar() -> Void{
        self.searchBar = UITextField(frame: CGRect(x: 20, y: 20, width: 300, height: 40))
        self.searchBar.placeholder = "Search GIF"
        self.searchBar.borderStyle = .roundedRect
        self.searchBar.autocorrectionType = .no
        self.searchBar.keyboardType = .default
        self.searchBar.returnKeyType = .done
        self.searchBar.clearButtonMode = .whileEditing
        self.searchBar.contentVerticalAlignment = .center
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.searchBar.resignFirstResponder()
        guard let text = self.searchBar.text else {
            return false
        }
        self.urls.removeAll()
        apiUtils.getGifBySearchTerm(searchTerm: text){ err, items in
            guard err == nil else {
                return
            }
            guard let gifs = items else {
                return
            }
            for gif in gifs {
                self.urls.append(gif.media[0].tinygif.url)
            }
            //self.collectionView.deleteItems(at: self.collectionView.indexPathsForVisibleItems)
            self.collectionView.reloadData()
        }
        return true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        customView.subviews.forEach({ $0.removeFromSuperview() })
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.customView.addSubview(tappedImage)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.urls.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        let imageURL = UIImage.gifImageWithURL(self.urls[indexPath.row])
        let imageView = UIImageView(image: imageURL)
        imageView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        cell.subviews.forEach({ $0.removeFromSuperview() })
        cell.addSubview(imageView)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let imgView = cell?.subviews[0] else {
            return
        }
        customView.subviews.forEach({ $0.removeFromSuperview() })
        imgView.frame = CGRect(x: 0, y: 0, width: self.customView.frame.width, height: self.customView.frame.height)
        self.customView.addSubview(imgView)
        self.dismiss(animated: true, completion: nil)
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
