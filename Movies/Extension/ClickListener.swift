//
//  ClickListener.swift
//  Movies
//
//  Created by Vaibhav Gawde on 09/06/24.
//

import Foundation
import UIKit

class clickGesture : UITapGestureRecognizer {
    var onClick :(() -> Void)? = nil
}

extension UIView {
    
    func setOnClickListener(action : @escaping () -> Void){
        
        let tapGesture = clickGesture(target: self, action: #selector(onViewClick(sender: )))
        tapGesture.onClick = action
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func onViewClick(sender : clickGesture){
        if let click = sender.onClick {
            click()
        }
    }
}
