//
//  ViewController.swift
//  Swift4MYSQLCRUD
//
//  Created by alj on 4/5/18.
//  Copyright © 2018 aljm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //URL to our web service
    let URL_SAVE_TEAM = URL(string:"http://icodemyanmar.com/ios_api/api/createteam.php")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //TextFields declarations
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldMember: UITextField!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: URL_SAVE_TEAM!)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //getting values from text fields
        let teamName=textFieldName.text
        let memberCount = textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "name="+teamName!+"&member="+memberCount!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

