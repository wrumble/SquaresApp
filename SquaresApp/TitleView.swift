//
//  TitleView.swift
//  SquaresApp
//
//  Created by Wayne Rumble on 23/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import SnapKit

class TitleView: UIView {
    
    var titleText: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        
        titleText = UILabel(frame: CGRect.zero)
        
        titleText.text = "Tappy tap tap a square!"
        titleText.textAlignment = .center
        titleText.numberOfLines = 0
        
        self.addSubview(titleText)
        titleText.translatesAutoresizingMaskIntoConstraints = false
        
        titleText.snp.makeConstraints { make in
            make.edges.equalTo( self.snp.edges )
        }
    
    }
}
