//
//  FlashCardTableViewController.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//

import UIKit

class FlashCardTableViewController: UITableViewController {

    @IBOutlet var flashCardTableView: UITableView!
    //@IBOutlet weak var flashCardNameLabel: UILabel!
    //@IBOutlet weak var FlashCardDetailsLabel: UILabel!
    
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        flashCardTableView.delegate = self
        flashCardTableView.dataSource = self
        flashCardTableView.reloadData()
        // from TableViewController?
        FlashCardController.shared.loadFromPersistanceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createFlashCard(_ sender: Any) {
        // create an alert controller
        let ac = UIAlertController(title: "New FlashCard", message: "How would you like to name flashcard", preferredStyle: .alert)
        
        // add textfield to that controller
        ac.addTextField{ (field) in field.placeholder = "Flashcard name"}
        ac.addTextField{ (field) in field.placeholder = "Details"}
        
       
        // declare our add action
        let addAction = UIAlertAction(title: "Add", style: .default) {
            _ in
            // Handler of our action we do 2 things
            // 1. Extract the text from our textfield
            // 2. Ensure that our flashcard name is not emty
            if let flashCardName = ac.textFields?.first?.text, !flashCardName.isEmpty, let flashCardDetails = ac.textFields?[1].text, !flashCardDetails.isEmpty {
            
            
                // create flashcard
                // TODO
                FlashCardController.shared.createFlashCard(name: flashCardName, description: flashCardDetails)
                self.tableView.reloadData()
            }
        }
        // declare our cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        // add our actions to the alert controller
        ac.addAction(addAction)
        ac.addAction(cancelAction)
    
        // present the alert controller
        self.present(ac, animated: true)
    
    }
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlashCardController.shared.flashCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flashCardCell", for: indexPath)
        
        // Configure the cell...
        let flashCard = FlashCardController.shared.flashCards[indexPath.row]
        cell.textLabel?.text = flashCard.name
        cell.detailTextLabel?.text = flashCard.description
        
        return cell
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let flashCard = FlashCardController.shared.flashCards[indexPath.row]
            FlashCardController.shared.deleteFlashCard(flashCard: flashCard)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
