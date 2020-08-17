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
    private let distanceView = DistanceView()
    
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
        
        addSubview(distanceView)
        distanceView.anchor(top: nil,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: 0, left: 30, bottom: 30, right: 30))
        distanceView.stretch(width: nil, multiplier: 0, height: heightAnchor, multiplier: 0.2)
    }
    
    // MARK: - Deinit
    deinit { mapView = nil }
    
}
