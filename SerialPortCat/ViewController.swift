//
//  ViewController.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/19.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var serialPortListPopUpButton: NSPopUpButton!
    @IBOutlet weak var tableView: LogTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Serial Port Cat"
        
        serialPortListPopUpButton.removeAllItems()
        
        let matcher = RegexHelper("^tty\\.")
        
        let fileManager: FileManager = FileManager()
        let files = fileManager.enumerator(atPath: "/dev/")
        while let file = files?.nextObject() {
            guard let file = file as? String else {continue}
            if matcher.match(input: file) {
                print(file)
                serialPortListPopUpButton.addItem(withTitle: file)
            }
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func tapTestAddRowButton(_ sender: Any) {
        print("tapTestAddRowButton")
        tableView.insertRows(at: NSIndexSet(index: tableView.numberOfRows) as IndexSet, withAnimation: NSTableViewAnimationOptions.slideDown)
        if tableView.selectedRowIndexes.count == 0 {
            tableView.scrollToEndOfDocument(nil)
        }
        
    }
    
    


}
