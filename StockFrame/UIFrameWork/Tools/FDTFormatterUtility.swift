//
//  FDTFormatterUtility.swift
//  FDTCapital
//
//  Created by FDT14009Mac on 2016/4/12.
//  Copyright © 2016年 hkfdt. All rights reserved.
//

import Foundation

open class FDTFormatterUtility {
    /**
     快速做四捨五入/無條件捨去或進位
     @param original : 原始數字
     @param roundingMode : Round mode
     @param scale : 取到小數第幾位
     @returns format完的結果
     @exception <#throws#>
     */
    static var numberFormatter = NumberFormatter()
    
    open class func formatTo(_ original:NSDecimalNumber!, roundingMode:NSDecimalNumber.RoundingMode, scale:Int16) -> NSDecimalNumber{
        if original == nil {
            return NSDecimalNumber.zero
        }
        
        let handler = NSDecimalNumberHandler.init(roundingMode: roundingMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        
        let newNumber = original.rounding(accordingToBehavior: handler)
        return newNumber
    }
    
    open class func formatToDecimalStyle(_ original:NSDecimalNumber!,
                                           maximumFractionDigits:Int,
                                           minimumFractionDigits:Int,
                                           roundingMode:NumberFormatter.RoundingMode) -> String{
        if original == nil{
            return Constant.string.invalid
        }
        if original == NSDecimalNumber.notANumber {
            return Constant.string.invalid
        }
        
//        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.minimumFractionDigits = minimumFractionDigits
        numberFormatter.roundingMode = roundingMode
        
        
        return numberFormatter.string(from: original)!
    }
    
    open class func formatToDecimalStyle(_ original:NSDecimalNumber!,
                                           maximumFractionDigits:Int,
                                           roundingMode:NumberFormatter.RoundingMode) -> String{
        if original == nil{
            return Constant.string.invalid
        }
        if original == NSDecimalNumber.notANumber {
            return Constant.string.invalid
        }
        
//        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        numberFormatter.roundingMode = roundingMode
        
        if let n = numberFormatter.string(from: original){
            return n
        }
        return original.stringValue;
    }
    /**
     自動取整數，添加千分點，大多用於浮動盈虧
     
     - parameter original: 原始資料
     
     - returns: 
     */
    open class func formatToDecimalStyle(_ original:NSDecimalNumber!) -> String{
        
        return self.formatToDecimalStyle(original, maximumFractionDigits: 0, roundingMode: NumberFormatter.RoundingMode.down)
    }
    
    open class func formatToDecimalStyle(_ original:String!) -> String{
        
        return self.formatToDecimalStyle(NSDecimalNumber(string:original), maximumFractionDigits: 0, roundingMode: NumberFormatter.RoundingMode.down)
    }
    
    
    open class func hhmmssFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    open class func mmssFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    open class func formatToReadableStyle(_ number: String?, withComma: Bool) -> String {
        if let str = number
        {
            let decimal: NSDecimalNumber? = NSDecimalNumber(string: str)
            if decimal == nil || decimal == NSDecimalNumber.notANumber || str == Constant.string.invalid
            {
                return str
            }
            return FDTFormatterUtility.formatToReadableStyle(decimal!, withComma: withComma, digit: 2)
        }
        else
        {
            return Constant.string.invalid
        }
    }
    
    open class func formatToReadableStyle(_ number: NSDecimalNumber, withComma: Bool) -> String {
        return FDTFormatterUtility.formatToReadableStyle(number, withComma: withComma, digit: 2)
    }
    
    open class func formatToReadableStyle(_ number: NSDecimalNumber, withComma: Bool, digit: Int) -> String {
        //EN  K,M,B,T
        //TW
        
        var units: Array<String>!
        var logCount: Double
        var minUnit: Double
        let digitPow: Double = pow(10, Double(digit))
        switch FDTOCTools.getDeviceLanguage()
        {
        case .EN:
            units = ["K","M","B","T"]
            logCount = 3
            minUnit = 1000
            break
        case .TW:
            units = ["萬","億","萬亿","萬萬亿"];
            logCount = 4
            minUnit = 10000
            break
        default:
            units = ["万","亿","万亿","万万亿"];
            logCount = 4
            minUnit = 10000
            break
        }
        
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < minUnit)
        {
            return "\(sign)\(num)";
        }
        
        let exp:Int = Int(log10(num) / logCount );
        
        let roundedNum:Double = round(digitPow * num / pow(minUnit ,Double(exp))) / digitPow;
        
        return "\(sign)\(roundedNum)\(units[exp-1])";
    }
    
    open class func formatToNomalStyle(_ number: NSDecimalNumber, digit: Int) -> String {
        let num:Double = number.doubleValue
        let format = "%.\(digit)f"
        return String(format: format, num)
    }
    
    //换算为亿
    open class func formatToYiStyle(_ number: NSDecimalNumber, digit: Int) -> String {
        var num:Double = number.doubleValue
        num = num / pow(10, 8)
        let format = "%.\(digit)f"
        return String(format: format, num)
    }
    
    //换算为万
    open class func formatToWanStyle(_ number: NSDecimalNumber, digit: Int) -> String {
        var num:Double = number.doubleValue
        num = num / pow(10, 4)
        let format = "%.\(digit)f"
        return String(format: format, num)
    }
    /**
     convert decimal number to string
     
     - parameter number: decimal number
     
     - returns: string
     */
    open class func convetToString(_ number: NSDecimalNumber!) -> String
    {
        if number == nil || number == NSDecimalNumber.notANumber
        {
            return Constant.string.invalid
        }
        return number.stringValue
    }
    
    //日期转换函数 yyyymmdd -> yyyy-mm-dd
    open class func formatDashStyle(_ date: String?) -> String {
        if let dateStr = date {
            var dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYYMMdd"
            let newDate = dateformatter.date(from: dateStr)
            dateformatter.dateFormat = "YYYY-MM-dd"
            let formatDate = dateformatter.string(from: newDate!)
            return formatDate
        }
        return "--"
    }
}
