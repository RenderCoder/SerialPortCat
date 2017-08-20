//
//  MainWindow.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa

typealias Callback = (NSEvent) -> ()

class MainWindow: NSWindow {
    var keyEventListeners = Array<Callback>()
    
    override func keyDown(with event: NSEvent) {
        if event.modifierFlags.contains(NSEventModifierFlags.command) {
            super.keyDown(with: event)
            self.print(event)
            return
        }
        for callback in keyEventListeners {
            callback(event)
        }
    }
    
    func addKeyEventCallback(callback: @escaping Callback) {
        keyEventListeners.append(callback)
    }
}
