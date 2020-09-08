//
//  ViewController.swift
//  Weather Forecast With API
//
//  Created by Brian Kim on 2020-07-21.
//  Copyright © 2020 Brian Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func searchCity(_ sender: Any) {
        var array: [String] = []
        var twoWord = false
        
        if cityTextField.text != "" {
            var city = cityTextField.text!.lowercased()
            for character in city {
                if character == " " {
                    twoWord = true
                    array = NSString(string: city).components(separatedBy: " ")
                }
            }
            if twoWord == false {
                array = [city]
                array[0] = array[0].capitalized
                city = array[0]
            } else {
                array[0] = array[0].capitalized
                array[1] = array[1].capitalized
                city = array[0] + "+" + array[1]
            }
            cityTextField.text = nil
            
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=6b2c67a64958c2f54c9d18a89e16ed7c")!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let urlContents = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContents, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                print(description)                            }
                        } catch {
                            print("JSON Processing Failed")
                        }
                    }
                }
            })
            task.resume()
        }
    }
    

}

