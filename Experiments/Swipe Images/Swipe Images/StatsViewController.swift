//
//  StatsViewController.swift
//  Swipe Images
//
//  Created by Kim Jasper Mui on 3/3/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // for result page
    var breedArray: [Breed] = [Breed]()
    var likeBreeds: [Int] = [Int]()
    var nextBreeds: [Int] = [Int]()
    
    var scrollView: UIScrollView! = nil
    
    // math constants
    let HALF: Int = 2
    let CORNER_RADIUS: Int = 10
    
    var topFilters: [String] = [String]()
    var likeFilters = [String: Int]()
    
    // offsets
    let TOP_OFFSET = 50
    let TOP_BAR_OFFSET = 150
    let BAR_OFFSET = 110
    let LABEL_OFFSET = 70 // up from bar
    let TITLE_FILTER_OFFSET = 120
    let FILTER_OFFSET = 50
    let TOP_BUTTON_OFFSET = 40
    let SCROLL_OFFSET = 80
    
    // the bar stats
    let BAR_SIZE: CGSize = CGSize(width: 330, height: 2)
    var firstBar: UIProgressView! = nil
    var secondBar: UIProgressView! = nil
    var thirdBar: UIProgressView! = nil
    
    // the bar labels
    let LABEL_SIZE: CGSize = CGSize(width: 330, height: 43)
    let TITLE_SIZE: CGSize = CGSize(width: 330, height: 70)
    let TITLE_FONT_SIZE: Int = 40
    let LABEL_FONT_SIZE: Int = 25
    let FONT = "Noteworthy"
    var firstLabel: UILabel! = nil
    var secondLabel: UILabel! = nil
    var thirdLabel: UILabel! = nil
    var titleLabel: UILabel! = nil
    var filterTitleLabel: UILabel! = nil
    let LABEL_COLOR: UIColor = UIColor(red: 253.0/255.0, green: 127.0/255.0, blue: 124.0/255.0, alpha: 0.9)
    let TITLE_COLOR: UIColor = UIColor(red: 122.0/255.0, green: 215.0/255.0, blue: 253.0/255.0, alpha: 0.9)
    
    // the buttons
    var currentButton: UIButton! = nil
    var buttonOrigin: CGPoint! = nil
    let BUTTON_SIZE: CGSize = CGSize(width: 270, height: 40)
    let NEXT_BUTTON_SIZE: CGSize = CGSize(width: 150, height: 80)
    let NEXT_BUTTON_FONT_SIZE: Int = 40
    let BUTTON_FONT_SIZE: Int = 20
    var nextButton: UIButton! = nil
    let BUTTON_COLOR: UIColor = UIColor(red: 111.0/255.0, green: 135.0/255.0, blue: 143.0/255.0, alpha: 0.9)
    
    // the user
    // let user: USER! = nil
    
    // function to set up the common specs of bars
    func setUpStatsBar(myValue: Int, myBar: UIProgressView) {
        
        myBar.progress = Float(Double(myValue) / 10.0)
        myBar.transform = myBar.transform.scaledBy(x: 1, y: 20)
        myBar.tintColor = UIColor.white
        myBar.trackTintColor = UIColor.white.withAlphaComponent(0.4)
        scrollView.addSubview(myBar)
    }
    
    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
    
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        scrollView.addSubview(myLabel)
    }
    
    // function to set up the common specs of buttons
    func setUpButtons(myLabel: String, myFontSize: Int, myButton: UIButton) {
        
        myButton.setTitle(myLabel, for: UIControlState.normal)
        myButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        myButton.titleLabel?.font = UIFont(name: FONT, size: CGFloat(myFontSize))
        myButton.backgroundColor = BUTTON_COLOR
        myButton.isUserInteractionEnabled = true
        myButton.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        scrollView.addSubview(myButton)
    }
    
    // filters are added, implement to remove?
    func filterPressed(sender: UIButton!) {
        
        let buttonLabel: String = sender.titleLabel!.text!
        
        print("store \(buttonLabel)")
        
        sender.isUserInteractionEnabled = false
        sender.backgroundColor = UIColor.gray
        
        // user.addFavoriteFilter(\buttonLabel)
    }
    
    func nextPressed(sender: UIButton!) {
        
        print("switch to result page")
        
        // pass data to result page
        let resultVC: ResultViewController = ResultViewController()
        resultVC.breedArray = breedArray
        resultVC.likeBreeds = likeBreeds
        resultVC.nextBreeds = nextBreeds
        
        self.navigationController?.pushViewController(resultVC, animated: true)
        self.present(resultVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize user here
        // user = USER(  )
        
        // set up the scroll view
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge.jpg")!)
        self.view.addSubview(scrollView)
        
        // the origin of things
        let TITLE_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(TITLE_SIZE.width) / HALF, y: TOP_OFFSET)
        let FIRST_BAR_ORIGIN = CGPoint(x: Int(SCREEN_SIZE.width) / HALF - Int(BAR_SIZE.width) / HALF, y: Int(TITLE_ORIGIN.y) + TOP_BAR_OFFSET)
        let FIRST_LABEL_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: FIRST_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let SECOND_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: FIRST_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let SECOND_LABEL_ORIGIN = CGPoint(x: SECOND_BAR_ORIGIN.x, y: SECOND_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let THIRD_BAR_ORIGIN = CGPoint(x: FIRST_BAR_ORIGIN.x, y: SECOND_BAR_ORIGIN.y + CGFloat(BAR_OFFSET))
        let THIRD_LABEL_ORIGIN = CGPoint(x: THIRD_BAR_ORIGIN.x, y: THIRD_BAR_ORIGIN.y - CGFloat(LABEL_OFFSET))
        let FILTER_LABEL_ORIGIN = CGPoint(x: THIRD_LABEL_ORIGIN.x + BAR_SIZE.width / CGFloat(HALF) - TITLE_SIZE.width / CGFloat(HALF), y: THIRD_LABEL_ORIGIN.y + CGFloat(TITLE_FILTER_OFFSET))
        
        // set up the title
        titleLabel = UILabel(frame: CGRect(origin: TITLE_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Most Popular Filters", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: titleLabel, myColor: TITLE_COLOR)
        
        // set up the first bar
        firstBar = UIProgressView(frame: CGRect(origin: FIRST_BAR_ORIGIN, size: BAR_SIZE))
        setUpStatsBar(myValue: likeFilters[topFilters[0]]!, myBar: firstBar)
        
        // set up the first label
        firstLabel = UILabel(frame: CGRect(origin: FIRST_LABEL_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: topFilters[0], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: firstLabel, myColor: LABEL_COLOR)

        // set up the second bar
        secondBar = UIProgressView(frame: CGRect(origin: SECOND_BAR_ORIGIN, size: BAR_SIZE))
        setUpStatsBar(myValue: likeFilters[topFilters[1]]!, myBar: secondBar)
        
        // set up the second label
        secondLabel = UILabel(frame: CGRect(origin: SECOND_LABEL_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: topFilters[1], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: secondLabel, myColor: LABEL_COLOR)
        
        // set up the third bar
        thirdBar = UIProgressView(frame: CGRect(origin: THIRD_BAR_ORIGIN, size: BAR_SIZE))
        setUpStatsBar(myValue: likeFilters[topFilters[2]]!, myBar: thirdBar)
        
        // set up the third label
        thirdLabel = UILabel(frame: CGRect(origin: THIRD_LABEL_ORIGIN, size: LABEL_SIZE))
        setUpLabel(myText: topFilters[2], myFont: FONT, myFontSize: LABEL_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: thirdLabel, myColor: LABEL_COLOR)
        
        // set up the filter title label
        filterTitleLabel = UILabel(frame: CGRect(origin: FILTER_LABEL_ORIGIN, size: TITLE_SIZE))
        setUpLabel(myText: "Click to Add Filters", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: filterTitleLabel, myColor: TITLE_COLOR)
        
        // dummy current button reference, set its position
        currentButton = UIButton(frame: CGRect(origin: CGPoint(x: filterTitleLabel.center.x - BUTTON_SIZE.width / CGFloat(HALF), y: filterTitleLabel.frame.origin.y + CGFloat(TOP_BUTTON_OFFSET)), size: CGSize(width: 0, height: 0)))
        
        // iterate through all filters to get all labels
        for keyAndValuePair in likeFilters {
            
            // add button
            buttonOrigin = CGPoint(x: currentButton.frame.origin.x, y: currentButton.frame.origin.y + CGFloat(FILTER_OFFSET))
            currentButton = UIButton(frame: CGRect(origin: buttonOrigin, size: BUTTON_SIZE))
            setUpButtons(myLabel: keyAndValuePair.key, myFontSize: BUTTON_FONT_SIZE, myButton: currentButton)
            currentButton.addTarget(self, action: #selector(self.filterPressed(sender:)), for: UIControlEvents.touchDown)
        }
        
        // the next page button
        let NEXT_ORIGIN: CGPoint = CGPoint(x: firstBar.frame.origin.x + BAR_SIZE.width - NEXT_BUTTON_SIZE.width, y: currentButton.center.y + CGFloat(FILTER_OFFSET))
        nextButton = UIButton(frame: CGRect(origin: NEXT_ORIGIN, size: NEXT_BUTTON_SIZE))
        setUpButtons(myLabel: "Next", myFontSize: NEXT_BUTTON_FONT_SIZE, myButton: nextButton)
        nextButton.addTarget(self, action: #selector(self.nextPressed(sender:)), for: UIControlEvents.touchDown)
        
        // adjust the scroll view size
        scrollView.contentSize.height = nextButton.center.y + CGFloat(SCROLL_OFFSET)
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

}
