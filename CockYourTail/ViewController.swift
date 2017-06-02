//
//  ViewController.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 12/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkManagerDelegate {

  let TEST_ALL = false
  
  @IBOutlet var cocktailView: UIView!
  var cocktailViewController: CocktailViewController?
  @IBOutlet var mixView: UIView!
  var mixViewController: MixViewController?
  
  
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var makeButton: UIButton!
  @IBOutlet weak var settingsButton: UIButton!
  @IBOutlet weak var mixGinLabel: UILabel!
  @IBOutlet weak var mixTequilaLabel: UILabel!
  @IBOutlet weak var mixRumLabel: UILabel!
  @IBOutlet weak var mixVodkaLabel: UILabel!
  @IBOutlet weak var mixPeachLabel: UILabel!
  @IBOutlet weak var mixGrenadineLabel: UILabel!
  @IBOutlet weak var mixOsaftLabel: UILabel!
  @IBOutlet weak var mixColaLabel: UILabel!
  @IBOutlet weak var mixSodaLabel: UILabel!
  @IBOutlet weak var mixTonicLabel: UILabel!
  @IBOutlet weak var mixCranberryLabel: UILabel!
  @IBOutlet weak var mixLimeLabel: UILabel!
  @IBOutlet weak var mixSugarLabel: UILabel!
  @IBOutlet weak var mixGinStepper: UIStepper!
  @IBOutlet weak var mixTequilaStepper: UIStepper!
  @IBOutlet weak var mixRumStepper: UIStepper!
  @IBOutlet weak var mixPeachStepper: UIStepper!
  @IBOutlet weak var mixVodkaStepper: UIStepper!
  @IBOutlet weak var mixGrenadineStepper: UIStepper!
  @IBOutlet weak var mixOsaftStepper: UIStepper!
  @IBOutlet weak var mixSodaStepper: UIStepper!
  @IBOutlet weak var mixColaStepper: UIStepper!
  @IBOutlet weak var mixTonicStepper: UIStepper!
  @IBOutlet weak var mixLimeStepper: UIStepper!
  @IBOutlet weak var mixCranberryStepper: UIStepper!
  @IBOutlet weak var mixSugarStepper: UIStepper!
  
  var cocktails:[Cocktail]! = [Cocktail]()
  
  var yPos:CGFloat = 0
  var glassRect:CGRect = CGRect()
  let maxCl:CGFloat = 18.0
  var glassHeight:CGFloat = 0.0
  var clHeight:CGFloat = 0.0
  var currentCocktail:Cocktail = Cocktail()
  
  var connected:Bool = false
  var inited = false
  var showMix = true
  
  let network:NetworkManager = NetworkManager.sharedNetworkManager() as! NetworkManager
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cocktails.reserveCapacity(30)
    network.delegate = self
    
    if TEST_ALL == false {
      makeButton.isOpaque = true
      makeButton.isEnabled = false
    } else {
      connected = true
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    initCocktails()
    
  }
  
  override func viewDidLayoutSubviews() {
    if (!inited) {
      cocktailViewController?.cocktail = currentCocktail
      cocktailViewController?.showCocktail()
      inited = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "cocktailViewSegue" {
      cocktailViewController = segue.destination as? CocktailViewController
      cocktailViewController!.cocktail = currentCocktail
    } else if segue.identifier == "mixSegue" {
      // Reinit cocktail
      mixViewController = segue.destination as? MixViewController
      if mixViewController != nil {
        mixViewController!.cocktail = Cocktail()
      }
    }
  }
  
  
  func initCocktails() {
    // Mojito
    let mojito = Cocktail()
    mojito.name = "Mojito"
    mojito.image = UIImage(named: "Mojito")
    mojito.add(Ingredient.init(.rum, amount: 6))
    mojito.add(Ingredient.init(.soda, amount: 4))
    mojito.add(Ingredient.init(.limeJuice, amount: 3))
    mojito.add(Ingredient.init(.lime, amount: 2))
    mojito.add(Ingredient.init(.mint, amount: 5))
    mojito.add(Ingredient.init(.sugar, amount: 2))
    mojito.add(Ingredient.init(.crushedIce))
    
    let ginTonic = Cocktail()
    ginTonic.name = "Gin Tonic"
    ginTonic.image = UIImage(named: "GinTonic")
    ginTonic.add(Ingredient.init(.gin, amount: 5))
    ginTonic.add(Ingredient.init(.tonic, amount: 10))
    ginTonic.add(Ingredient.init(.lime, amount: 5))
    ginTonic.add(Ingredient.init(.diceIce))
    
    let cubaLibre = Cocktail()
    cubaLibre.name = "Cuba Libre"
    cubaLibre.image = UIImage(named: "CubaLibre")
    cubaLibre.add(Ingredient.init(.rum, amount: 5))
    cubaLibre.add(Ingredient.init(.cola, amount: 12))
    cubaLibre.add(Ingredient.init(.limeJuice, amount: 1))
    cubaLibre.add(Ingredient.init(.lime, amount: 1))
    cubaLibre.add(Ingredient.init(.diceIce))
    
    let caipirissima = Cocktail()
    caipirissima.name = "Caipirissima"
    caipirissima.image = UIImage(named: "Caipirissima")
    caipirissima.add(Ingredient.init(.rum, amount: 5))
    caipirissima.add(Ingredient.init(.lime, amount: 1))
    caipirissima.add(Ingredient.init(.limeJuice, amount: 4))
    caipirissima.add(Ingredient.init(.sugar, amount: 2))
    caipirissima.add(Ingredient.init(.crushedIce))
    
    let tequilaSunrise = Cocktail()
    tequilaSunrise.name = "Tequila Sunrise"
    tequilaSunrise.image = UIImage(named: "TequilaSunrise")
    tequilaSunrise.add(Ingredient.init(.tequila, amount: 4))
    tequilaSunrise.add(Ingredient.init(.orangeJuice, amount: 9))
    tequilaSunrise.add(Ingredient.init(.grenadine, amount: 2))
    tequilaSunrise.add(Ingredient.init(.crushedIce))
    
    let shortIslandIceTea = Cocktail()
    shortIslandIceTea.name = "Short Island Ice Tea"
    shortIslandIceTea.image = UIImage(named: "ShortIslandIceTea")
    shortIslandIceTea.add(Ingredient.init(.tequila, amount: 2))
    shortIslandIceTea.add(Ingredient.init(.vodka, amount: 2))
    shortIslandIceTea.add(Ingredient.init(.gin, amount: 2))
    shortIslandIceTea.add(Ingredient.init(.cola, amount: 1))
    shortIslandIceTea.add(Ingredient.init(.limeJuice, amount: 3))
    shortIslandIceTea.add(Ingredient.init(.diceIce))
    
    let sexOnTheBeach = Cocktail()
    sexOnTheBeach.name = "Sex on the Beach"
    sexOnTheBeach.image = UIImage(named: "SexOnTheBeach")
    sexOnTheBeach.add(Ingredient.init(.vodka, amount: 4))
    sexOnTheBeach.add(Ingredient.init(.peach, amount: 2))
    sexOnTheBeach.add(Ingredient.init(.cranberryJuice, amount: 4))
    sexOnTheBeach.add(Ingredient.init(.orangeJuice, amount: 4))
    sexOnTheBeach.add(Ingredient.init(.diceIce))
    
    let screwdriver = Cocktail()
    screwdriver.name = "Screwdriver"
    screwdriver.image = UIImage(named: "Screwdriver")
    screwdriver.add(Ingredient.init(.vodka, amount: 5))
    screwdriver.add(Ingredient.init(.orangeJuice, amount: 10))
    screwdriver.add(Ingredient.init(.diceIce))
    
    let plantersGepunche = Cocktail()
    plantersGepunche.name = "Planters Gepunche"
    plantersGepunche.image = UIImage(named: "PlantersGepunche")
    plantersGepunche.add(Ingredient.init(.rum, amount: 6))
    plantersGepunche.add(Ingredient.init(.lime, amount: 3))
    plantersGepunche.add(Ingredient.init(.orangeJuice, amount: 4))
    plantersGepunche.add(Ingredient.init(.grenadine, amount: 1))
    plantersGepunche.add(Ingredient.init(.sugar, amount: 1))
    plantersGepunche.add(Ingredient.init(.crushedIce))
    
    
    let mintTonic = Cocktail()
    mintTonic.name = "Mint Tonic"
    mintTonic.image = UIImage(named: "MintTonic")
    mintTonic.add(Ingredient.init(.limeJuice, amount: 4))
    mintTonic.add(Ingredient.init(.tonic, amount: 5))
    mintTonic.add(Ingredient.init(.soda, amount: 5))
    mintTonic.add(Ingredient.init(.sugar, amount: 2))
    mintTonic.add(Ingredient.init(.mint, amount: 4))
    mintTonic.add(Ingredient.init(.crushedIce))
    
    let fruitGepunche = Cocktail()
    fruitGepunche.name = "Punched Fruits"
    fruitGepunche.image = UIImage(named: "PunchedFruits")
    fruitGepunche.add(Ingredient.init(.limeJuice, amount: 2))
    fruitGepunche.add(Ingredient.init(.orangeJuice, amount: 8))
    fruitGepunche.add(Ingredient.init(.grenadine, amount: 2))
    fruitGepunche.add(Ingredient.init(.cranberryJuice, amount: 2))
    fruitGepunche.add(Ingredient.init(.diceIce))
    
    
    let grenadinePower = Cocktail()
    grenadinePower.name = "Grenadine Power"
    grenadinePower.image = UIImage(named: "GrenadinePower")
    grenadinePower.add(Ingredient.init(.soda, amount: 12))
    grenadinePower.add(Ingredient.init(.grenadine, amount: 5))
    grenadinePower.add(Ingredient.init(.diceIce))
    
    let joggingFlipper = Cocktail()
    joggingFlipper.name = "Jogging Flipper"
    joggingFlipper.image = UIImage(named: "JoggingFlipper")
    joggingFlipper.add(Ingredient.init(.orangeJuice, amount: 9))
    joggingFlipper.add(Ingredient.init(.limeJuice, amount: 3))
    joggingFlipper.add(Ingredient.init(.grenadine, amount: 3))
    joggingFlipper.add(Ingredient.init(.diceIce))
    
    let orangeFizz = Cocktail()
    orangeFizz.name = "Orange Fizz"
    orangeFizz.image = UIImage(named: "OrangeFizz")
    orangeFizz.add(Ingredient.init(.orangeJuice, amount: 6))
    orangeFizz.add(Ingredient.init(.cranberryJuice, amount: 3))
    orangeFizz.add(Ingredient.init(.limeJuice, amount: 2))
    orangeFizz.add(Ingredient.init(.tonic, amount: 6))
    orangeFizz.add(Ingredient.init(.diceIce))
    
    let refresher = Cocktail()
    refresher.name = "Refresher"
    refresher.image = UIImage(named: "Refresher")
    refresher.add(Ingredient.init(.orangeJuice, amount: 6))
    refresher.add(Ingredient.init(.grenadine, amount: 3))
    refresher.add(Ingredient.init(.soda, amount: 6))
    refresher.add(Ingredient.init(.diceIce))
    
    cocktails.reserveCapacity(30);
    cocktails.append(mojito)
    cocktails.append(ginTonic)
    cocktails.append(cubaLibre)
    cocktails.append(caipirissima)
    cocktails.append(tequilaSunrise)
    cocktails.append(shortIslandIceTea)
    cocktails.append(sexOnTheBeach)
    cocktails.append(screwdriver)
    cocktails.append(plantersGepunche)
    cocktails.append(mintTonic)
    cocktails.append(fruitGepunche)
    cocktails.append(grenadinePower)
    cocktails.append(joggingFlipper)
    cocktails.append(orangeFizz)
    cocktails.append(refresher)
    
  }
    
  @IBAction func settingsPressed(_ sender: AnyObject) {
    self.performSegue(withIdentifier: "settingsSegue", sender: self)
  }
  
  
  @IBAction func connect(_ sender: AnyObject) {
    let network:NetworkManager = NetworkManager.sharedNetworkManager() as! NetworkManager
    if (!connected) {
      network.connectToServer()
    } else {
      connected = false
      network.disconnectFromServer()
    }
  }
  
  
  @IBAction func spiritizeIt(_ sender: AnyObject) {
    if !connected {
      return
    }
    
    if showMix == true {
      currentCocktail = (mixViewController?.cocktail)!
    } else {
      currentCocktail = (cocktailViewController?.cocktail)!
    }
    
    var str = ""
    for ingredient in currentCocktail.ingredients {
      str += ingredient.getCommand()
      print(ingredient.getCommand())
    }
    str += Settings.commandPrefix + Settings.finishPrefix
    print(str)
    let network:NetworkManager = NetworkManager.sharedNetworkManager() as! NetworkManager
    network.send(str)
  }
  
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cocktails.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell") as! CustomTableViewCell
    let index = indexPath.row
    if index == 0 {
      cell.label.text = "Mix Your Own"
      cell.imageView?.image = UIImage(named: "mix")
    } else {
      let cocktail = cocktails[index - 1]
      cell.label.text = cocktail.name
      cell.imageView?.image = cocktail.image
      cell.isUserInteractionEnabled = true
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected: ", indexPath.row)
    if (indexPath.row > 0) {
      // Show cocktailview
      UIView.animate(withDuration: 0.5, animations: {
        self.mixView.alpha = 0
        self.cocktailView.alpha = 1
      })
      showMix = false
      currentCocktail = cocktails[indexPath.row - 1]
      cocktailViewController!.cocktail = currentCocktail
      cocktailViewController!.showCocktail()
    } else {
      showMix = true
      mixViewController?.reinit()
      // Show mix view
      UIView.animate(withDuration: 0.5, animations: {
        self.mixView.alpha = 1
        self.cocktailView.alpha = 0
      })
    }
  }

  
  public func connectionEstablished() {
    connected = true
    connectButton.setTitle("Diconnect", for: .normal)
    makeButton.isOpaque = false
    makeButton.isEnabled = true

  }
  
  public func connectionBroke() {
    connected = false
    connectButton.setTitle("Connect", for: .normal)
    makeButton.isOpaque = true
    makeButton.isEnabled = false
  }
  
  public func receivedString(_ string: String!) {
    let str = string!
    print("Received: ", str)
    
  }
  
}

