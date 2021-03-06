//
//  OwnedDogDetailViewController.swift
//  frontEndTest
//
//  Created by Meiyi He on 2/28/17.
//  Copyright © 2017 Meiyi He. All rights reserved.
//

import UIKit

class OwnedDogDetailViewController: UIViewController, UINavigationBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var name = ""
    var gender = ""
    var vaccinationdate = ""
    var birthdate = ""
    var discription = ""
    var breed = ""
    var age:Int = 0
    
    var ageData = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    var picker = UIPickerView()
    var picker2 = UIDatePicker()
    
    //Declare the texctfield in this view
    var dogNametextField = UITextField(frame: CGRect(20.0, 230, 330.0, 40.0))
    var dogGendertextField = UITextField(frame: CGRect(20.0, 275, 330.0, 40.0))
    var dogBirhDatetextField = UITextField(frame: CGRect(20.0, 320, 330.0, 40.0))
    var dogVaccinationDatetextField = UITextField(frame: CGRect(20.0, 365, 330.0, 40.0))
    var breedtextField = UITextField(frame: CGRect(20.0, 410, 330.0, 40.0))
    var agetextField = UITextField(frame: CGRect(20.0, 455, 330.0, 40.0))
    
    
    
    
    
    //Declare the button in this view
    let editProfButton:UIButton = UIButton(frame: CGRect(x: 250, y: 170, width: 50, height: 25))
    let saveProfButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
    
    //Declare nameLabel of the dog
    let nameLabel = UILabel(frame: CGRect(x: 20, y: 230, width: 330, height: 40))
    
    //Declare the genderLabel of the dog
    let genderLabel = UILabel(frame: CGRect(x: 20, y: 275, width: 330, height: 40))
    
    //Declare BirthDate Label
    let birthDateLabel = UILabel(frame: CGRect(x: 20, y: 320, width: 330, height: 40))
    
    //Declare Vaccination Date Label
    let vaccinationDateLabel = UILabel(frame: CGRect(x: 20, y: 365, width: 330, height: 40))
    
    
    //Declare the breed Label
    let breedLabel = UILabel(frame: CGRect(x: 20, y: 410, width: 330, height: 40))
    
    //Declare the age Label
    let ageLabel = UILabel(frame: CGRect(x: 20, y: 455, width: 330, height: 40))

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 165.0/255.0, green: 195.0/255.0, blue: 187.0/255.0, alpha: 1)
        
        
        print(name)
        // Do any additional setup after loading the view.
        
        picker.delegate = self
        picker.dataSource = self
        agetextField.inputView = picker
        
        
        self.title = "My dog"
        
        
        //nameLabel of the dog
    //    let nameLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
    //    nameLabel.center = CGPoint(x: 20, y: 250)
        nameLabel.textAlignment = .center
        
        nameLabel.text = "Name: " + name
        nameLabel.textColor = UIColor.white
        nameLabel.font = nameLabel.font.withSize(30)
        nameLabel.font = UIFont(name: "Noteworthy", size: 25)
        nameLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        nameLabel.layer.cornerRadius = 5
        nameLabel.clipsToBounds = true
        view.addSubview(nameLabel)
        
        
       // let genderLabel = UILabel(frame: CGRect(x: 200, y: 250, width: 200, height: 200))
   //     genderLabel.center = CGPoint(x: 20, y: 300)
        genderLabel.textAlignment = .center
        
        genderLabel.text = "Gender: " + gender
        genderLabel.textColor = UIColor.white
        genderLabel.font = genderLabel.font.withSize(30)
        genderLabel.font = UIFont(name: "Noteworthy", size: 25)
        genderLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        genderLabel.layer.cornerRadius = 5
        genderLabel.clipsToBounds = true
        view.addSubview(genderLabel)
        
        
        
  //      birthDateLabel.center = CGPoint(x: 20, y: 350)
        birthDateLabel.textAlignment = .center
        birthDateLabel.text = "Birth Date: " + gender
        birthDateLabel.textColor = UIColor.white
        birthDateLabel.font = birthDateLabel.font.withSize(30)
        birthDateLabel.font = UIFont(name: "Noteworthy", size: 25)
        birthDateLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        birthDateLabel.layer.cornerRadius = 5
        birthDateLabel.clipsToBounds = true
        view.addSubview(birthDateLabel)

        
        
        
        //Label of the vaccination date
   //     vaccinationDateLabel.center = CGPoint(x: 20, y: 400)
        vaccinationDateLabel.textAlignment = .center
        vaccinationDateLabel.text = "Vaccination Date: " + gender
        vaccinationDateLabel.textColor = UIColor.white
        vaccinationDateLabel.font = vaccinationDateLabel.font.withSize(30)
        vaccinationDateLabel.font = UIFont(name: "Noteworthy", size: 25)
        vaccinationDateLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        vaccinationDateLabel.layer.cornerRadius = 5
        vaccinationDateLabel.clipsToBounds = true
        view.addSubview(vaccinationDateLabel)
        
        
        //breed Label
        breedLabel.textAlignment = .center
        breedLabel.text = "Breed: " + breed
        breedLabel.textColor = UIColor.white
        breedLabel.font = breedLabel.font.withSize(30)
        breedLabel.font = UIFont(name: "Noteworthy", size: 25)
        breedLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        breedLabel.layer.cornerRadius = 5
        breedLabel.clipsToBounds = true
        view.addSubview(breedLabel)

        
        //age Label
        ageLabel.textAlignment = .center
        ageLabel.text = "Age: " + breed
        ageLabel.textColor = UIColor.white
        ageLabel.font = ageLabel.font.withSize(30)
        ageLabel.font = UIFont(name: "Noteworthy", size: 25)
        ageLabel.backgroundColor = UIColor(red: 100/255, green: 120/255, blue: 150/255, alpha: 0.65)
        ageLabel.layer.cornerRadius = 5
        ageLabel.clipsToBounds = true
        view.addSubview(ageLabel)


        
        
        
        
        
        
//---------------------------------------------------------------------------------------------------------------------
        /* user profile image */
        let dogImg = profileImgContainer(string:name)
        dogImg.setRounded()
        self.view.addSubview(dogImg)
        ImageViewConstraints(Img: dogImg)
        
        self.title = "My dog"
        
//        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OwnedDogDetailViewController.goBack))
//        backButton.tintColor = UIColor.blue
//        navigationItem.leftBarButtonItem = backButton
        
        //self.view.addSubview(backButton)
        
        let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
        
        let navigationItem = UINavigationItem()
        navigationItem.title = "My dog"

        
        
        navigationBar.backgroundColor = UIColor.white
        navigationBar.delegate = self;
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor.blue
        navigationItem.leftBarButtonItem = backButton
        navigationBar.pushItem(navigationItem, animated: true)
        
        //navigationItem.items[navigationItem]
        self.view.addSubview(navigationBar)
        
        
        
        
        
        //The edit Button
    //    let editProfButton:UIButton = UIButton(frame: CGRect(x: 250, y: 200, width: 50, height: 25))
        editProfButton.backgroundColor = .black
        editProfButton.setTitle("Edit", for: .normal)
        self.view.addSubview(editProfButton)
     //   EditProfileImageButtonConstraints(Button: editProfButton)
        editProfButton.addTarget(self, action: #selector(editProfButtonClick), for: UIControlEvents.touchUpInside)
        
        //The Save Button
    //    let saveProfButton:UIButton = UIButton(frame: CGRect(x: 20, y: 550, width: 330, height: 40))
        saveProfButton.backgroundColor = .black
        saveProfButton.setTitle("Save", for: .normal)
        self.view.addSubview(saveProfButton)
      //  EditProfileImageButtonConstraints(Button: editProfButton)
        saveProfButton.addTarget(self, action: #selector(saveProfButtonClick), for: UIControlEvents.touchUpInside)
        saveProfButton.isHidden = true
        
       

        
    //    var dogNametextField = UITextField(frame: CGRect(20.0, 350.0, 330.0, 40.0))
        dogNametextField.textAlignment = NSTextAlignment.center
        dogNametextField.textColor = UIColor.blue
        dogNametextField.borderStyle = UITextBorderStyle.roundedRect
        dogNametextField.placeholder = "Name"
        dogNametextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogNametextField)
        dogNametextField.isHidden = true
        
   //     var dogGendertextField = UITextField(frame: CGRect(20.0, 400.0, 330.0, 40.0))
        dogGendertextField.textAlignment = NSTextAlignment.center
        dogGendertextField.textColor = UIColor.blue
        dogGendertextField.borderStyle = UITextBorderStyle.roundedRect
        dogGendertextField.placeholder = "Gender"
        dogGendertextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogGendertextField)
        dogGendertextField.isHidden = true

   //     var dogBirhDatetextField = UITextField(frame: CGRect(20.0, 450.0, 330.0, 40.0))
        dogBirhDatetextField.textAlignment = NSTextAlignment.center
        dogBirhDatetextField.textColor = UIColor.blue
        dogBirhDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogBirhDatetextField.placeholder = "Birthdate"
        dogBirhDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogBirhDatetextField)
        dogBirhDatetextField.isHidden = true
        

     //   var dogVaccinationDatetextField = UITextField(frame: CGRect(20.0, 500.0, 330.0, 40.0))
        dogVaccinationDatetextField.textAlignment = NSTextAlignment.center
        dogVaccinationDatetextField.textColor = UIColor.blue
        dogVaccinationDatetextField.borderStyle = UITextBorderStyle.roundedRect
        dogVaccinationDatetextField.placeholder = "Vaccination Date"
        dogVaccinationDatetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(dogVaccinationDatetextField)
        dogVaccinationDatetextField.isHidden = true
       

        agetextField.textAlignment = NSTextAlignment.center
        agetextField.textColor = UIColor.blue
        agetextField.borderStyle = UITextBorderStyle.roundedRect
        agetextField.placeholder = "Vaccination Date"
        agetextField.autocapitalizationType = UITextAutocapitalizationType.words // If you need any capitalization
        self.view.addSubview(agetextField)
        agetextField.isHidden = true

       
        
        
        picker2 = UIDatePicker(frame: CGRect( origin: CGPoint(x:0, y:0), size: CGSize(width:320, height:115) ))
        picker2.center = CGPoint(x: 180, y: 500)
        picker2.backgroundColor = UIColor.white
        let currentDate = Date.init()
        picker2.minimumDate = Date(timeIntervalSince1970: currentDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970.truncatingRemainder(dividingBy: 60))
        picker2.layer.masksToBounds = true
        picker2.layer.cornerRadius = CGFloat(20)
        //picker2.addTarget(self, action: #selector(self.updateText(sender:)), for: UIControlEvents.valueChanged)
        self.textFieldEditing(sender: dogVaccinationDatetextField)
        //picker2.isHidden = true
        picker2.datePickerMode = UIDatePickerMode.date
        self.view.addSubview(picker2)
    
    
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(OwnedDogDetailViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(datePicker:UIDatePicker) {
        /**
        let formatter: DateFormatter = DateFormatter()
        dogVaccinationDatetextField.font = UIFont(name: "Noteworthy", size: 20)
        dogVaccinationDatetextField.textColor = UIColor.black
        dogVaccinationDatetextField.text = formatter.string(from: picker2.date)
 */
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dogVaccinationDatetextField.text = strDate
        vaccinationDateLabel.text = strDate
        
    }
    
    
    //Action when user clicks the Save Button
    func saveProfButtonClick(sender:UIButton!)
    {
        print("The Save Button has been clicked")
        
        dogVaccinationDatetextField.isHidden = true
        dogBirhDatetextField.isHidden = true
        dogGendertextField.isHidden = true
        dogNametextField.isHidden = true
        saveProfButton.isHidden = true
        
        name = dogNametextField.text!
        gender = dogGendertextField.text!
        vaccinationdate = dogVaccinationDatetextField.text!
        birthdate = dogBirhDatetextField.text!
        
        nameLabel.text = "Name: " + name
        genderLabel.text = "Gender: " + gender
        birthDateLabel.text = "Birth Date: " + birthdate
        vaccinationDateLabel.text = "Vaccination Date: " + vaccinationdate
        
        nameLabel.isHidden = false
        genderLabel.isHidden = false
        birthDateLabel.isHidden = false
        vaccinationDateLabel.isHidden = false
        breedLabel.isHidden = false
        ageLabel.isHidden = false
        
    }
    
    //Action when user clicks the edit Button
    func editProfButtonClick(sender:UIButton)
    {
        dogVaccinationDatetextField.isHidden = false
        dogBirhDatetextField.isHidden = false
        dogGendertextField.isHidden = false
        dogNametextField.isHidden = false
        agetextField.isHidden = false
        saveProfButton.isHidden = false
        
        nameLabel.isHidden = true
        genderLabel.isHidden = true
        birthDateLabel.isHidden = true
        vaccinationDateLabel.isHidden = true
        breedLabel.isHidden = true
        ageLabel.isHidden = true
        
        
    }
    //---------------------------function about picker-----------------------------------------------------------
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return ageData.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row:Int, inComponent component : Int)
    {
        agetextField.text = ageData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component : Int)->String?
    {
        return ageData[row]
    }

    
    

    
    
    //--------------------------------end picker------------------------------------------------------------------
        
    
    

    func goBack(){
        print("call goBack function")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "iPetViewController") as! iPetViewController
//        self.present(vc, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* global variable: profileImgContainer --> default profile image */
    func profileImgContainer(string: String) -> UIImageView{
        let ImgView = UIImageView()
        let Img = UIImage(named: string)
        ImgView.image = Img
        ImgView.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        ImgView.translatesAutoresizingMaskIntoConstraints = false
        
        return ImgView
    }
    
    /* layout constriants for profile image */
    func ImageViewConstraints(Img: UIImageView) {
        Img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Img.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 100).isActive = true
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

//used to replace CGRectMake
extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
