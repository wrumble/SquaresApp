////
////  PurchasesHelper.swift
////  SquaresApp
////
////  Created by Wayne Rumble on 02/12/2016.
////  Copyright © 2016 Wayne Rumble. All rights reserved.
////
//
//import UIKit
//import Parse
//
//class PurchaseHelper {
//    
//    func provideContent(forProductIdentifier productIdentifier: String) {
//        if productIdentifier.hasSuffix("monthlyrageface") {
//            if (productIdentifier == "com.youridentifier.inapprage.3monthlyrageface") {
//                self.purchaseSubscription(withMonths: 3)
//            }
//            else {
//                self.purchaseSubscription(withMonths: 6)
//            }
//            // End of new code
//        }
//        else {
//            purchasedProductIdentifiers.append(productIdentifier)
//            UserDefaults.standard.set(true, forKey: productIdentifier)
//            UserDefaults.standard.synchronize()
//        }
//        NotificationCenter.default.post(name: IAPHelperProductPurchasedNotification, object: productIdentifier, userInfo: nil)
//    }
//    
//    func daysRemainingOnSubscription() -> Int {
//        let expirationDate = UserDefaults.standard.object(forKey: "SubscriptionExpirationDateKey")!
//        //2
//        let timeInt = (expirationDate as AnyObject).timeIntervalSince(Date())
//        //3
//        let days = timeInt / 60 / 60 / 24
//        //4
//        if days > 0 {
//            return Int(days)
//        }
//        else {
//            return 0
//        }
//    }
//    
//    func getExpirationDate(forMonths months: Int) -> Date {
//        
//        var originDate: Date? = nil
//        //1
//        if self.daysRemainingOnSubscription() > 0 {
//            originDate = UserDefaults.standard.object(forKey: "SubscriptionExpirationDateKey") as? Date
//        }
//        else {
//            originDate = Date()
//        }
//        //2
//        var dateComp = DateComponents()
//        dateComp.month = months
//        dateComp.day = 1
//        //add an extra day to subscription because we love our users
//        return Calendar.current.date(byAdding: dateComp, to: originDate!)!
//    }
//    
//    func getExpirationDateString() -> String {
//        if self.daysRemainingOnSubscription() > 0 {
//            let today = UserDefaults.standard.object(forKey: "SubscriptionExpirationDateKey")!
//            let dateFormat = DateFormatter()
//            dateFormat.dateFormat = "dd/MM/yyyy"
//            return "Subscribed! \nExpires: \(dateFormat.string(from: today as! Date)) (\(self.daysRemainingOnSubscription()) Days)"
//        }
//        else {
//            return "Not Subscribed"
//        }
//    }
//    
//    func purchaseSubscription(withMonths months: Int) {
//
//        var query = PFQuery(className: "_User")
//        query.getObjectInBackground(withId: PFUser.current()!.objectId!, block: {(_ object: PFObject?, _ error: Error?) -> Void in
//
//            
//            var serverDate = (object?["SubscriptionExpirationDateKey"] as! [String]).last!
//            var localDate = UserDefaults.standard.object(forKey: "SubscriptionExpirationDateKey")!
//
//            if serverDate.compare(localDate) == NSOrderedDescending {
//                UserDefaults.standard.set(serverDate, forKey: "SubscriptionExpirationDateKey")
//                UserDefaults.standard.synchronize()
//            }
//
//            var expirationDate = self.getExpirationDate(forMonths: months)
//            
//            object?.add(expirationDate, forKey: "SubscriptionExpirationDateKey")
//            object?.saveInBackground()
//            UserDefaults.standard.set(expirationDate, forKey: "SubscriptionExpirationDateKey")
//            UserDefaults.standard.synchronize()
//            print("Subscription Complete!")
//        })
//    }
//}
