//
//  FlashCardController.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//

import Foundation
import UIKit
class FlashCardController {
    // shared instance
    static let shared = FlashCardController()
    
    // SoT
    var flashCards: [FlashCard] = []
    
    // CRUD functions
    // create flashcard
    func createFlashCard(name: String, description: String) {
        
        let newFlashCard = FlashCard(name: name, description: description)
        flashCards.append(newFlashCard)
        saveToPersistenceStore()
    }
    
    // delete flashcard
    func deleteFlashCard(flashCard: FlashCard) {
        guard let index = flashCards.firstIndex(of: flashCard) else { return }
        flashCards.remove(at: index)
        saveToPersistenceStore()
    }
    
    
    // MARK: - Persistence
    // create a place to store data, save data, load data
    func createPersistanceStore() -> URL {   //URL is an address in memory
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("FlashCards.json")
        return fileURL
    }
    
    func saveToPersistenceStore(){
        do {
            let data = try JSONEncoder().encode(flashCards)
            try data.write(to: createPersistanceStore())
            
        } catch {
            print("Error encoding.")
        }
    }
    
    func loadFromPersistanceStore(){
        do {
            let data = try Data(contentsOf: createPersistanceStore())
            //                             decode as  ,  decode from
            flashCards = try JSONDecoder().decode([FlashCard].self, from: data)
        }
        catch {
            print("Error decoding.")
        }
    }

}
