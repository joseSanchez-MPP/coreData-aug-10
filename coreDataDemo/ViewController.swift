//
//  ViewController.swift
//  coreDataDemo
//
//  Created by jose sanchez on 8/12/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBOutlet var dataTextBox: UITextField!
    @IBOutlet var dataLabel: UILabel!
    @IBAction func onWriteDataButtonPressed(_ sender: Any) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(dataTextBox.text!, forKey: "about")
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
            print("Could not save data")
        }
        dataLabel.text?.removeAll()
        dataTextBox.text?.removeAll()
        fetchData()
    }
    @IBAction func onDeleteDataButtonPressed(_ sender: Any) {
        let itemToDelete = dataLabel.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == itemToDelete {
                dataManager.delete (item)
            }
            do {
                try self.dataManager.save()
                
            } catch {
                print("Error Deleting Data")
            }
        }
        dataLabel.text?.removeAll()
        dataTextBox.text?.removeAll()
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        dataLabel.text?.removeAll()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func fetchData() {
        let fetchReq : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchReq)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "about") as! String
                dataLabel.text! = product
            }
        } catch {
            print("Error!")
        }
    }


}

