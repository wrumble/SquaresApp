//
//  ViewController.swift
//  MobivateApp
//
//  Created by Wayne Rumble on 22/11/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit
import StoreKit
import OAStackView
import SnapKit
import GoogleMobileAds

class SquaresViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    let defaults = UserDefaults.standard
    let stackView = OAStackView(frame: CGRect.zero)
    let titleView = TitleView(frame: CGRect.zero)
    let bannerView = BannerView(frame: CGRect.zero)
    let removeAdsView = RemoveAdsView(frame: CGRect.zero)
    
    var squaresCollectionView: UICollectionView!
    var productID: NSString?

    override func viewDidLoad() {
        
        productID = "5DayRemoval"
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        
        view.addSubview(stackView)
        
        addStackView()
        addTitleView()
        addCollectionView()
        addBannerView()
        addRemoveAdsView()
        
        removeAdsView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: removeAdsView, action: #selector(RemoveAdsView.handleTap))
        tap.numberOfTapsRequired = 1
        removeAdsView.addGestureRecognizer(tap)
        
        if (defaults.bool(forKey: "purchased")){
            
            bannerView.isHidden = true
            removeAdsView.isHidden = true
        }
        
    }
    
    func addStackView() {
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(statusBarHeight)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(view.snp.width)
        }
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addTitleView() {
        
        stackView.addArrangedSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
            make.top.equalTo(stackView.snp.top)
            make.width.equalTo(stackView.snp.width)
        }
    }
    
    func addCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        squaresCollectionView = SquaresCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        stackView.addArrangedSubview(squaresCollectionView)
        
        squaresCollectionView.delegate = squaresCollectionView as! UICollectionViewDelegate?
        squaresCollectionView.dataSource = squaresCollectionView as! UICollectionViewDataSource?

        squaresCollectionView.backgroundColor = .white
        squaresCollectionView.showsVerticalScrollIndicator = false
        squaresCollectionView.register(SquaresCollectionViewCell.self, forCellWithReuseIdentifier: "SquaresCollectionViewCell")

        squaresCollectionView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width)
            make.top.equalTo(titleView.snp.bottom)
        }
        
        squaresCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBannerView() {
        
        stackView.addArrangedSubview(bannerView)
        
        bannerView.bannerView.adUnitID = "ca-app-pub-9402251834571012/8922598680"
        bannerView.bannerView.rootViewController = self
        bannerView.bannerView.load(GADRequest())
        
        bannerView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
            make.top.equalTo(stackView.snp.bottom)
            make.width.equalTo(stackView.snp.width)
        }
    }
    
    func addRemoveAdsView() {
        
        stackView.addArrangedSubview(removeAdsView)
                
        removeAdsView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.1)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(stackView.snp.width)
        }
    }
    
    func buyProduct(product: SKProduct){
        print("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
        
    }
    
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let count : Int = response.products.count
        if (count>0) {
            let validProducts = response.products
            let validProduct: SKProduct = validProducts[0] as SKProduct
            if (validProduct.productIdentifier == (self.productID! as String)) {
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(product: validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            print("No products, eeek")
        }
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error Fetching product information");
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    defaults.set(true , forKey: "purchased")
                    bannerView.isHidden = true
                    removeAdsView.isHidden = true
                    break;
                case .failed:
                    print("Purchased Failed");
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                default:
                    break;
                }
            }
        }
    }
}


