//
//  CoordinatorUINavigationController.swift
//  flo
//
//  Created by Vasyl Nadtochii on 05.04.2023.
//

import UIKit

class CoordinatorUINavigationController: UINavigationController {
    
    let disappearAction: () -> Void
    
    init(rootViewController: UIViewController, disappearAction: @escaping () -> Void) {
        self.disappearAction = disappearAction
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disappearAction()
    }
}
