//
//  GradientView.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-01-30.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class GradientView: UIImageView {
    private let gradient : CAGradientLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.gradient.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gradient.frame = self.bounds
        let colors: [CGColor] = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor]
        gradient.colors = colors
        gradient.isOpaque = true
        gradient.locations = [0.0, 0.25, 0.5, 1.0]
        self.layer.addSublayer(gradient)
    }
}
