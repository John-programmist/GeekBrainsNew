//
//  MyGroupCellTableViewCell.swift
//  TheWorkVK_ME
//
//  Created by Roman on 07.12.2021.
//

import UIKit

class MyGroupCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    private let imageService = FriendsServiceManager()

    func configure(group: Groups) {
        title.text = group.name
        subtitle.text = group.type
        
        imageService.loadImage(url: group.photo50) { [weak self] image in
            guard let self = self else { return }
            self.photo.image = image
        }
    }
}
