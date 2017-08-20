//
//  LogTableView.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa

class LogTableView: NSTableView {
    
    private var dataShadow: [LogData] = [LogData]()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.delegate = self
        self.dataSource = self
        
    }
    
    // MARK: - Data functions
    
}

extension LogTableView: NSTableViewDelegate {
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cellIdentifier = tableColumn?.identifier else {return nil}
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = "\(cellIdentifier) \(row)"
            return cell
        }
        
        return nil
    }
    
}

extension LogTableView: NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return "Test"
    }
}
