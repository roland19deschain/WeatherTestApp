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
    var mapData: MapData! {
        didSet {
            navigationItem.title = mapData.city
            mapView = MapView(type: mapData.type, lat: mapData.lat, lon: mapData.lon)
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
