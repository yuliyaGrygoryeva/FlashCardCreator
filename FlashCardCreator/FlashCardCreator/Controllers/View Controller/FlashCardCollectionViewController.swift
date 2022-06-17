//
//  FlashCardCollectionViewController.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//

import UIKit

private let reuseIdentifier = "flashCardCell"

class FlashCardCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    private var displayedFlashCard: [FlashCard] = []
    private var targetFlashCard: FlashCard?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleFlashcards()

    }

    // MARK: - Functions
    func shuffleFlashcards() {
        let flashCardsShuffled = FlashCardController.shared.flashCards.shuffled()
        let flashCardGroup = flashCardsShuffled.prefix(3)
        displayedFlashCard = Array(flashCardGroup)
        targetFlashCard = FlashCardController.shared.flashCards.randomElement()
        updateViews()
    }
    
    func updateViews() {
        guard let flashCard = targetFlashCard else { return }
        displayedFlashCard.append(flashCard)
        displayedFlashCard.shuffle()
        self.title = "Find \(flashCard.name)"
        collectionView.reloadData()
    }
    
    func presentAlert(flashCard: FlashCard) {
        let succes = flashCard == targetFlashCard
        
        // define alert controller
        let alertController = UIAlertController(title: succes ? "Good job!" : "Study more!", message: nil, preferredStyle: .alert)
        
        // create actions - buttons
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle", style: .default) { _ in
            self.shuffleFlashcards()
        }
        
        //add actions
        alertController.addAction(doneAction)
        if succes {
            alertController.addAction(shuffleAction)
        }
        
        // present the alert controller
        present(alertController, animated: true)
        
        
    }
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toFilterVC" {
//            let destination = segue.destination as? FilterViewController
//            // Step 4 - Assign the delegate
//            destination?.delegate = self
//
//        }
//    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedFlashCard.count
    }

    //Check again else
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FlashCardCollectionViewCell else { return UICollectionViewCell() }
        let flashcard = displayedFlashCard[indexPath.row]
        cell.displayFlashCard(flashCard: flashcard)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flashCard = displayedFlashCard[indexPath.row]
        presentAlert(flashCard: flashCard)
    }
    
}

extension FlashCardCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
    let width = view.frame.width / 2
    return CGSize(width: width - 15, height: width + 30)
    }
}


// Step 3 - Using an extension, conform CharacterCollectionViewController to FilterSelectionDelegate
// Click fix to add required protocol stubs

extension FlashCardCollectionViewController: Delegate {
    func selected(flashCard: String) {
        shuffleFlashcards()
    }
}

    
