//
//  ViewController.swift
//  CJRulerView
//
//  Created by CJ on 2017/6/9.
//  Copyright © 2017年 CJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rulerView = CJRulerView.init(frame: CGRect(x:0,y:250,width:view.frame.width,height:60))
        
        var items:Array<String> = Array.init()
        for i in 0...25 {
            items.append("\(500 + (i * 100))")
        }
        rulerView.items = items
        rulerView.setItems()
        
        view.addSubview(rulerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

