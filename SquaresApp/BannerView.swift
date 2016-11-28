//
//  BannerView.swift
//  SquaresApp
//
//  Created by Wayne Rumble on 24/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SnapKit

class BannerView: UIView {
    
    var bannerView: GADBannerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        
        bannerView = GADBannerView(frame: CGRect.zero)
        
        self.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp.edges)
        }

    }
}
