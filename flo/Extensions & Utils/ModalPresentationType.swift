//
//  ModalPresentationType.swift
//  flo
//
//  Created by Vasyl Nadtochii on 06.04.2023.
//

import Foundation

extension Coordinator.ModalPresentationType {
    
    enum SheetSizeModifier {
        case fixed(height: CGFloat)
        case relative(maxHeightMultiplier: CGFloat)
    }
}
