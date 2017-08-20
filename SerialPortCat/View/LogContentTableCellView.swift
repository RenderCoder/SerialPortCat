//
//  LogContentTableCellView.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa

class LogContentTableCellView: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        textField?.maximumNumberOfLines = 1
        textField?.lineBreakMode = NSLineBreakMode(rawValue: 0)!
    }
    
}
