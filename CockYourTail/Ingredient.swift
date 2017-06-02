//
//  Ingredient.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 28/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class Ingredient: NSObject {
  
  enum Substance {
    case vodka, gin, rum, peach, tequila, grenadine, tonic, cola, orangeJuice, limeJuice, soda, cranberryJuice, lime, mint, sugar, crushedIce, diceIce
  }
  
  enum `Type` {
    case alcohol, nonAlcohol, other
  }
  
  var amount: Int
  var substance: Substance
  var type: Type

  convenience init(_ substance: Substance) {
    self.init(substance, amount: 0)
  }
    
  init(_ substance: Substance, amount: Int) {
    self.substance = substance
    self.amount = amount
    self.type = .alcohol

    switch substance {
    case .mint:
      self.type = .other
    case .sugar:
      self.type = .other
    case .lime:
      self.type = .other
    case .crushedIce:
      self.type = .other
    case .diceIce:
      self.type = .other
    case .cranberryJuice:
      self.type = .nonAlcohol
    case .limeJuice:
      self.type = .nonAlcohol
    case .orangeJuice:
      self.type = .nonAlcohol
    case .cola:
      self.type = .nonAlcohol
    case .soda:
      self.type = .nonAlcohol
    case .tonic:
      self.type = .nonAlcohol
    case .grenadine:
      self.type = .nonAlcohol
    default:
      self.type = .alcohol
    }
  }
  
  func color()->UIColor {
    switch substance {
    case .peach:
      return UIColor.orange.withAlphaComponent(0.5)
    case .rum:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .tequila:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .gin:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .vodka:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .cranberryJuice:
      return UIColor.red.withAlphaComponent(0.5)
    case .orangeJuice:
      return UIColor.yellow.withAlphaComponent(0.5)
    case .cola:
      return UIColor.black.withAlphaComponent(0.5)
    case .soda:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .tonic:
      return UIColor.lightGray.withAlphaComponent(0.5)
    case .grenadine:
      return UIColor.red.withAlphaComponent(0.5)
    case .limeJuice:
      return UIColor.green.withAlphaComponent(0.5)
    default:
      return UIColor.black
    }
  }
  
  
  let vodkaColor = UIColor.lightGray.withAlphaComponent(0.5)
  let ginColor = UIColor.lightGray.withAlphaComponent(0.5)
  let rumColor = UIColor.lightGray.withAlphaComponent(0.5)
  let peachColor = UIColor.orange.withAlphaComponent(0.5)
  let tequilaColor = UIColor.lightGray.withAlphaComponent(0.5)
  let grenadineColor = UIColor.red.withAlphaComponent(0.5)
  
  let TonicColor = UIColor.lightGray.withAlphaComponent(0.5)
  let ColaColor = UIColor.black.withAlphaComponent(0.5)
  let OSaftColor = UIColor.yellow.withAlphaComponent(0.5)
  let LimeColor = UIColor.green.withAlphaComponent(0.5)
  let SodaColor = UIColor.lightGray.withAlphaComponent(0.5)
  let CranberryColor = UIColor.red.withAlphaComponent(0.5)
  
  func unit()->String {
    var unit = ""
    switch substance {
    case .mint:
      if amount < 2 {
        unit = "leave"
      } else {
        unit = "leaves"
      }
    case .lime:
      if amount == 1 {
        unit = "piece"
      } else {
        unit = "pieces"
      }
    case .sugar:
      if amount == 1 {
        unit = "spoon"
      } else {
        unit = "spoons"
      }
    default:
      unit = "cl"
    }
    return unit
  }
  
  func getCommand()->String {
    if self.substance == .sugar && amount > 0 {
      return Settings.commandPrefix + Settings.sugarPrefix + "\(self.amount)"
    }
  
    var str = Settings.commandPrefix
    let index = Settings.sharedInstance.bottleForSubstance(substance)
    if index < 0 {
      return ""
    }
    
    if self.type == .alcohol || self.substance == .grenadine {
      str += Settings.bottlePrefix
    } else {
      str += Settings.juicePrefix
    }
    str = strForAmount(amount: self.amount, bottle: index, prefix: str)
    
    return str
  }
  
  
  func strForAmount(amount: Int, bottle: Int, prefix: String) -> String {
    if amount == 0 {
      return ""
    }
    
    var loop:Int = amount/9
    let rest:Int = amount % 9
    var str = ""
    while loop > 0 {
      str += prefix
      str += "9"
      str += "\(bottle)"
      loop = loop - 1
    }
    if rest != 0 {
      str += prefix
      str += "\(rest)"
      str += "\(bottle)"
    }
    
    return str
  }
  
  override var description: String {
    var str = ""
    switch substance {
    case .rum:
      str += "Rum:"
    case .vodka:
      str += "Vodka:"
    case .gin:
      str += "Gin:"
    case .peach:
      str += "Peach:"
    case .tequila:
      str += "Tequila:"
    case .grenadine:
      str += "Grenadine:"
    case .tonic:
      str += "Tonic:"
    case .cola:
      str += "Cola:"
    case .orangeJuice:
      str += "Orange Juice:"
    case .limeJuice:
      str += "Lime Juice:"
    case .cranberryJuice:
      str += "Cranberry Juice:"
    case .soda:
      str += "Soda:"
    case .lime:
      str += "Lime:"
    case .mint:
      str += "Mint:"
    case .sugar:
      str += "Sugar:"
    case .diceIce:
      str += "Dice Ice"
      return str
    case .crushedIce:
      str += "Crushed Ice"
      return str
    default:
      str += "Unknown Ingredient"
    }
    
    str += " \(amount) \(unit())"
    
    return str
  }
}
