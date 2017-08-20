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
    func append(data: LogData) {
        dataShadow.append(data)
        
        insertRows(at: NSIndexSet(index: numberOfRows) as IndexSet, withAnimation: NSTableViewAnimationOptions.slideDown)
        if selectedRowIndexes.count == 0 {
            scrollToEndOfDocument(nil)
        }
    }
    
    func cellData(forIndex index: Int) -> LogData? {
        guard dataShadow.count > index else {return nil}
        return dataShadow[index]
    }
    
    var dataCount: Int {
        return dataShadow.count
    }
    
}

extension LogTableView: NSTableViewDelegate {
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cellIdentifier = tableColumn?.identifier else {return nil}
        
        if
            let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView,
            let cellData = cellData(forIndex: row)
        {
            switch cellIdentifier {
                case "time":
                let calender = Calendar.current
                let components = calender.dateComponents([.hour, .minute, .second, .nanosecond], from: cellData.time)
                guard
                    var hour = components.hour,
                    var minute = components.minute,
                    var second = components.second,
                    var nanosecond = components.nanosecond
                else {
                    return nil
                }
                
                func formatTimeComponent( number: Int) -> String {
                    return String(format: "%02d", number)
                }
                
                cell.textField?.stringValue = "\(formatTimeComponent(number: hour)):\(formatTimeComponent(number: minute)):\(formatTimeComponent(number: second)).\(components.nanosecond!)"
            case "content":
                cell.textField?.stringValue = cellData.content
            default:
                break
            }
            
            return cell
        }
        
        return nil
    }
    
}

extension LogTableView: NSTableViewDataSource {
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataCount
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return "Test"
    }
}
