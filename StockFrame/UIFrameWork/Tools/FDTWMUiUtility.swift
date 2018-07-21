//
//  FDTWMUiUtility.swift
//  FDTCapital
//
//  Created by sambow on 2016/6/23.
//  Copyright © 2016年 hkfdt. All rights reserved.
//

//import MonkeyKing

class FDTWMUiUtility
{
    /**
     同一字串左右不同的字體需求
     
     - parameter leftString:  左邊字串
     - parameter leftFont:    左邊字體
     - parameter rightString: 右邊字串
     - parameter rightFont:   右邊字體
     
     - returns: Attribute string
     */
    class func atributeString(_ leftString:String, leftFont:UIFont, rightString:String, rightFont:UIFont) ->NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: leftString + rightString)
        attributeString.addAttribute(.font, value: leftFont, range: NSMakeRange(0, leftString.length))
        attributeString.addAttribute(.font, value: rightFont, range: NSMakeRange(leftString.length, rightString.length))
        return attributeString;
    }
    
    class func atributeString(_ attribute:String, leftFont:UIFont, leftRange:NSRange, rightFont:UIFont, rightRange:NSRange) ->NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: attribute)
        attributeString.addAttribute(.font, value: leftFont, range: leftRange)
        attributeString.addAttribute(.font, value: rightFont, range: rightRange)
        return attributeString;
    }
    
    
    class func atributeString(_ leftString:String,
                              leftFont:UIFont,
                              leftColor:UIColor,
                              rightString:String,
                              rightFont:UIFont,
                              rightColor:UIColor) ->NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: leftString + rightString)
        attributeString.addAttribute(.font, value: leftFont, range: NSMakeRange(0, leftString.length))
        attributeString.addAttribute(.font, value: rightFont, range: NSMakeRange(leftString.length, rightString.length))
        
        attributeString.addAttribute(.foregroundColor, value: leftColor, range: NSMakeRange(0, leftString.length))
        attributeString.addAttribute(.foregroundColor, value: rightColor, range: NSMakeRange(leftString.length, rightString.length))
        
        return attributeString;
    }
    
    class func attributeStringWithWMStyle(_ string:NSString,decimalDigitFont:UIFont, regularFont:UIFont)  -> NSAttributedString {
        let set = CharacterSet.decimalDigits
        let decimalDigitRange = string.rangeOfCharacter(from: set)
        
        let invertedSet = CharacterSet.decimalDigits.inverted
        let regularStringRange = string.rangeOfCharacter(from: invertedSet)
        
        let attributeString = NSMutableAttributedString.init(string: string as String)
        attributeString.addAttribute(.font, value: decimalDigitFont, range: decimalDigitRange)
        attributeString.addAttribute(.font, value: regularFont, range: regularStringRange)
        return attributeString
    }
    
    class func attributeStringWtihWMFXStyle(_ string: String?, font:UIFont) -> NSAttributedString? {
        if string == nil {
            return nil
        }
        
        let attributeString = NSMutableAttributedString.init(string: string! as String)
        if (string!.hasPrefix("-") && string!.length == 2) || string!.length == 1 {
            attributeString.addAttribute(.font, value: font, range: NSMakeRange(0, string!.length))
            
            return attributeString
        }
        
        attributeString.addAttribute(.font, value: font, range: NSMakeRange(0, string!.length - 1))
        let smallFont:UIFont = font.withSize(font.pointSize * 2 / 3)
        attributeString.addAttribute(.font, value: smallFont, range: NSMakeRange(string!.length - 1, 1))
        
        return attributeString
    }
}
