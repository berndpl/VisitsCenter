//
//  VisitsLog.swift
//  LocationReminders
//
//  Created by Bernd Plontsch on 11/11/14.
//  Copyright (c) 2014 Bernd Plontsch. All rights reserved.
//

//// USAGE
//VisitsLog.write("something")
//VisitsLog.clear()
//VisitsLog.read()


import UIKit

class VisitsLog: NSObject {
   
    class func write(text:NSString){
        var logText = ("[\(NSDate())] \(text)\n")
        println("WRITE > \(logText)")
        var appendedString:NSString = read().stringByAppendingString(logText)
        var error:NSError?
        appendedString.writeToFile(path(), atomically: false, encoding: NSUTF8StringEncoding, error: &error);
        if error != nil {
            print("[Log] Write Error - \(error!.localizedDescription)")
        }
    }
    
    class func read()->NSString {
        var error:NSError?
        var readText:NSString = NSString(contentsOfFile:path(), encoding:NSUTF8StringEncoding, error: &error)!
        println("READ < \(readText)")
        if error != nil {
            println("[Log] Read Error - \(error!.localizedDescription)")
        }
        return readText
    }
    
    class func clear()->Bool {
        var error:NSError?
        NSString().writeToFile(path(), atomically: false, encoding: NSUTF8StringEncoding, error: &error);
        if error != nil {
            print("[Log] Write Error - \(error!.localizedDescription)")
            return false
        }
        return true
    }
    
    //MARK: HELPER
    
    class func path()->NSString {
        var path:NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first! as NSString
        var filePath = ("\(path)/visits.txt")
        return filePath
    }

    
}
