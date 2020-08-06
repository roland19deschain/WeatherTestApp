//
//  MapView.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import MapKit

final class MapView: UIView {
    private var mapView: MapStateProtocol!
    
    // MARK: - Init
    init(type: Map, lat: Double, lon: Double) {
        super.init(frame: .zero)
        switch type {
        case .apple: mapView = AppleMapView(lat: lat, lon: lon)
        case .google: mapView = GoogleMapView(lat: lat, lon: lon)
        }
        mapView.setPosition(lat: lat, lon: lon)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(mapView)
        mapView.fillSuperview(padding: .zero)
    }
    
    // MARK: - Deinit
    deinit { mapView = nil }
    
}
