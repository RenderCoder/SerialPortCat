//
//  LogPreviewViewController.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Foundation
import Quartz

class LogPreviewViewController: NSViewController,  QLPreviewPanelDataSource, QLPreviewPanelDelegate {
    
    var _fileURL: URL?
    
    var fileURL: URL {
        get {
            return _fileURL ?? createContentToFile(byContent: "")!
        }
        set(val) {
            _fileURL = val
        }
    }
    
    
    func createContentToFile(byContent content: String) -> URL? {
        let file = "Preview Log" //this is the file. we will write to and read from it
        
        let text = content //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            return path
        }
        
        return nil
    }
    
    func display(content: String) {
        guard let url = createContentToFile(byContent: content) else {return}
        fileURL = url
        display()
    }
    
    func display() {
        if let sharedPanel = QLPreviewPanel.shared() {
            sharedPanel.delegate = self
            sharedPanel.dataSource = self
            sharedPanel.makeKeyAndOrderFront(self)
        }
    }
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return 1
    }
    
    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        let url = fileURL
        let item =  url as QLPreviewItem
        return item
    }
}
