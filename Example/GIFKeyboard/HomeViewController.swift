//
//  HomeViewController.swift
//  GIFKeyboard_Example
//
//  Created by Antoine Thiel on 05/03/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import GIFKeyboard

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var btnGIF: UIButton!
    @IBOutlet weak var customView: UIView!
    let gifKeyboard:GIFKeyboard = GIFKeyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://c.tenor.com/m4b7WPYRxqMAAAAC/snoopy.gif"
        self.gifKeyboard.displayGIFFromURL(viewToAppendTo: self.customView, url: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showModal(_ sender: Any) {
        
        let searchBar = UITextField(frame: CGRect(x: 20, y: 20, width: 300, height: 40))
        searchBar.placeholder = "Search GIFFY"
        searchBar.borderStyle = .roundedRect
        searchBar.autocorrectionType = .no
        searchBar.keyboardType = .default
        searchBar.returnKeyType = .done
        searchBar.clearButtonMode = .whileEditing
        searchBar.contentVerticalAlignment = .center
        
        let screenWidth = view.frame.width
        let collectionView = UICollectionView(frame: CGRect(x: 20, y: 80, width: 300, height: 400), collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = UIColor.blue
        
        self.present(self.gifKeyboard.getGIFModalDefault(view: self.customView), animated: true, completion: nil)
//        self.present(self.gifKeyboard.getGIFModalCustom(view: self.customView, searchBar: searchBar, collection: collectionView, layout: layout), animated: true, completion: nil)
    }
    
}
