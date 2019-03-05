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

    @IBOutlet weak var m_tvxTableView: UITableView!
    
    // without Core Data -> var m_saNames: [String] = []
    // with Core Data
    var m_moxaPeople: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "The List"
        
        m_tvxTableView.register(UITableViewCell.self, forCellReuseIdentifier: "20190303153600")
        
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
            m_moxaPeople = try mocManagedContext.fetch(frxFetchRequest)
        } catch let exxError as NSError {
            print("Could not fetch. \(exxError), \(exxError.userInfo)")
        }
    }

    @IBAction func f_addName(_ sender: Any) {
        let acxAlert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        let aaxSaveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let tfxTextField = acxAlert.textFields?.first,
                let sNameToSave = tfxTextField.text else {
                    return
            }
            //self.m_saNames.append(sNameToSave)
            self.f_save(sName: sNameToSave)
            self.m_tvxTableView.reloadData()
        }
        let aaxCancelAction = UIAlertAction(title: "Cancel", style: .cancel )
        acxAlert.addTextField()
        acxAlert.addAction(aaxSaveAction)
        acxAlert.addAction(aaxCancelAction)
        present(acxAlert, animated: true)
    }
    
    func f_save(sName: String) {
        guard let adxAppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        let mocManagedContext = adxAppDelegate.persistentContainer.viewContext
        
        //2
        let edxEntity = NSEntityDescription.entity(forEntityName: "Person", in: mocManagedContext)!
        let moxPerson = NSManagedObject(entity: edxEntity, insertInto: mocManagedContext)
        
        
        //3
        moxPerson.setValue(sName, forKeyPath: "name")
        
        //4
        do {
            try mocManagedContext.save()
            m_moxaPeople.append(moxPerson)
            
        } catch let exxError as NSError {
            print("Could not save. \(exxError), \(exxError.userInfo)")
        }
    }
}
    
    
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return m_saNames.count
        return m_moxaPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tvcCell = tableView.dequeueReusableCell(withIdentifier: "20190303153600", for: indexPath)
        //cell.textLabel?.text = m_saNames[indexPath.row]
        let moxPerson = m_moxaPeople[indexPath.row]
        tvcCell.textLabel?.text = moxPerson.value(forKeyPath: "name") as? String
        return tvcCell
    }
}

