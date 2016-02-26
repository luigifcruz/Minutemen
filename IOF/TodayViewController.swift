//
//  TodayViewController.swift
//  IOF
//
//  Created by Luigi Freitas Cruz on 2/24/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Cocoa
import Alamofire
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    @IBOutlet weak var BRL: NSTextField!
    
    var USD: Float = 0.0
    
    override var nibName: String? {
        return "TodayViewController"

    }

    override func viewWillAppear() {
        print("Getting..")
        Alamofire.request(.GET, "https://api.fixer.io/latest?base=USD", parameters: ["foo": "bar"])
            .responseJSON { response in
                if let JSON = response.result.value {

                    let userData = JSON["rates"] as! NSDictionary
                    self.USD = userData.objectForKey("BRL") as! Float
                }
        }
    }
    
    @IBAction func USD(sender: AnyObject) {
        let newBRL = Float(sender.stringValue)

        BRL.stringValue =  String(format: "%.2f", newBRL! * USD * 100 * 1.0638 / 100) + " BRL"
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
    }

}
