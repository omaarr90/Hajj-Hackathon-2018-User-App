//
//  MapViewController.swift
//  Hajj_Hackation_userApp
//
//  Created by Abdulaziz Aloumi on 01/08/2018.
//  Copyright © 2018 X. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation
import MapKit
import HDAugmentedReality
import SlideMenuControllerSwift


import GoogleMaps
class MapViewController: UIViewController,CLLocationManagerDelegate {
    var veningMachines = [VendingMachine]();
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var EtLable: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    fileprivate let locationManager = CLLocationManager()

    @IBOutlet weak var seafoodBtn: UIButton!
    @IBOutlet weak var meatBtn: UIButton!
    @IBOutlet weak var chekingBtn: UIButton!
    @IBOutlet weak var arView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocagionUpdate()
        self.getVms();
        self.foucsOnMasher()
    }
    

    @IBAction func menueAction(_ sender: Any) {

        
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        if(sender.isSelected)
        {
            sender.imageView?.tintColor = UIColor.darkGray
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")

            //2
            if location.horizontalAccuracy < 100 {
                //3
                manager.stopUpdatingLocation()
                let span = MKCoordinateSpanMake(0.014, 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
//                m.region = region
            }
        }
    }
    func startLocagionUpdate()
    {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.arView.isHidden = true;
        case 1:
            self.arView.isHidden = false
        default:
            self.arView.isHidden = true;

        }
    }
    
    func getVms()
   {
    ApiManager.shared .getAllMachines { (result, error) in
        if error == nil
        {
            self.reloadVendingMachinesMarkers(newVendingMachines: result);
        }
        else
        {
            // handle error
        }
    }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reloadVendingMachinesMarkers(newVendingMachines:[VendingMachine]?)
    {
        // removing the exasting ones
        for ovm in veningMachines {
            ovm.marker?.map = nil;
        }
        for nvm in newVendingMachines!  {
            nvm.marker?.map = mapView;
            self.veningMachines.append(nvm)
        }
        ( self.childViewControllers[0] as!  HajjArViewController).reloadAntotations()
        
    }
    // just example
    func foucsOnMasher()
    {
        mapView!.animate(to: GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 21.413470, longitude: 39.888171), zoom: 10.0, bearing: 270, viewingAngle: 0.30));
        
    }


}
