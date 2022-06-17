//
//  FlashCardCollectionViewCell.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//

import UIKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flashCardImage: UIImageView!
    
    func displayFlashCard(flashCard: FlashCard) {
        flashCardImage.image = UIImage(named: "backgroundFlashCard")
        flashCardImage.contentMode = .scaleToFill
        flashCardImage.clipsToBounds = true
    }
}
