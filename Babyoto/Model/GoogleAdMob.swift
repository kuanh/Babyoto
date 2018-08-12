//
//  GoogleAdMob.swift
//  BabyOto
//
//  Created by Developer on 8/6/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import GoogleMobileAds

//MARK: - Google Ads Unit ID
struct GoogleAdsUnitID {
    static var strBannerAdsID = "ca-app-pub-3940256099942544/2934735716"
}

//MARK: - Banner View Size
struct BannerViewSize {
    static var screenWidth = UIScreen.main.bounds.size.width
    static var screenHeight = UIScreen.main.bounds.size.height
    static var height = CGFloat((UIDevice.current.userInterfaceIdiom == .pad ? 90 : 50))
}
//MARK: - Create GoogleAdMob Class
class GoogleAdMob:NSObject, GADBannerViewDelegate {
    
    //MARK: - Shared Instance
    static let sharedInstance : GoogleAdMob = {
        let instance = GoogleAdMob()
        return instance
    }()
    
    //MARK: - Variable
    private var isBannerViewDisplay = false
    
    private var isInitializeBannerView = false
    private var bannerView: GADBannerView!
    
    
    //MARK: - Create Banner View
    func initializeBannerView() {
        self.isInitializeBannerView = true
        self.createBannerView()
    }
    @objc private func createBannerView() {
        
        print("GoogleAdMob : create")
        if UIApplication.shared.keyWindow?.rootViewController == nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(createBannerView), object: nil)
            self.perform(#selector(createBannerView), with: nil, afterDelay: 0.5)
        } else {
            
            isBannerViewDisplay = true
            bannerView = GADBannerView(frame: CGRect(
                x:0 ,
                y:BannerViewSize.screenHeight - BannerViewSize.height ,
                width:BannerViewSize.screenWidth ,
                height:BannerViewSize.height))
            self.bannerView.adUnitID = GoogleAdsUnitID.strBannerAdsID
            self.bannerView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
            self.bannerView.delegate = self
            self.bannerView.backgroundColor = .gray
            self.bannerView.load(GADRequest())
            UIApplication.shared.keyWindow?.addSubview(bannerView)
        }
    }
    //MARK: - GADBannerView Delegate
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        
        print("adViewDidReceiveAd")
    }
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        
        print("adViewDidDismissScreen")
    }
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        
        print("adViewWillDismissScreen")
    }
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        
        print("adViewWillPresentScreen")
    }
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        
        print("adViewWillLeaveApplication")
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        
        print("adView")
    }
}

