//
//  ViewController.swift
//  AlamofireWithSwiftyJSON
//
//  Created by John Paul Manoza on 30/08/2016.
//  Copyright © 2016 NostalgicKid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dictArray = [[String:AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        Alamofire.request(.GET, "http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.dictArray = resData as! [[String:AnyObject]]
                    
                }
                
                if self.dictArray.count > 0 {
                    self.tableView.reloadData()
                }
                
            }
        
        }
    
        tableView.dataSource = self
        tableView.delegate = self
    
    }
        
   
        

   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("customCell")!
        
        var dict = dictArray[indexPath.row]
        
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["email"] as? String
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dictArray.count
    }

}

