//
//  PhoneTableViewController.swift
//  Open_swift
//
//  Created by 彬海 朱 on 14/12/12.
//  Copyright (c) 2014年 XTF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhoneTableViewController: UITableViewController,UIAlertViewDelegate {
    
    var code:String!
    var success:String!
    var note:String!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBAction func Getcode(sender: AnyObject) {
        //Alamofire网络类库的使用方法
        Alamofire.request(.POST,GETCODE, parameters:["sj":self.phone.text])
            .responseJSON { (_, _,JSOND,_) in
                
                //swiftJson类库的使用，解析json格式数据
                let json = JSON(JSOND!)
                
                self.note = json["note"].stringValue
                self.success = json["success"].stringValue
                self.code = json["yzm"].stringValue
                
                if (self.success == "true") {
                    
                    //视图跳转，把验证码传递到下一个视图
                    var sb = UIStoryboard(name: "Main", bundle: nil)
                    var vc = sb.instantiateViewControllerWithIdentifier("code") as codeTableViewController
                    //把验证码传递到下一个视图
                    vc.phonecode = self.code
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }else{
                    //SCLAlertView的使用方法
                    SCLAlertView().showWarning("温馨提示", subTitle:json["note"].stringValue, closeButtonTitle: "取消", duration: 2)
                }
                
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
