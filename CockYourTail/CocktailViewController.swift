//
//  CocktailViewController.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 30/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class CocktailViewController: UIViewController {

  
  @IBOutlet weak var inhaltTextView: UITextView!
  @IBOutlet weak var cocktailView: UIView!
  @IBOutlet weak var cocktailImage: UIImageView!
  
  var cocktail:Cocktail = Cocktail()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        showCocktail()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  
  
  
  func showCocktail() {
    var inhaltAlcohol = ""
    var headAlcohol = ""
    var inhaltNonAlcohol = ""
    var headNonAlcohol = ""
    var inhaltOther = ""
    var headOther = ""
    
    if cocktail.containsAlcohol() {
      headAlcohol += "Alcohol:\n"
      for alcohol in cocktail.getAlcoholIngredients() {
        inhaltAlcohol += alcohol.description + "\n"
      }
      headNonAlcohol += "\n"
      headOther = "\n"
    }
    
    if cocktail.containsNonAlcohol() {
      headNonAlcohol += "Non alcohol:\n"
      for nonAlcohol in cocktail.getNonAlcoholIngredients() {
        inhaltNonAlcohol += nonAlcohol.description + "\n"
      }
      headOther = "\n"
    }
    
    if cocktail.containsOther() {
      headOther += "Others:\n"
      for others in cocktail.getOtherIngredients() {
        inhaltOther += others.description + "\n"
      }
    }
    
    let attrsBold = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)]
    let attrsNormal = [NSFontAttributeName : UIFont.systemFont(ofSize: 14)]
    
    let formattedString = NSMutableAttributedString()
    formattedString.append(NSMutableAttributedString(string:headAlcohol, attributes:attrsBold))
    formattedString.append(NSMutableAttributedString(string:inhaltAlcohol, attributes:attrsNormal))
    
    formattedString.append(NSMutableAttributedString(string:headNonAlcohol, attributes:attrsBold))
    formattedString.append(NSMutableAttributedString(string:inhaltNonAlcohol, attributes:attrsNormal))
    
    formattedString.append(NSMutableAttributedString(string:headOther, attributes:attrsBold))
    formattedString.append(NSMutableAttributedString(string:inhaltOther, attributes:attrsNormal))
    
    inhaltTextView.attributedText = formattedString
    
    showCocktailGlass()
  }
  
  
  func showCocktailGlass() {
    
    for view in cocktailView.subviews {
      view.removeFromSuperview()
    }
    
    var glassRect = cocktailView.frame
    glassRect.origin.x = 0
    glassRect.origin.y = -30
    
    let pic = UIImageView.init(image: cocktail.image)
    
    pic.contentMode = .scaleAspectFill;
    pic.frame = glassRect
    cocktailView.addSubview(pic)
  }
  
  
  
  
  /*
   func showCocktailGlass(cocktail: Cocktail) {
   
   // Reset start position
   glassRect = cocktailView.frame
   glassHeight = CGFloat(glassRect.height) - 2.0/10.0 * glassRect.height
   clHeight = glassHeight/maxCl
   yPos = glassRect.height - ((glassRect.height - glassHeight)/2.0)
   
   for view in cocktailView.subviews {
   view.removeFromSuperview()
   }
   
   cocktailView.addSubview(getClView(color: cocktail.ginColor, amount: cocktail.clGin))
   cocktailView.addSubview(getClView(color: cocktail.vodkaColor, amount: cocktail.clVodka))
   cocktailView.addSubview(getClView(color: cocktail.rumColor, amount: cocktail.clRum))
   cocktailView.addSubview(getClView(color: cocktail.tequilaColor, amount: cocktail.clTequila))
   cocktailView.addSubview(getClView(color: cocktail.peachColor, amount: cocktail.clPeach))
   cocktailView.addSubview(getClView(color: cocktail.grenadineColor, amount: cocktail.clGrenadine))
   
   cocktailView.addSubview(getClView(color: cocktail.OSaftColor, amount: cocktail.clOSaft))
   cocktailView.addSubview(getClView(color: cocktail.ColaColor, amount: cocktail.clCola))
   cocktailView.addSubview(getClView(color: cocktail.SodaColor, amount: cocktail.clSoda))
   cocktailView.addSubview(getClView(color: cocktail.TonicColor, amount: cocktail.clTonic))
   cocktailView.addSubview(getClView(color: cocktail.CranberryColor, amount: cocktail.clCranberry))
   cocktailView.addSubview(getClView(color: cocktail.LimeColor, amount: cocktail.clLime))
   
   var glassRect2 = cocktailView.frame
   glassRect2.origin.x = 0
   glassRect2.origin.y = 0
   
   if (cocktail.diceIce) {
   let cubes = UIImageView.init(image: UIImage.init(named: "cubes"))
   cubes.frame = glassRect2
   cocktailView.addSubview(cubes)
   }
   if (cocktail.crushedIce) {
   let crushed = UIImageView.init(image: UIImage.init(named: "crushed"))
   crushed.frame = glassRect2
   cocktailView.addSubview(crushed)
   }
   
   // Draw glass on top
   let emptyGlass = UIImageView.init(image: UIImage.init(named: "glassEmpty2"))
   emptyGlass.frame = glassRect2
   cocktailView.addSubview(emptyGlass)
   //cocktailImage.image = UIImage(named: "glassEmpty")
   }
   
   
   func getClView(color: UIColor, amount: Int)->UIView {
   yPos -= CGFloat(amount)*clHeight
   let rect = CGRect.init(x: 0, y: yPos, width: glassRect.width, height: CGFloat(amount)*clHeight)
   let view = UIView.init(frame: rect)
   view.backgroundColor = color
   return view
   }
   */

}
