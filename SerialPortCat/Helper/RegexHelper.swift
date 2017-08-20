//
//  RegexHelper.swift
//  SerialPortCat
//
//  Created by huchunbo on 2017/8/20.
//  Copyright © 2017年 huchunbo. All rights reserved.
//

import Foundation

struct RegexHelper {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        do {
            try regex = NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch let error as NSError {
            regex = NSRegularExpression()
            print("init RegexHelper error: \(error)")
        }
        
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                        options: NSRegularExpression.MatchingOptions.init(rawValue: 0),
                                        range: NSMakeRange(0, input.characters.count )) {
            return matches.count > 0
        } else {
            return false
        }
    }
}
