//
//  ViewController.swift
//  sunset
//
//  Created by Ahmed nabil on 3/25/18.
//  Copyright © 2018 Ahmed nabil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lacity: UITextField!
    
    
    @IBOutlet weak var laresults: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    @IBAction func get(_ sender: Any) {
   
    
        
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(lacity.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
        
        LoadURL(url: url)
    
    
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func LoadURL(url:String) {
        
        DispatchQueue.global().async {
    
        do {
            
            let AppURL = URL(string: url)!
            let data = try Data(contentsOf: AppURL)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            
            
            let query=json ["query"] as! [String:Any]
            let results=query["results"] as! [String:Any]
            let channel=results ["channel"] as! [String:Any]
            let astronomy=channel ["astronomy"] as! [String:Any]
            
          //print(astronomy["sunset"]!)
    
            DispatchQueue.global().sync {
            
            self.laresults.text = "sunset at:\(astronomy["sunset"]!)"

            }
        }
            
        catch {
            
            print("can't load from server")
        }
    
        
    }

    }
    
}
