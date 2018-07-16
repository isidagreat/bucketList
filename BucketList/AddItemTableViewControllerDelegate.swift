//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Isidro Arzate on 7/5/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate:class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
