//
//  AppRouter.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//

import Foundation
import PureLayout

protocol AppRouterProtocol{
    
    func setStart(in window: UIWindow?)
}

class AppRouter: AppRouterProtocol{
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func setStart(in window: UIWindow?) {
        let portfolioVc = PortfolioViewController(router: self)
        let discoverVc = DiscoverViewController(router: self)
        let settingsVc = SettingsViewController(router:self)
        let tabBarCon = UITabBarController()
        portfolioVc.tabBarItem = UITabBarItem(title: "Portfolio", image: .add, selectedImage: .actions)
        discoverVc.tabBarItem = UITabBarItem(title: "Discover", image: .actions, selectedImage: .actions)
        settingsVc.tabBarItem = UITabBarItem(title: "Settings", image: .actions, selectedImage: .actions)
        tabBarCon.viewControllers = [portfolioVc,discoverVc,settingsVc]
        navigationController.setViewControllers([tabBarCon], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showInstrument(instrument:Instrument) {
        let instrumentVc = InstrumentViewController(router: self, instrument: instrument)
        navigationController.pushViewController(instrumentVc, animated: false)
    }
    
    func backToTabMenu(){
        navigationController.popToRootViewController(animated: false)
    }
    
}
