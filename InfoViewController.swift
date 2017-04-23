//
//  InfoViewController.swift
//  week6_prac
//
//  Created by 褚冠宏 on 23/04/2017.
//  Copyright © 2017 lawrencechu. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var trip : Trip?
    
    @IBOutlet weak var destination: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destination.text = trip?.tripDestination
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTripAction(_ sender: Any) {
        trip!.tripDestination = destination.text!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
