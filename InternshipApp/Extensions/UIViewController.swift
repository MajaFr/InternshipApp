//
//  UIViewController.swift
//  InternshipApp
//
//  Created by Maja Frąk on 28/04/2022.
//

import UIKit

extension UIViewController {
    
    func presentFullScreen(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
