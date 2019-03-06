//
//  ViewController.swift
//  HitList
//
//  Created by Martin Schnurrenberger, mVISE AG on 03.03.19.
//  Copyright © 2019 Martin Schnurrenberger, mVISE AG. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    static let cellID = "20190303153600"
    
    @IBOutlet weak var tableView: UITableView!
    
    // without Core Data -> var names: [String] = []
    // with Core Data
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //title = "The List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellID)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let adxAppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let mocManagedContext = adxAppDelegate.persistentContainer.viewContext
        
        //2
        let frxFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        // 3
        do {
            people = try mocManagedContext.fetch(frxFetchRequest)
        } catch let exxError as NSError {
            print("Could not fetch. \(exxError), \(exxError.userInfo)")
        }
    }

    @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            //self.names.append(sNameToSave)
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel )
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        //3
        person.setValue(name, forKeyPath: "name")
        
        //4
        do {
            try managedContext.save()
            people.append(person)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
    
    
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return m_saNames.count
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellID, for: indexPath)
        //cell.textLabel?.text = names[indexPath.row]
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell
    }
}

