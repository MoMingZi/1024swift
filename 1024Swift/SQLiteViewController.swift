//
//  SQLiteViewController.swift
//  1024Swift
//
//  Created by 彬海 朱 on 14/12/18.
//  Copyright (c) 2014年 XTF. All rights reserved.
//

import UIKit
import SQLite

class SQLiteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true
            ).first as String
        
        let db = Database("\(path)/db.sqlite3")
        
        let users = db["users"]
        let id = Expression<Int>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
//        db.create(table: users) { t in
//            t.column(id, primaryKey: true)
//            t.column(name)
//            t.column(email, unique: true)
//        }
        // CREATE TABLE "users" (
        //     "id" INTEGER PRIMARY KEY NOT NULL,
        //     "name" TEXT,
        //     "email" TEXT NOT NULL UNIQUE
        // )
        
        var alice: Query?
        if let insertedID = users.insert(name <- "Alice", email <- "alice@mac.com") {
            println("inserted id: \(insertedID)")
            // inserted id: 1
            alice = users.filter(id == insertedID)
        }
        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
        
                for user in users {
                    println("id: \(user[id]), name: \(user[name]), email: \(user[email])")
                    // id: 1, name: Optional("Alice"), email: alice@mac.com
                }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
