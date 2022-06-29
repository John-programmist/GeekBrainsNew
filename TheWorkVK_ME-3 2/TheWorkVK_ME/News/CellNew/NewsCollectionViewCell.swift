//
//  NewsCollectionViewCell.swift
//  TheWorkVK_ME
//
//  Created by Roman on 27.12.2021.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var post: UIImageView!
    @IBOutlet weak var postext: UILabel!
    @IBOutlet weak var control: PostNews!

}
