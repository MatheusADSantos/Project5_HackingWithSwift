//
//  ViewController.swift
//  Project5_HackingWithSwift
//
//  Created by macbook-estagio on 17/03/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWorlds = [String]()
    var usedWord = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWorldsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWorld = try? String(contentsOf: startWorldsURL) {
                allWorlds = startWorld.components(separatedBy: "\n")
            }
        }
        
        if allWorlds.isEmpty {
            allWorlds = ["silkworm"]
        }
        startGame()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        let aa = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer: answer)
        }
        ac.addAction(aa)
        present(ac, animated: true)
    }
    
    func submit(answer : String) {
        print("answer: ",answer)
    }
    
    
    
    func startGame() {
        title = allWorlds.randomElement()
        usedWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWord[indexPath.row]
        return cell
    }


}

