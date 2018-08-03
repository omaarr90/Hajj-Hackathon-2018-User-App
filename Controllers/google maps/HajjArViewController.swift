//
//  HajjArViewController.swift
//  Hajj_Hackation_userApp
//
//  Created by Abdulaziz Aloumi on 02/08/2018.
//  Copyright © 2018 X. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation
import MapKit
import HDAugmentedReality


class HajjArViewController :UIViewController,ARDataSource,AnnotationViewDelegate ,CLLocationManagerDelegate {
    var veningMachines = [VendingMachine]();
    fileprivate var arViewController: ARViewController!
    
    fileprivate let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.prepareAr();
        self.startLocagionUpdate()
    }
    
    public func reloadAntotations(){
        self.veningMachines = (self.parent as! MapViewController).veningMachines;
        var anotations = [ARAnnotation]()
        for vm in self.veningMachines {
            anotations.append(vm.anotation!)
        }
        if(anotations.count > 0)
        {
        self.arViewController.setAnnotations(anotations)
        self.arViewController.reload(reloadType: .annotationsChanged)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        return annotationView
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
                //m.region = region
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
    func prepareAr()
    {

        
        arViewController = ARViewController()
        arViewController.dataSource = self
//        arViewController.maxVisibleAnnotations = 30
//        arViewController.headingSmoothingFactor = 0.05
        self.reloadAntotations()

      //  arViewController.setAnnotations(places)
        
        self.present(arViewController, animated: true, completion: nil)
    }

    func didTouch(annotationView: AnnotationView) {
        
    }


}
