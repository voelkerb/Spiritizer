//
//  Settings.swift
//  Ciclyc
//
//  Created by Benjamin Völker on 16/09/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class Settings: NSObject {
  
  
  
  static let commandPrefix = "!"
  static let bottlePrefix = "b"
  static let juicePrefix = "j"
  static let sugarPrefix = "s"
  static let finishPrefix = "f"
  static let resetPrefix = "r"
  
  static let vodka = "Vodka"
  static let rum = "Rum"
  static let peach = "Peach"
  static let tequila = "Tequila"
  static let grenadine = "Grenadine"
  static let gin = "Gin"
  
  static let osaft = "Orange"
  static let lime = "Lime"
  static let cranberry = "Cranberry"
  static let soda = "Soda"
  static let tonic = "Tonic"
  static let cola = "Cola"
  
  static let nothing = "Non"
  
  var ingredientBottle:[Ingredient.Substance] = [.vodka, .rum, .peach, .tequila, .grenadine, .gin]
  var ingredientJuice:[Ingredient.Substance] = [.orangeJuice, .limeJuice, .cranberryJuice, .soda, .tonic, .cola]
  var availableBottle:[String] = [nothing, vodka, rum, peach, tequila, grenadine, gin]
  var bottle:[String] = [vodka, rum, peach, tequila, grenadine, gin]
  var availableJuice:[String] = [nothing, osaft, lime, cranberry, soda, tonic, cola]
  var juice:[String] = [osaft, lime, cranberry, soda, tonic, cola]
  
  var host:String = "10.0.0.1"

  
  // This class is singletone
  static let sharedInstance = Settings()
  
  // Making thia function private prevents others from using the default '()' initializer for this class.
  private override init() {
    // Try to decode all data from user defaults
    if let userSelectedData = UserDefaults.standard.object(forKey: "bottles") as? NSData {
      if let userSelectedBottle = NSKeyedUnarchiver.unarchiveObject(with: userSelectedData as Data) as? [String] {
        bottle = userSelectedBottle
      }
    }
    if let userSelectedData = UserDefaults.standard.object(forKey: "juice") as? NSData {
      if let userSelectedJuice = NSKeyedUnarchiver.unarchiveObject(with: userSelectedData as Data) as? [String] {
        juice = userSelectedJuice
      }
    }
    if let userSelectedData = UserDefaults.standard.object(forKey: "host") as? NSData {
      if let userSelectedHost = NSKeyedUnarchiver.unarchiveObject(with: userSelectedData as Data) as? String {
        host = userSelectedHost
      }
    }
  }


  /*
   * Stores all data in user defaults
   */
  func store() {
    
    var data : NSData = NSKeyedArchiver.archivedData(withRootObject: bottle) as NSData
    UserDefaults.standard.set(data, forKey: "bottles")
    
    data = NSKeyedArchiver.archivedData(withRootObject: juice) as NSData
    UserDefaults.standard.set(data, forKey: "juice")
    
    data = NSKeyedArchiver.archivedData(withRootObject: host) as NSData
    UserDefaults.standard.set(data, forKey: "host")
    
    UserDefaults.standard.synchronize()
 
  }
  
  func getBottleForAlcohol(alcohol: String)->Int {
    return bottle.index(of: alcohol)!;
  }
  
  func bottleForSubstance(_ substance: Ingredient.Substance)->Int {
    var index = ingredientBottle.index(of: substance)
    if index != nil {
      if index! > -1 && index! < ingredientBottle.count {
        return index!
      }
    }
    index = ingredientJuice.index(of: substance)
    if index != nil {
      if index! > -1 && index! < ingredientJuice.count {
        return index!
      }
    }
    return -1
  }
  
  func getBottleForJuice(theJuice: String)->Int {
    return juice.index(of: theJuice)!;
  }
  
  

}
