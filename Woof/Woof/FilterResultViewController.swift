//
//  FilterResultViewController.swift
//  Woof
//
//  Created by Meiyi He on 3/9/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import UIKit

class FilterResultViewController: UIViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource{
    
    let breedList = Functionalities.breedList
    
    var breedSelected: Breed! = nil
    
    var filterDogs = [Breed]()
    //var hair:Int? //default 0. short 1, long 2
    var size:Int? //default 0. small 1, medium 2, large 3
    var group:Int? //default 0. Herding 1; Hound 2; Non Sporting 7; Sporting 4; Terrier 5; Toy 6; Working 3
    var train:Int? //default 0. easy 1; aveg 2; moderately easy 3
    var bark:Int? //default 0. frequent 1; occasional 2; rare 3
    
    var groom:Int? //default 0; "High" 1; "Moderate" 2; "Low" 3
    var shed:Int?  //default 0; minimal 1; moderate 2; constant 3; seasonal 4
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    
    // data
    var breedArray = Functionalities.breedList
    //var breeds: [Int] = [Int]()
    //var breeds = ["1","2","3"]
    
    // origins
    var announce_origin = CGPoint(x: 10, y: 80)
    var result_origin = CGPoint(x: 10, y: 140)
    
    // the radius of the corner
    let CORNER_RADIUS = 10
    
    // the labels
    let TITLE_SIZE: CGSize = CGSize(width: 353, height: 40)
    let TITLE_FONT_SIZE: Int = 4
    let FONT = "Rubik_Medium"
    var announce_label: UILabel! = nil
    
    //colors
    let pale_green: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 0.5)
    let green_Full: UIColor = UIColor(red: 165/255, green: 195/255, blue: 187/255, alpha: 1)
    let pink: UIColor = UIColor(red: 253/255, green: 127/255, blue: 124/255, alpha: 0.8)
    let white_half: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
    
    
    // the tables
    let TABLE_SIZE: CGSize = CGSize(width: 353, height: 450)
    let TABLE_COLOR: UIColor = UIColor.white
    let CELL_HEIGHT: Int! = 50
    var table: UITableView! = nil
    
    let HALF = CGFloat(2)
    
    // function to set up the common specs of labels
    func setUpLabel(myText: String, myFont: String, myFontSize: Int, myAlignment: NSTextAlignment, myLabel: UILabel, myColor: UIColor) {
        
        myLabel.text = myText
        myLabel.font = UIFont(name: myFont, size: CGFloat(myFontSize))
        myLabel.textAlignment = myAlignment
        myLabel.backgroundColor = myColor
        myLabel.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myLabel.clipsToBounds = true
        self.view.addSubview(myLabel)
    }
    
    func setUpTable(myColor: UIColor, myTable: UITableView) {
        
        myTable.backgroundColor = myColor
        myTable.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        myTable.rowHeight = CGFloat(CELL_HEIGHT)
        // myTable.register(BreedTableViewCell.self, forCellReuseIdentifier: "BreedTableViewCell")
        self.view.addSubview(myTable)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let row: Int = indexPath.row
        
        //var currentBreed: Breed! = nil
        
        //currentBreed = filterDogs[indexPath.row]
        //[breeds[indexPath.row]]
        let cell = UITableViewCell()
        cell.textLabel?.text  = filterDogs[indexPath.row].getBreedName()
        //"lexi"
        
        // create table cell
        //        let myCell = tableView.dequeueReusableCell(withIdentifier: "BreedTableViewCell", for: indexPath) as! BreedTableViewCell
        //
        //        myCell.labelString = currentBreed.getBreedName()
        //        myCell.descriptionString = "Elohim, Essaim... \nElohim, Essaim... \nWare wa motome uttaetari"
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("filter has \(filterDogs.count)")
        return filterDogs.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentString = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        for myBreed in breedList {
            
            if myBreed.getBreedName() == currentString {
                
                breedSelected = myBreed
                self.performSegue(withIdentifier: "ToDetailViewSegue3", sender: tableView)
            }
        }
    }
    
    // segue to switch to detail page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Prepare for Detail View Segue")
        
        if segue.identifier == "ToDetailViewSegue3" {
            
            let detailVC = segue.destination as! DetailViewController
            
            detailVC.detailDog = breedSelected
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("return sectin !!")
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = "Filter Result"
        
        //self.view.addSubview(backButton)
        
        /**
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:64)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "Filter Result"
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)*/
        
        print("size is\(size)")
        print("train is\(train)")
        
        self.title = "Filter Search"
        self.tabBarItem.title = "Filter Search"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundHomeLarge-shade.jpg")!)
        
        announce_origin.x = (self.view.frame.width - TITLE_SIZE.width) / HALF
        result_origin.x = announce_origin.x
        
        // Do any additional setup after loading the view.
        
        announce_label = UILabel(frame: CGRect(origin: announce_origin, size: TITLE_SIZE))
        if Functionalities.myUser == nil {
            setUpLabel(myText: "FILTER RESULT, LOGIN TO SAVE TAG", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: announce_label, myColor: white_half)
        } else {
            setUpLabel(myText: "ALL TAGS SAVED    Σ(っ°Д°)っ", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: announce_label, myColor: white_half)
            
        }
        
        
        table = UITableView(frame: CGRect(origin: result_origin, size: TABLE_SIZE))
        setUpTable(myColor: TABLE_COLOR, myTable: table)
        let a = search()
        if a == -1{
            setUpLabel(myText: "More than 1 tag each category  !!!∑(ﾟДﾟノ)ノ", myFont: FONT, myFontSize: TITLE_FONT_SIZE, myAlignment: NSTextAlignment.center, myLabel: announce_label, myColor: white_half)
            //table = nil
            return
        }
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    func searchBy (from: [Breed], type: String, filter: String) -> [Breed]{
        var toRe = [Breed]()
        for curr in from{
            if type == "train" {
                if curr.getTrainability().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
                
            else if type == "shed" {
                if curr.getShedding().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
                
            else if type == "bark" {
                if curr.getBarkingLevel().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
                
            else if type == "groom" {
                if curr.getGrooming().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
            else if type == "size" {
                if curr.getSize().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
            else if type == "group" {
                print("group: \(curr.getGroup())")
                if curr.getGroup().lowercased().contains(filter){
                    toRe.append(curr)
                }
            }
        }
        return toRe
    }
    
    func search () -> Int {
        let count = filterDogs.count
        let COUNT = breedArray.count
        filterDogs = breedArray
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        //search by size
        if size == 100 {
            return -1 ;
        }
        
        if size == 1{/*
             filterDogs = breedArray.filter({( dog : Breed) -> Bool in
             return dog.size == "Small"
             })*/
            filterDogs = searchBy(from:filterDogs, type: "size", filter: "small")
            
        }else if size == 2{/*
             filterDogs = breedArray.filter({( dog : Breed) -> Bool in
             return dog.size == "Medium"
             })*/
            filterDogs = searchBy(from:filterDogs, type: "size", filter: "medium")
            
        }else if size == 3{/*
             filterDogs = breedArray.filter({( dog : Breed) -> Bool in
             return dog.size == "Large"
             })*/
            filterDogs = searchBy(from:filterDogs, type: "size", filter: "large")
            
        }
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        if train == 100 {
            return -1 ;
        }
        if train == 3{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.trainability.lowercased().contains("moderate")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "train", filter: "moderate")
            
        }else if train == 2{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.trainability.lowercased().contains("difficult")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "train", filter: "difficult")
            
        }else if train == 1{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.trainability.lowercased().contains("easy")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "train", filter: "easy")
            
        }
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        if bark == 100 {
            return -1 ;
        }
        if bark == 1{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.barkingLevel.lowercased().contains("frequent")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "bark", filter: "frequent")
            
        }else if bark == 2{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.barkingLevel.lowercased().contains("occasional")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "bark", filter: "occasional")
            
        }else if bark == 3{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.barkingLevel.lowercased().contains("rare")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "bark", filter: "rare")
            
        }
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        if groom == 100 {
            return -1 ;
        }
        if groom == 1{
            /*print("high find is ")
             let a = breedArray[1]
             print (a.grooming.lowercased().contains("high"))
             
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.grooming.lowercased().contains("high")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "groom", filter: "high")
        }else if groom == 2{
            /*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.grooming.lowercased().contains("moderate")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "groom", filter: "moderate")
            
        }else if groom == 3{
            /*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.grooming.lowercased().contains("low")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "groom", filter: "low")
            
        }
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        if shed == 100 {
            return -1 ;
        }
        if shed == 1{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.shedding.lowercased().contains("minimal")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "shed", filter: "minimal")
            
        }else if shed == 2{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.shedding.lowercased().contains("moderate")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "shed", filter: "moderate")
            
        }else if shed == 3{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.shedding.lowercased().contains("constant")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "shed", filter: "constant")
            
        }else if shed == 4{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.shedding.lowercased().contains("seasonal")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "shed", filter: "seasonal")
            
        }
        print("filter has \(count) dogs")
        print("dogs has \(COUNT) dogs")
        if group == 100 {
            return -1 ;
        }
        if group == 1{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("herding")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "herding")
            
        }else if group == 2{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("hound")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "hound")
            
        }else if group == 3{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("working")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "working")
            
        }else if group == 4{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("sporting")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "sporting")
            
        }else if group == 5{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("terrier")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "terrier")
            
        }else if group == 6{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("toy")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "toy")
            
        }else if group == 7{/*
             filterDogs = filterDogs.filter({( dog : Breed) -> Bool in
             return dog.group.lowercased().contains("non sporting")
             })*/
            filterDogs = searchBy(from:filterDogs, type: "group", filter: "non sporting")
            
        }
        
        //        var group=0 //default 0. Herding 1; Hound 2; Non Sporting 3; Sporting 4; Terrier 5; Toy 6; Working 7
        
        return 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func goBack(){
        print("call goBack function")
        dismiss(animated: true, completion: nil)
    }
    
}

