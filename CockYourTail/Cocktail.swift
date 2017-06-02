//
//  Cocktail.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 13/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import Foundation
import UIKit

class Cocktail {
  
  var name = "New Cocktail"
  var image = UIImage(named: "Mojito")
  
  
  var ingredients:[Ingredient]! = [Ingredient]()
  
  
  func containsAlcohol()->Bool {
    for ingredient in ingredients {
      if ingredient.type == .alcohol {
        return true
      }
    }
    return false
  }
  
  
  func containsNonAlcohol()->Bool {
    for ingredient in ingredients {
      if ingredient.type == .nonAlcohol {
        return true
      }
    }
    return false
  }
  
  
  func containsOther()->Bool {
    for ingredient in ingredients {
      if ingredient.type == .other {
        return true
      }
    }
    return false
  }
  
  func getAlcoholIngredients()->[Ingredient] {
    var alcohol:[Ingredient]! = [Ingredient]()
    for ingredient in ingredients {
      if ingredient.type == .alcohol {
        alcohol.append(ingredient)
      }
    }
    return alcohol
  }
  
  func getNonAlcoholIngredients()->[Ingredient] {
    var nonAlcohol:[Ingredient]! = [Ingredient]()
    for ingredient in ingredients {
      if ingredient.type == .nonAlcohol {
        nonAlcohol.append(ingredient)
      }
    }
    return nonAlcohol
  }
  
  func getOtherIngredients()->[Ingredient] {
    var other:[Ingredient]! = [Ingredient]()
    for ingredient in ingredients {
      if ingredient.type == .other {
        other.append(ingredient)
      }
    }
    return other
  }
  
  func hasSubstance(_ substance: Ingredient.Substance)->Bool {
    for ingr in self.ingredients {
      if ingr.substance == substance  {
        return true
      }
    }
    return false
  }
  
  func add(_ ingredient: Ingredient) {
    self.ingredients.append(ingredient)
    print(ingredient)
  }
  
}
