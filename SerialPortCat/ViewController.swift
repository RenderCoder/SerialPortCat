//
//  ViewController.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/19.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Cocoa
import ORSSerial

class ViewController: NSViewController {

    @IBOutlet weak var serialPortListPopUpButton: NSPopUpButton!
    @IBOutlet weak var tableView: LogTableView!
    @IBOutlet weak var raudRateSelector: NSPopUpButton!
    @IBOutlet weak var customBaudRateTextField: NSTextField!
    
    var serialPort: ORSSerialPort?
    let previewVC = LogPreviewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Serial Port Cat"
        
        setupBaudRateSelector()
        refreshSerialPortList()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        guard let window = view.window as? MainWindow else {return}
        window.addKeyEventCallback { [unowned self] (event: NSEvent) in
            guard event.keyCode == 49 else {return}
            guard self.tableView.selectedRowIndexes.count > 0 else {return}
            print(self.tableView.selectedRowIndexes)
            
            var content: String = ""
            
            for (_, item) in self.tableView.selectedRowIndexes.enumerated() {
                guard let cellData = self.tableView.cellData(forIndex: item) else {continue}
                // content += "\(cellData.time)    \(cellData.content)\n"
                content += cellData.content
            }
            
            self.previewVC.display(content: content)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    private func setupBaudRateSelector() {
        raudRateSelector.removeAllItems()
        raudRateSelector.addItems(withTitles: [
            "9600",
            "115200",
            "921600",
            "custom"
            ])
    }
    
    private func refreshSerialPortList() {
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
    
    private func connect(serialPortPath: String){
        print("try to connect serial port: \(serialPortPath)")
        serialPort = ORSSerialPort(path: serialPortPath)
        serialPort?.delegate = self
        serialPort?.baudRate = 115200
        serialPort?.open()
    }
    
    // MARK: - user action handlers
    
    @IBAction func tapTestAddRowButton(_ sender: Any) {
        NSLog("tapTestAddRowButton")
        
        tableView.append(data: LogData(content: "test data"))
        tableView.insertRows(at: NSIndexSet(index: tableView.numberOfRows) as IndexSet, withAnimation: NSTableViewAnimationOptions.slideDown)
        print("numberOfRows: \(tableView.numberOfRows) | dataCount: \(tableView.dataCount)")
        
        if tableView.selectedRowIndexes.count == 0 {
            tableView.scrollToEndOfDocument(nil)
        }
        
    }
    
    @IBAction func didSelectSerialPort(_ sender: NSPopUpButton) {
        NSLog("did select serial port: \(sender.selectedItem!.title)")
        guard let serialPortName = sender.selectedItem?.title else {return}
        connect(serialPortPath: "/dev/\(serialPortName)")
    }
    
    @IBAction func tapRefreshSerialPortListButton(_ sender: NSButton) {
        refreshSerialPortList()
        
    }
    
    @IBAction func tapCloseSerialPortButton(_ sender: NSButton) {
        NSLog("tapCloseSerialPortButton()")
        serialPort?.close()
    }
    
    @IBAction func didSelectBaudRate(_ sender: NSPopUpButton) {
        NSLog("did select Baud Rate \(sender.selectedItem!.title)")
        guard let targetBaudRate = sender.selectedItem?.title else {return}
        if let targetBaudRateNumber = Int(targetBaudRate) {
            serialPort?.baudRate = NSNumber(value: targetBaudRateNumber)
        } else {
            // custom
            let customBaudNumber = customBaudRateTextField.intValue
            serialPort?.baudRate = NSNumber(value: customBaudNumber)
        }
        
    }
    
    
}

extension ViewController: ORSSerialPortDelegate {
    
    func serialPortWasRemoved(fromSystem serialPort: ORSSerialPort) {
        
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        /*
         NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         [self.receivedDataTextView.textStorage.mutableString appendString:string];
         [self.receivedDataTextView setNeedsDisplay:YES];
         */
        print(data)
        guard let receivedNSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            print("error on convert serial port data to NSString.")
            return
        }
        let receivedString = String(describing: receivedNSString)
        
        tableView.append(data: LogData(content: receivedString))
    }
    
    func serialPortWasOpened(_ serialPort: ORSSerialPort) {
        print("serialPortWasOpened")
    }
    
    func serialPortWasClosed(_ serialPort: ORSSerialPort) {
        print("serialPortWasClosed")
    }
}
