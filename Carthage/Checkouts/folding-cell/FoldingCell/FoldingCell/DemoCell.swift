//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit

class DemoCell: FoldingCell {
  
  @IBOutlet weak var closeNumberLabel: UILabel!
  @IBOutlet weak var openNumberLabel: UILabel!
  
  var number: Int = 0 {
    didSet {
      closeNumberLabel.text = String(number)
      openNumberLabel.text = String(number)
    }
  }
  override func awakeFromNib() {
    
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
}

// MARK: Actions
extension DemoCell {
  
  @IBAction func buttonHandler(_ sender: AnyObject) {
    print("tap")
  }
}
