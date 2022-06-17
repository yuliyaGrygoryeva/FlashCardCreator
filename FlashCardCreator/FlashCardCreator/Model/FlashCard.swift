//
//  FlashCard.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//


import UIKit

class FlashCard: Codable {
    var name: String
    var description: String
    
    init(name: String, description: String){
        self.name = name
        self.description = description
    }
}

extension FlashCard: Equatable {
    static func == (lhs: FlashCard, rhs: FlashCard) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description
    }
}
