//
//  fadeLabel.swift
//  Ciclyc
//
//  Created by Benjamin Völker on 19/10/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
  func bold(text:String) -> NSMutableAttributedString {
    let font = UIFont.systemFont(ofSize: 12)
    let attrs:[String:AnyObject] = [NSFontAttributeName : font]
    let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
    self.append(boldString)
    return self
  }
  
  func normal(text:String)->NSMutableAttributedString {
    let normal =  NSAttributedString(string: text)
    self.append(normal)
    return self
  }
}
