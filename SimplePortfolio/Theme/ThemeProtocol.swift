//
//  ThemeProtocol.swift
//  SimplePortfolio
//
//  Created by Lovre on 01/06/2021.
//

import Foundation
import UIKit

protocol ThemeProtocol{
    var greenColor:UIColor { get }
    var redColor:UIColor { get }
    var backgroundColor:UIColor { get }
    var fontColor:UIColor { get }
    var placeholderColor:UIColor { get }
    var textFieldColor:UIColor { get }
    var cellColor:UIColor { get }
}
