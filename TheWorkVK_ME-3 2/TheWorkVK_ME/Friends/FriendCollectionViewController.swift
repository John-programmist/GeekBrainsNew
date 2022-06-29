//
//  FriendCollectionViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 07.12.2021.
//

import UIKit

class FriendCollectionViewController: UICollectionViewController {
    
    var friends: [User] = User.person.sorted(by: {$0.name[0] < $1.name[0]} )//Сортировка
    
    var models: [Bool] = [false, false, false, false, false]
    
    var certainPhoto = ""
    var certainPerson = ""
    var service = FriendsServiceManager()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = certainPerson
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return models.count
    }
    
    @IBAction func likeButton(_ sender: LikeProcess){
        sender.likeButton.toggle()
        models[sender.tag] = sender.likeButton
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPage", for: indexPath) as! FriendCollectionViewCell
        
//        if(certainPhoto != nil) {
//            cell.photoOfFriend.image = UIImage(named: certainPhoto!)
//            cell.photoOfFriend.layer.shadowColor = UIColor.black.cgColor
//            cell.photoOfFriend.layer.shadowRadius = 30
//            cell.photoOfFriend.layer.shadowOpacity = 1
//            cell.photoOfFriend.layer.shadowOffset = CGSize(width: 10, height: 10)
//        }
//        else {
//            cell.photoOfFriend.image = UIImage(systemName: "person.fill")
//            cell.photoOfFriend.layer.cornerRadius = cell.photoOfFriend.frame.width / 2
//        }
        
        service.loadImage(url: certainPhoto) { image in
            cell.photoOfFriend.image = image
        }
        cell.photoOfFriend.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        cell.ilikeit.tag = indexPath.row
        cell.ilikeit.likeButton = models[indexPath.row]
        
        cell.post.text = "Это что за красавчик?)"
        
    
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
			let vc = storyboard?.instantiateViewController(withIdentifier: "Carousel") as? CaruselkaViewController
		else {
			return
		}
        
        vc.photos = friends[indexPath.item].storedImages 
        vc.selectedPhoto = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension FriendCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 347, height: 315)
    }
}
