//
//  codeTableViewController.swift
//  Open_swift
//
//  Created by 彬海 朱 on 14/12/12.
//  Copyright (c) 2014年 XTF. All rights reserved.
//

import UIKit

class codeTableViewController: UITableViewController {

    var phonecode:String!
    @IBOutlet weak var code: UITextField!
    @IBAction func IDcard(sender: AnyObject) {
        //视图跳转
        var sb = UIStoryboard(name: "Main", bundle: nil)
        var vc = sb.instantiateViewControllerWithIdentifier("IDcard") as IDcardTableViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

      //自定义左边导航按钮，这里设置为无，防止返回上一步
        var left = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action:nil)
        self.navigationItem.leftBarButtonItem = left
        code.text = phonecode
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
}
