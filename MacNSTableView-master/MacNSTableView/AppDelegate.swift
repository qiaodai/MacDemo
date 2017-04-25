//
//  AppDelegate.swift
//  MacNSTableView
//
//  Created by shou.tv on 15/8/11.
//  Copyright (c) 2015年 sxiaojian. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate , NSTableViewDataSource,NSTableViewDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.window.minSize = NSSize.init(width: 350, height: 500)
        self.window.maxSize = NSSize.init(width: 350, height: 500)
        self.window.display()
    }
    
    @IBOutlet weak var tableview: NSTableView! {
        didSet{
            self.tableview.register(NSNib(nibNamed: "CustomCell", bundle: nil)!, forIdentifier: "CustomCell")
        }
    }

    @IBOutlet weak var window: NSWindow!

    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 20
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableview.make(withIdentifier: "CustomCell", owner: self) as! CustomCell
        cell.label1.stringValue = "============="
        cell.label2.stringValue = "+++++++++++++"
        cell.color.color = NSColor.yellow
        return cell
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 111
    }
   

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

