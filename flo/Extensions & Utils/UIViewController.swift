//
//  UIViewController.swift
//  flo
//
//  Created by Vasyl Nadtochii on 05.04.2023.
//

import UIKit

extension UIViewController: Identifiable {
    var stringIdentifier: String {
        String(UInt(bitPattern: self.id))
    }
}
