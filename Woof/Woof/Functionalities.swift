//
//  Functionalities.swift
//  Woof
//
//  Created by Joanna Xu on 2/16/17.
//  Copyright © 2017 Woof. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class Functionalities{
    
    var databaseHandle: FIRDatabaseHandle?
    
    static var breedList = [Breed]()
    
    var currBreed: Breed?
    
    var dogIDList = [String]()
    
    static var myUser: User?
    
    static var userExist = false
    
    static var dogList = [Dog]()
    
    init(){}
    // return a whole dog breed list for woofipedia
    // call this method in viewdidload
    func retrieveBreedList(controller: SearchTableViewController) {
        let ref = FIRDatabase.database().reference()
        databaseHandle = ref.child("Breeds").observe(.value, with: { (snapshot) in
            
            let enumerator = snapshot.children
            while let next = enumerator.nextObject() as? FIRDataSnapshot {
                print("-")
                
                //print(next.key)
                var breed = next.value as? NSDictionary
                //var breed = snapshot.value as? NSDictionary
                
                //print(breed)
                
                //if let actualbreed = breed {
                let thisbreed = Breed(dictionary: breed!)
                print(thisbreed.getBreedName())
                Functionalities.breedList.append(thisbreed)
                //}
                
                controller.dogs.append(thisbreed)
                controller.tableView.reloadData()
            }
            
        })
        //        let dao = DataAccessObject()
        //        currBreed = dao.viewBreed(breedName: "Yorkshire")
        //        breedList.append(currBreed!)
    }
    

    
    func retrieveDogList(controller: iPetViewController) {
        let ref = FIRDatabase.database().reference()
        //Functionalities.myUser = controller.user
        databaseHandle = ref.child("Dog Profile").observe(.value, with: {(snapshot) in
            let dogs = snapshot.value as? NSDictionary
            let keys = dogs?.allKeys as? [NSString]
            
            for key in keys! {
                for id in (Functionalities.myUser?.dogIDs)! {
                    if (id == key as String) {
                        print("found")
                        let dog = dogs?[key] as? NSDictionary
                        let thisDog = Dog(dictionary: dog!)
                        var toCheck = 0
                        for index in Functionalities.dogList {
                            if (index.dogID == key as String) {
                                toCheck = 1
                            }
                        }
                        if (toCheck != 1) {
                            thisDog.dogID = key as String
                            Functionalities.dogList.append(thisDog)
//                            controller.ownedDog.append(thisDog.name)
//                            controller.age.append(thisDog.age)
//                            controller.breed.append(thisDog.breed.breedName)
//                            controller.gender.append(thisDog.gender)
//                            controller.color.append(thisDog.color)
//                            controller.dogID.append(key as String)
//                            controller.dogList.append(thisDog)
                            
                            controller.collectView.reloadData()
                        }
                        else {
                            var count = 0
                            for index in Functionalities.dogList {
                                if (index.dogID == key as String) {
                                    break
                                }
                                count = count + 1
                            }
                            thisDog.dogID = key as String
                            Functionalities.dogList[count] = thisDog
//                            controller.ownedDog[count] = thisDog.name
//                            controller.age[count] = thisDog.age
//                            controller.breed[count] = thisDog.breed.breedName
//                            controller.gender[count] = thisDog.gender
//                            controller.color[count] = thisDog.color
//                            controller.dogList[count] = thisDog
//                            controller.dogID[count] = thisDog.dogID
                            
                            controller.collectView.reloadData()
                        }
                        toCheck = 0
                    }
                }
            }
        })
    }
    
    func userExist(user:User) -> Bool {
        let ref = FIRDatabase.database().reference()
        ref.child("User Profile").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as? NSDictionary
            let keys = users?.allKeys as! [NSString]
            for key in keys {
                if (Functionalities.myUser?.userID == key as String) {
                    Functionalities.userExist = true
                    print("((((((((((((((((((((((((((((((((((((((((((((")
                    print(Functionalities.userExist)
                    self.retrieveUserProfile(user: Functionalities.myUser!)
                }
            }
        })
        
        return false
        
    }
    
    func retrieveUserProfile(user:User) -> User {
        let ref = FIRDatabase.database().reference()
        ref.child("User Profile").child(user.userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let profile = snapshot.value as? NSDictionary
            let thisuser = User(dictionary: profile!)
            Functionalities.myUser = thisuser
            Functionalities.myUser?.userID = user.userID
        })
        
        return Functionalities.myUser!
    }
   
    func addUserImage(chosenImage: UIImage, user: User) {
        let storageRef = FIRStorage.storage().reference().child(user.userID)
        var url:URL?
        if let imageData = UIImagePNGRepresentation(chosenImage) {
            storageRef.put(imageData, metadata: nil) {(metadata, error) in
                guard let metadata = metadata else {
                    print(error)
                    print("*****************************************************")
                    return
                }
                var downloadURLs = metadata.downloadURLs
                print(downloadURLs)
                user.image = String(describing: (downloadURLs?[0])!)
                Functionalities.myUser?.updateUser()
            }
        }
    }
    
    func addDogImage(chosenImage: UIImage, dog: Dog) {
        let storageRef = FIRStorage.storage().reference().child(dog.dogID)
        var url:URL?
        if let imageData = UIImagePNGRepresentation(chosenImage) {
            storageRef.put(imageData, metadata: nil) {(metadata, error) in
                guard let metadata = metadata else {
                    print(error)
                    print("*****************************************************")
                    return
                }
                var downloadURLs = metadata.downloadURLs
                print(downloadURLs)
                dog.image = String(describing: (downloadURLs?[0])!)
                Functionalities.myUser?.updateDog(dog: dog)
            }
        }
    }
 
    
    func retrieveUserImage(UIImageView: UIImageView) {
        var Img = UIImage(named: "BlackEmptyDog")
        if Functionalities.myUser?.getImage() != "" {

            let storageRef = FIRStorage.storage().reference()
            
            let fileRef = storageRef.child((Functionalities.myUser?.userID)!)
            
            fileRef.data(withMaxSize: 10 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    // Data for "images/island.jpg" is returned
                    Img = UIImage(data: data!)
                    print(Img)
                    print("****************************")
                    UIImageView.image = Img
                }
            }
        } else {
            UIImageView.image = Img
        }
    }
    
    func retrieveDogImage(UIImageView: UIImageView, dog: Dog, controller: iPetViewController) {
        var Img = UIImage(named: "bone")
        if dog.getImage() != "" {
            
            let storageRef = FIRStorage.storage().reference()
            
            let fileRef = storageRef.child(dog.getDogID())
            
            fileRef.data(withMaxSize: 100 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                } else {
                    print(dog.dogID)
                    Img = UIImage(data: data!)
                    print(Img)
                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
                    UIImageView.image = Img
                    controller.dogImages[dog.dogID] = Img!
                }
            }
        } else {
            UIImageView.image = Img
            controller.dogImages[dog.dogID] = Img!
        }
    }
    
//    func deleteDogFromList(dogID: String) {
//        var i = 0
//        for dog in Functionalities.dogList {
//            if dog.getDogID() == dogID {
//                Functionalities.dogList.remove(at: i)
//                break
//            }
//            i += 1
//        }
//    }
    
    func getBreedList(controller: SearchTableViewController) -> [Breed] {
        retrieveBreedList(controller: controller)
        print(Functionalities.breedList)
        return Functionalities.breedList
    }
    
    func setUser(user: User) {
        Functionalities.myUser = user
    }
    
    func getUser() -> User {
        return Functionalities.myUser!
    }
    
    
}

