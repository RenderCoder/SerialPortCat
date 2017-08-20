//
//  LogData.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Foundation

struct LogData {
    var time: Date
    var content: String
    
    init(content: String) {
        time = Date()
        self.content = content
    }
}
