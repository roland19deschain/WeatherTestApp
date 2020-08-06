//
//  AppleMapView.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import MapKit

final class AppleMapView: UIView, MapStateProtocol {
    private lazy var appleView: MKMapView! = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    // MARK: - Init
    init(lat: Double, lon: Double) {
        super.init(frame: .zero)
        setPosition(lat: lat, lon: lon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func setPosition(lat: Double, lon: Double) {
        let region = MKCoordinateRegion(center: .init(latitude: lat, longitude: lon),
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        appleView.setRegion(region, animated: true)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(appleView)
        appleView.fillSuperview(padding: .zero)
    }
    
}
