//
//  MapController.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class MapController: UIViewController {
    private var mapView: UIView!
    var mapHandler: MapHandlerProtocol! {
        didSet {
            navigationItem.title = mapHandler.city
            mapView = MapView(type: mapHandler.type, lat: mapHandler.coordinate.lat, lon: mapHandler.coordinate.lon)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.fillSuperview(padding: .zero)
    }
    
}
