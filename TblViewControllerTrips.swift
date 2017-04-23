//
//  TblViewControllerTrips.swift
//  week6_prac
//
//  Created by 褚冠宏 on 21/04/2017.
//  Copyright © 2017 lawrencechu. All rights reserved.
//

import Foundation
import UIKit

class Trip{
    var tripDate : Date
    var tripDuration : Int
    var tripDestination : String
    var destinationImage : UIImage
    
    init (date : Date, duration : Int, destination : String, img : UIImage){
            self.tripDate = date
            self.tripDuration = duration
            self.tripDestination = destination
            self.destinationImage = img
    
    }
}

class Utilities {

    static var dateFormatter = DateFormatter()
    static var trips : [Trip] = []
    static func loadTrips(){
    
        dateFormatter.dateFormat = "yy/mm/dd"
        trips = [
            Trip(date : dateFormatter.date(from: "17/04/24")!, duration : 2,
                 destination : "Melbourne", img : UIImage(named:"Melbourne")!),
            Trip(date : dateFormatter.date(from: "17/05/24")!, duration : 2,
                 destination : "Sydney", img : UIImage(named:"Sydney")!),
        ]
    }
}

class TblViewControllerTrips: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.loadTrips()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  Utilities.trips.count;
    }


    //fill the table view
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        cell.textLabel?.text = "\(Utilities.trips[indexPath.row].tripDestination), \(Utilities.trips[indexPath.row].tripDuration)"
        
        let text =  "\(Utilities.dateFormatter.string(from: Utilities.trips[indexPath.row].tripDate))"
        print(text)
        cell.detailTextLabel?.text = "\(Utilities.dateFormatter.string(from: Utilities.trips[indexPath.row].tripDate))"
        
        cell.imageView?.image = Utilities.trips[indexPath.row].destinationImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTripDetails2", sender: Utilities.trips[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Utilities.trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let data = sender as? Trip
        if identifier == "segueTripDetails2" && data == nil {
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = sender as? Trip
        if segue.identifier == "segueTripDetails2" && data != nil {
            (segue.destination as! InfoViewController).trip = data
        }
    }
    
    @IBAction func unwindSegue(segue : UIStoryboardSegue){
        self.tableView.reloadData()
    }
}
