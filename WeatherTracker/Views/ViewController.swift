//
//  ViewController.swift
//  WeatherTracker
//
//  Created by Madeline Burton on 6/28/22.
//

import UIKit

class ViewController: UIViewController {

    // Create outlets for all view controller fields
    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var weatherAnim: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var data = CurrentViewModel()
        print(data.weather.current)
        
        
        
    }


}

