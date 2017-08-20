//
//  LogTimeTableCellView.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa

class LogTimeTableCellView: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here
        textField?.maximumNumberOfLines = 1
        textField?.lineBreakMode = NSLineBreakMode(rawValue: 0)!
    }
    
    override var backgroundStyle: NSBackgroundStyle {
        didSet {
            if self.backgroundStyle == .light {
                self.textField?.textColor = NSColor(deviceRed:0.6, green:0.6, blue:0.6, alpha:1)
            } else if self.backgroundStyle == .dark {
                
                self.textField?.textColor = NSColor(deviceRed:0.95, green:0.95, blue:0.95, alpha:1)
            }
        }
    }
    
}
