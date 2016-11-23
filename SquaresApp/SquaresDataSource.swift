//
//  SquareDataSource.swift
//  MobivateApp
//
//  Created by Wayne Rumble on 22/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class SquaresDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfSquares = arc4random_uniform(40) + 9
        return Int(numberOfSquares)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "SquaresCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! SquaresCollectionViewCell
        cell.contentView.backgroundColor = UIColor(red: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                                   green: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                                   blue: CGFloat(Double(arc4random_uniform(101)) / 100.0),
                                                   alpha: 1.0)
        let number = Int(arc4random_uniform(100))
        cell.number.text = "\(number)"
        cell.number.textColor = cell.contentView.backgroundColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        cell.contentView.backgroundColor! = UIColor.lightGray
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
