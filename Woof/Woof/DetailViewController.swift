//
//  DetailViewController.swift
//  Hompage
//
//  Created by Ye Zhao on 2/23/17.
//  Copyright © 2017 Joann Chen. All rights reserved.
//
import UIKit
import DOFavoriteButton

class DetailViewController: UIViewController, UINavigationBarDelegate{
    
    // MARK: - Outlet from UI
    @IBOutlet weak var detailBreedName: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var button: DOFavoriteButton!
    
    
    // MARK: - Setup data passing variable matches the SearchTableViewController.swift class's prepare function
    
    var detailDog: Breed? {
        didSet {
            print("Call configure view in setting dog value")
            configureView()
            print("finished calling configure view")
        }
    }
    /*
     * This function configures view for the breed detail page
     */
    func configureView() {
        // Check if detailDog is valid
        if let detailDog = detailDog {
            if let detailImageView = detailImageView, let detailBreedName = detailBreedName
            {
                // Assign breed name to the textLabel references in UI
                detailBreedName.text = detailDog.getBreedName()
                
                //Get Breed Profile Image URL
                let urlString = detailDog.getImage();
                if let url = URL(string: urlString){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            print("Failed fetching image:", error)
                            return
                        }
                        
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                            print("Not a proper HTTPURLResponse or statusCode")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            //resize image to have circle border, assign loaded URL image to references in UI
                            detailImageView.image = UIImage(data: data!)
                            detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                            detailImageView.clipsToBounds = true
                        }
                        }.resume()
                }else {
                    //resize image to have circle border, assign loaded URL image to references in UI
                    detailImageView.image = #imageLiteral(resourceName: "dogProfile.png")
                    detailImageView.layer.cornerRadius = detailImageView.frame.size.width/2.0
                    detailImageView.clipsToBounds = true}
                
            }
        }
    }
    func tappedButton(sender: DOFavoriteButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
            if Functionalities.myUser != nil{
                Functionalities.myUser?.removeFavoriteDogBreed(breedname:(detailDog?.getBreedName())!)
                Functionalities.myUser?.updateUser()
                print("Successfully removed breed from user favorite")
                //print()
            }
        } else {
            // select with animation
            sender.select()
            if Functionalities.myUser != nil{
                Functionalities.myUser?.addFavoriteDogBreed(breedname:(detailDog?.getBreedName())!)
                Functionalities.myUser?.updateUser()
                print("Successfully added breed to user favorite")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (self.view.frame.width - 100)
        var x = width / 2
        let y = self.view.frame.height / 2
        
        // heart button
        
        let button = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 100, height: 100), image: UIImage(named: "like"))
        button.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        button.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        button.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        if Functionalities.myUser != nil{
            if (Functionalities.myUser?.breedIsLiked(breedname:(detailDog?.getBreedName())!))! {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        self.view.addSubview(button)
        x += width
        
        configureView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}


