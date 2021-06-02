//
//  UIViewController+ThemeManager.swift
//  SimplePortfolio
//
//  Created by Lovre on 01/06/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func getTheme(key:ThemeKey) -> ThemeProtocol{
        switch(key){
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
    
    func setTheme(themeKey:ThemeKey){
        let themeName = themeKey.rawValue
        UserDefaults().setValue(themeName, forKey: "theme")
    }
    
    func getCurrentTheme() -> ThemeProtocol{
        let string = UserDefaults().string(forKey: "theme")
        let themekey = ThemeKey(rawValue: string!)
        return getTheme(key: themekey!)
    }
}
