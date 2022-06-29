//
//  MyGroupCollection.swift.swift
//  TheWorkVK_ME
//
//  Created by Roman on 12.12.2021.
//

import UIKit

class MyGroupCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models: [Bool] = [false, false, false, false, false]
    
    var certainPhoto: String? = ""
    var certainGroup = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = certainGroup
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return models.count
    }
    
    @IBAction func likeButton(_ sender: LikeProcess){
        sender.likeButton.toggle()
        models[sender.tag] = sender.likeButton
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPage", for: indexPath) as! MyCollectionGroupCell
        
        if(certainPhoto != nil){
            cell.mem.image = UIImage(named: certainPhoto!)
            cell.mem.layer.shadowColor = UIColor.black.cgColor
            cell.mem.layer.shadowRadius = 30
            cell.mem.layer.shadowOpacity = 1
            cell.mem.layer.shadowOffset = CGSize(width: 10, height: 10)
        }
        else{
            cell.mem.image = UIImage(systemName: "person.fill")
            cell.mem.layer.cornerRadius = cell.mem.frame.width / 2
        }
        
        cell.likePhoto.tag = indexPath.row
        cell.likePhoto.likeButton = models[indexPath.row]
        
        cell.text.text = "Это что за красавчик?)"
        
    
        return cell
    }
    
}

extension MyGroupCollection: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 347, height: 315)
    }
}

