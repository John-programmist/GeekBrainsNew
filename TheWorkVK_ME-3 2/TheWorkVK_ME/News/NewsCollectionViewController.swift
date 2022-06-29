//
//  NewsCollectionViewController.swift
//  TheWorkVK_ME
//
//  Created by Roman on 27.12.2021.
//

import UIKit

class NewsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var models = Array(repeating: Array(repeating: false, count: 3), count: 5)
    
    @IBAction func like(_ sender: PostNews){
        sender.Buttons[0].toggle()
        models[sender.tag][sender.tag] = sender.Buttons[0]
    }
    
    @IBAction func comment(_ sender: PostNews){
        sender.Buttons[1].toggle()
        models[sender.tag][sender.tag] = sender.Buttons[1]
    }
    
    @IBAction func mail(_ sender: PostNews){
        sender.Buttons[2].toggle()
        models[sender.tag][sender.tag] = sender.Buttons[2]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsCollectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "News")
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News", for: indexPath) as! NewsCollectionViewCell
        
        cell.post.image = UIImage(named: "1")
        
        
        cell.postext.text = "How are u?"
        
    
        return cell
    }
    
    
    
    

}


extension NewsCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 302, height: 283)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
}
