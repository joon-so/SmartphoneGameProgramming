//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by KPUGAME on 2021/03/28.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {

    var player:Player?
    
    var game:String = "배틀그라운드" {
        didSet {
            detailLabel.text? = game
        }
    }
    @IBAction func unwindWithSelectedGame(segue:UIStoryboardSegue) {
        if let gamePickerViewController = segue.source as? GamePickerViewController, let selectedGame = gamePickerViewController.selectedGame {
            game = selectedGame
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: nameTextField.text!, game: game, rating: 5)
        }
        
        if segue.identifier == "PickGame" {
            if let gamePickerViewController = segue.destination as? GamePickerViewController {
                gamePickerViewController.selectedGame = game
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    deinit {
        print("deinit PlayerDetailsViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    
}
