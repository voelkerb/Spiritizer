//
//  MixViewController.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 30/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class MixViewController: UIViewController {
  
  var cocktail:Cocktail = Cocktail()
  var yPos:CGFloat = 0
  var glassRect:CGRect = CGRect()
  let maxCl:CGFloat = 18.0
  var glassHeight:CGFloat = 0.0
  var clHeight:CGFloat = 0.0

  @IBOutlet weak var cocktailImageView: UIView!
  var stackView : UIStackView!
  
  @IBOutlet weak var scrollView: UIScrollView!
  var labels:[UILabel] = [UILabel]()
  
  override func viewDidLoad() {
    reinit()
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    showCocktailGlass()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize = CGSize(width: stackView.frame.size.width, height: stackView.frame.size.height)
    print("A StackView: W:  \(stackView.frame.size.width)  H: \(stackView.frame.size.height)")
    print("A ScrollView: W:  \(scrollView.frame.size.width)  H: \(scrollView.frame.size.height)")
  }
  
  func reinit() {
    for view in self.scrollView.subviews {
      view.removeFromSuperview()
    }
    
    cocktail = Cocktail()
    cocktail.add(Ingredient.init(.gin))
    cocktail.add(Ingredient.init(.rum))
    cocktail.add(Ingredient.init(.vodka))
    cocktail.add(Ingredient.init(.peach))
    cocktail.add(Ingredient.init(.tequila))
    cocktail.add(Ingredient.init(.grenadine))
    cocktail.add(Ingredient.init(.cola))
    cocktail.add(Ingredient.init(.orangeJuice))
    cocktail.add(Ingredient.init(.soda))
    cocktail.add(Ingredient.init(.tonic))
    cocktail.add(Ingredient.init(.cranberryJuice))
    cocktail.add(Ingredient.init(.limeJuice))
    cocktail.add(Ingredient.init(.sugar))
    labels.removeAll()
    setup()
    showCocktailGlass()
  }
  
  func setup() {
    //Stack View
    stackView = UIStackView()
    stackView.axis  = UILayoutConstraintAxis.vertical
    stackView.distribution  = UIStackViewDistribution.equalSpacing
    stackView.alignment = UIStackViewAlignment.top
    stackView.spacing   = 16.0
    
    let attrsBold = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)]
    var formattedString = NSMutableAttributedString()
    //Text Label
    let alcoholLabel = UILabel()
    alcoholLabel.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
    alcoholLabel.textAlignment = .left
    formattedString.append(NSMutableAttributedString(string:"Alcohol", attributes:attrsBold))
    alcoholLabel.attributedText = formattedString
    stackView.addArrangedSubview(alcoholLabel)
    
    for ingredient in cocktail.getAlcoholIngredients() {
      stackView.addArrangedSubview(setupHorizontalStackView(ingredient: ingredient.description))
    }
    
    //Text Label
    let nonAlcoholLabel = UILabel()
    nonAlcoholLabel.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
    nonAlcoholLabel.textAlignment = .left
    formattedString = NSMutableAttributedString()
    formattedString.append(NSMutableAttributedString(string:"Non Alcohol", attributes:attrsBold))
    nonAlcoholLabel.attributedText = formattedString
    stackView.addArrangedSubview(nonAlcoholLabel)
    
    for ingredient in cocktail.getNonAlcoholIngredients() {
      stackView.addArrangedSubview(setupHorizontalStackView(ingredient: ingredient.description))
    }
    
    //Text Label
    let othersLabel = UILabel()
    othersLabel.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
    othersLabel.textAlignment = .left
    formattedString = NSMutableAttributedString()
    formattedString.append(NSMutableAttributedString(string:"Others", attributes:attrsBold))
    othersLabel.attributedText = formattedString
    stackView.addArrangedSubview(othersLabel)
    
    for ingredient in cocktail.getOtherIngredients() {
      stackView.addArrangedSubview(setupHorizontalStackView(ingredient: ingredient.description))
    }
    
    self.scrollView.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    
    //Constraints
    NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self.scrollView, attribute: .left, multiplier: 1, constant: 0).isActive = true
    
    scrollView.isScrollEnabled = true
    scrollView.showsVerticalScrollIndicator = true
  }
  
  
  func setupHorizontalStackView(ingredient: String)->UIStackView {
    let textLabel = UILabel()
    textLabel.text  = ingredient
    textLabel.textAlignment = .left
    textLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    labels.append(textLabel)
    
    let stepper = UIStepper()
    stepper.stepValue = 1.0
    stepper.minimumValue = 0.0
    stepper.maximumValue = 15.0
    stepper.value = stepper.minimumValue
    stepper.tag = labels.count-1
    stepper.addTarget(self, action: #selector(stepperValueDidChange(_:)), for: .valueChanged)
    //stepper.transform = CGAffineTransform(scaleX: 0.9, y: 0.9);
    
    let hstackView   = UIStackView()
    hstackView.axis  = UILayoutConstraintAxis.horizontal
    hstackView.distribution  = UIStackViewDistribution.fill
    hstackView.alignment = UIStackViewAlignment.center
    hstackView.spacing   = 8.0
    hstackView.translatesAutoresizingMaskIntoConstraints = false;
    hstackView.widthAnchor.constraint(equalToConstant: 240.0).isActive = true
    //hstackView.semanticContentAttribute = .forceRightToLeft
    
    hstackView.addArrangedSubview(stepper)
    hstackView.addArrangedSubview(textLabel)
    
    return hstackView
  }

  
  
  
  func showCocktailGlass() {
    
    // Reset start position
    glassRect = cocktailImageView.frame
    glassHeight = CGFloat(glassRect.height) - 2.0/10.0 * glassRect.height
    clHeight = glassHeight/maxCl
    yPos = glassRect.height - ((glassRect.height - glassHeight)/2.0)
    
    for view in cocktailImageView.subviews {
      view.removeFromSuperview()
    }
    
    for ingredient in cocktail.ingredients {
      if ingredient.amount > 0 {
        cocktailImageView.addSubview(getClView(color: ingredient.color(), amount: ingredient.amount))
      }
    }
    
    var glassRect2 = cocktailImageView.frame
    glassRect2.origin.x = 0
    glassRect2.origin.y = 0
    
    
    let cubes = UIImageView.init(image: UIImage.init(named: "cubes"))
    cubes.frame = glassRect2
    cocktailImageView.addSubview(cubes)
    /*
    if (cocktail.hasSubstance(.diceIce)) {
      let cubes = UIImageView.init(image: UIImage.init(named: "cubes"))
      cubes.frame = glassRect2
      cocktailImageView.addSubview(cubes)
    }
    if (cocktail.hasSubstance(.crushedIce)) {
      let crushed = UIImageView.init(image: UIImage.init(named: "crushed"))
      crushed.frame = glassRect2
      cocktailImageView.addSubview(crushed)
    }*/
    
    // Draw glass on top
    let emptyGlass = UIImageView.init(image: UIImage.init(named: "glassEmpty2"))
    emptyGlass.frame = glassRect2
    cocktailImageView.addSubview(emptyGlass)
    //cocktailImage.image = UIImage(named: "glassEmpty")
  }
  
  
  func getClView(color: UIColor, amount: Int)->UIView {
    yPos -= CGFloat(amount)*clHeight
    let rect = CGRect.init(x: 0, y: yPos, width: glassRect.width, height: CGFloat(amount)*clHeight)
    let view = UIView.init(frame: rect)
    view.backgroundColor = color
    return view
  }
  
  
  
   @IBAction func stepperValueDidChange(_ sender: UIStepper) {
    
    print("Stepper: \(Int(sender.tag))")
    print("Value: \(Int(sender.value))")
    
    if sender.tag >= 0 && sender.tag < self.cocktail.ingredients.count {
      cocktail.ingredients[sender.tag].amount = Int(sender.value)
      labels[sender.tag].text = cocktail.ingredients[sender.tag].description
    }
    showCocktailGlass()
   }
  
}
