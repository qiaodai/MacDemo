//
//  CustomCell.swift
//  MacNSTableView
//
//  Created by shou.tv on 15/8/11.
//  Copyright (c) 2015年 sxiaojian. All rights reserved.
//

import Cocoa

class CustomCell: NSTableCellView {

    @IBOutlet weak var color: NSColorWell!
    @IBOutlet weak var label1: NSTextField!
    @IBOutlet weak var label2: NSTextField!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
