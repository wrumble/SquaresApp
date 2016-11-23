//
//  ViewController.swift
//  MobivateApp
//
//  Created by Wayne Rumble on 22/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SquaresViewController: UIViewController, UICollectionViewDelegate {
    
    let squaresDataSource = SquaresDataSource()
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet var squaresCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-9402251834571012/8922598680"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        squaresCollectionView.dataSource = squaresDataSource

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)! as! SquaresCollectionViewCell
        cell.contentView.backgroundColor! = UIColor.lightGray
        cell.number.textColor = UIColor.black
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    
    
}


