//
//  SettingsViewController.swift
//  CockYourTail
//
//  Created by Benjamin Völker on 30/12/2016.
//  Copyright © 2016 Benjamin Völker. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  
  @IBOutlet weak var ipAddressTextField: UITextField!
  @IBOutlet weak var scrollView: UIScrollView!
  
  var stackView : UIStackView!
  
  var bottleSegmentData: [String] = [String]()
  var juiceSegmentData: [String] = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ipAddressTextField.text = Settings.sharedInstance.host
    
    
    setup()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize = CGSize(width: stackView.frame.size.width, height: stackView.frame.size.height)
    print("A StackView: W:  \(stackView.frame.size.width)  H: \(stackView.frame.size.height)")
    print("A ScrollView: W:  \(scrollView.frame.size.width)  H: \(scrollView.frame.size.height)")
  }
  
  
  @IBAction func donePressed(_ sender: Any) {
    self.dismiss(animated: true, completion:nil)
  }
  
  
  @IBAction func ipAddressChanged(_ sender: Any) {
    Settings.sharedInstance.host = ipAddressTextField.text!
    Settings.sharedInstance.store()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
    formattedString.append(NSMutableAttributedString(string:"Bottles:", attributes:attrsBold))
    alcoholLabel.attributedText = formattedString
    stackView.addArrangedSubview(alcoholLabel)
    
    for index in 0...5  {
      stackView.addArrangedSubview(setupHorizontalStackView(bottle: true, number:index))
    }
    
    //Text Label
    let nonAlcoholLabel = UILabel()
    nonAlcoholLabel.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
    nonAlcoholLabel.textAlignment = .left
    formattedString = NSMutableAttributedString()
    formattedString.append(NSMutableAttributedString(string:"Juice:", attributes:attrsBold))
    nonAlcoholLabel.attributedText = formattedString
    stackView.addArrangedSubview(nonAlcoholLabel)
    
    for index in 0...5  {
      stackView.addArrangedSubview(setupHorizontalStackView(bottle: false, number:index))
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
  
  func setupHorizontalStackView(bottle: Bool, number: Int)->UIStackView {
    let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 20))
    textLabel.text  = "\(number + 1):"
    textLabel.textAlignment = .left
    textLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    var items = Settings.sharedInstance.availableBottle
    if bottle == false {
      items = Settings.sharedInstance.availableJuice
    }
    let segment = UISegmentedControl(items: items)
    
    var substance = Settings.sharedInstance.bottle[number]
    var index = Settings.sharedInstance.availableBottle.index(of: substance)
    if bottle == false {
      substance = Settings.sharedInstance.juice[number]
      index = Settings.sharedInstance.availableJuice.index(of: substance)
    }
    
    print("index of bottle: \(number): \(index)")
    segment.selectedSegmentIndex = index!
    segment.addTarget(self, action: #selector(segmentPressed), for: .valueChanged)
    segment.tag = number
    if bottle == false {
      segment.tag += Settings.sharedInstance.availableBottle.count - 1
    }
    
    let hstackView   = UIStackView()
    hstackView.axis  = UILayoutConstraintAxis.horizontal
    hstackView.distribution  = UIStackViewDistribution.fill
    hstackView.alignment = UIStackViewAlignment.center
    hstackView.spacing   = 8.0
    hstackView.translatesAutoresizingMaskIntoConstraints = false;
    hstackView.widthAnchor.constraint(equalToConstant: scrollView.frame.size.width).isActive = true
    //hstackView.semanticContentAttribute = .forceRightToLeft
    
    hstackView.frame.size.height = 30
    hstackView.addArrangedSubview(textLabel)
    hstackView.addArrangedSubview(segment)
    
    return hstackView
  }

  func segmentPressed(sender: UISegmentedControl) {
    print("Pressed: \(Int(sender.tag))")
    
    var index = Int(sender.tag)
    var bottle = true
    if sender.tag >= (Settings.sharedInstance.availableBottle.count - 1) {
      bottle = false
      index -= (Settings.sharedInstance.availableBottle.count - 1)
    }
    print("Index: \(index)")
    
    if bottle {
      Settings.sharedInstance.bottle[index] = Settings.sharedInstance.availableBottle[sender.selectedSegmentIndex]
      print("Pressed: \(Settings.sharedInstance.bottle)")
    } else {
      Settings.sharedInstance.juice[index] = Settings.sharedInstance.availableJuice[sender.selectedSegmentIndex]
      print("Pressed: \(Settings.sharedInstance.juice)")
    }
    
    Settings.sharedInstance.store()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  // The number of columns of data

  
  
}
