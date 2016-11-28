//
//  RemoveAdsView.swift
//  SquaresApp
//
//  Created by Wayne Rumble on 23/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import SnapKit
import StoreKit

class RemoveAdsView: UIView {
    
    var removeAdsText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        
        removeAdsText = UILabel(frame: CGRect.zero)
        
        removeAdsText.text = "Tap here to remove ads."
        removeAdsText.textAlignment = .center
        removeAdsText.numberOfLines = 0
        
        self.addSubview(removeAdsText)
        removeAdsText.translatesAutoresizingMaskIntoConstraints = false
        
        removeAdsText.snp.makeConstraints { make in
            make.edges.equalTo( self.snp.edges )
        }
    }
    
    func handleTap() {
        
        let rootViewController = window?.rootViewController as! SquaresViewController
        
        if (SKPaymentQueue.canMakePayments())
        {
            let productID:NSSet = NSSet(object: rootViewController.productID!);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
            productsRequest.delegate = rootViewController;
            productsRequest.start();
            print(rootViewController.productID!)
            print("Fetching Products");
        }else{
            print("Can't make purchases");
        }
        
    }
    
}
