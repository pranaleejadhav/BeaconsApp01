//
//  ViewController.swift
//  BeaconsApp01
//
//  Created by Pranalee Jadhav on 9/26/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD

class itemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var region: UILabel!
    
}


class ViewController: UIViewController, ESTBeaconManagerDelegate, UITableViewDataSource, UITableViewDelegate {

    var manager = BeaconManager()
    var uuid = NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D");
    var majoruids = [UInt16?]()
    var minoruids = [UInt16?]()
    var regionIdentifiers = [String]()
    var tableArray = [Dictionary<String, Any>]()
    var counter1:Int = 0
    var beaconsFnd = Dictionary<String, Int>()
    
    @IBOutlet weak var header: UILabel!
    enum MyBeacon: String {
        
        case grocery = "738"
        case lifestyle = "33091"
        case produce = "34409"
    }
    

    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        majoruids = [55125,59599,1564];
        minoruids = [738,33091,34409]
        regionIdentifiers = ["grocery","lifestyle","produce"]
       setupBeaconManager()
       tableView.tableFooterView = UIView()
        getData(path: "getdata")
        
       
    }
    // MARK: - ESTBeaconManagerDelegate - Utilities
    
    func setupBeaconManager() {
        BeaconManager.main.delegate = self
        
        if (BeaconManager.main.isAuthorizedForMonitoring() && BeaconManager.main.isAuthorizedForRanging()) == false {
            BeaconManager.main.requestAlwaysAuthorization()
        }
    }
    
    func startMonitoring() {
        print("monitoring started")
        for i in 0..<majoruids.count {
            let region = CLBeaconRegion(proximityUUID: uuid! as UUID,
                                        major: majoruids[i]!, minor: minoruids[i]!, identifier: regionIdentifiers[i])
            print("start monitoring")
            region.notifyOnEntry=true;
            region.notifyOnExit=true;
            region.notifyEntryStateOnDisplay=true;
            BeaconManager.main.startMonitoring(for: region)
            BeaconManager.main.startRangingBeacons(in: region)
            
        }
        
        
    }
    
    // MARK: - ESTBeaconManagerDelegate
    
    func beaconManager(_ manager: Any, didChange status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways ||
            status == .authorizedWhenInUse {
            BeaconManager.main.stopMonitoringForAllRegions()
            startMonitoring()
        }
    }
    
    func beaconManager(_ manager: Any, monitoringDidFailFor region: CLBeaconRegion?, withError error: Error) {
        print( "FAIL " + (region?.proximityUUID.uuidString)!)
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("Hello beacons from \(region.identifier)")
       
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        
        print("Bye bye beacons from \(region.identifier)")

        BeaconManager.main.stopRangingBeacons(in: region)
        beaconsFnd.removeValue(forKey: (region.minor?.stringValue)!)
        if beaconsFnd.count > 0 {
            let minval = beaconsFnd.min { a, b in a.value < b.value }
            updateUI(minorid: (minval?.key)!)
        } else {
            updateUI(minorid: "-1")
        }
      
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        let knownBeacons = beacons.filter { (beacon) -> Bool in
            
            return beacon.proximity != CLProximity.unknown
        }
        
        if let firstBeacon = knownBeacons.first,
            let myBeacon = MyBeacon(rawValue:firstBeacon.minor.stringValue)   {
            var str = firstBeacon.minor.stringValue
            beaconsFnd[str] = firstBeacon.proximity.intValue
            let minval = beaconsFnd.min { a, b in a.value < b.value }
            updateUI(minorid: (minval?.key)!)
            /*var near = firstBeacon.proximity.intValue
            var id = str
            for (key,value) in beaconsFnd {
                print("\(key) = \(value)")
                if value<near {
                    near = value
                    id = key
                }
            }
            print("closest")
            updateUI(minorid: id)*/
            
        }
       
    }
    
    func beaconManager(_ manager: Any, didFailWithError error: Error) {
        print("DID FAIL WITH ERROR" + error.localizedDescription)
    }
    
    
    func getData(path: String) {
        let server_url = "http://ec2-18-221-45-243.us-east-2.compute.amazonaws.com:9800/\(path)"
        SVProgressHUD.show()
        Alamofire.request(server_url).responseJSON { (response:DataResponse<Any>) in
           // print(response)
            
            switch response.result {
            case .success(let value):
               // print(value)
                DispatchQueue.main.async(execute: {
                self.tableArray =  value as! [Dictionary<String, Any>]
                    
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                })
                break
                
            case .failure(let error):
                SVProgressHUD.dismiss()
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem") as!  itemTableViewCell  //1.
        cell.itemName.text = tableArray[indexPath.row]["name"] as? String
        var val:NSNumber = (tableArray[indexPath.row]["price"] as? NSNumber)!
        cell.price.text = val.stringValue
        val = (tableArray[indexPath.row]["discount"] as? NSNumber)!
        cell.discount.text = val.stringValue
        cell.region.text = tableArray[indexPath.row]["region"] as? String
        let str:String = tableArray[indexPath.row]["photo"] as! String
        cell.itemImage.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func updateUI(minorid: String){
        
        if minorid == "738"{
            header.text = "Grocery"
            getData(path: "getproductdata/grocery")
        } else if minorid == "33091"{
            header.text = "Lifestyle"
            getData(path: "getproductdata/lifestyle")
        } else if minorid == "34409"{
            header.text = "Produce"
            getData(path: "getproductdata/produce")
            
        } else {
            header.text = "All Items"
            getData(path: "getdata")
        }
    }
    
}
extension CLProximity {
    var intValue: Int {
        switch self {
        case .unknown:
            return 4
        case .immediate:
            return 1
        case .near:
            return 2
        case .far:
            return 3
        }
    }
}

