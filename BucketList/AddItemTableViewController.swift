//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Isidro Arzate on 7/5/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var ItemTextField: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func SaveButtonPress(_ sender: UIBarButtonItem) {
        let text = ItemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    @IBAction func cancelBtnPress(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    

}
