//
//  NavgationViewController.swift
//  Hajj_Hackation_userApp
//
//  Created by Abdulaziz Aloumi on 02/08/2018.
//  Copyright © 2018 X. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation


class NavgationViewController: UIViewController{
    var sceneLocationView = SceneLocationView()
        override func viewDidLoad() {
        super.viewDidLoad()
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTestImage()
    {
        let coordinate = CLLocationCoordinate2D(latitude: 51.504571, longitude: -0.019717)
        let location = CLLocation(coordinate: coordinate, altitude: 300)
        let image = UIImage(named: "pin")!
        let annotationNode = LocationAnnotationNode(location: location, image: image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)

    }

}
