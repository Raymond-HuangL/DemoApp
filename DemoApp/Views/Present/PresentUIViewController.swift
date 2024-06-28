//
//  PresentUIViewController.swift
//  DemoApp
//
//  Created by 黄磊 on 2023/4/24.
//

import Foundation
import UIKit

class PresentUIViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
        
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
        button.frame.size = button.intrinsicContentSize
        button.center = self.view.center
        button.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    @objc
    func buttonClick() {
        self.dismiss(animated: true)
    }
}
