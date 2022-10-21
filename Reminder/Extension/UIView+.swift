//
//  UIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/05.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0)}
    }
}
