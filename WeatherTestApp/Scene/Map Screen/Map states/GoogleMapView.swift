//
//  GoogleMapView.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import GoogleMaps

final class GoogleMapView: UIView, MapStateProtocol {
    private let googleMapView: GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    // MARK: - Init
    init(lat: Double, lon: Double) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Configure
    func setPosition(lat: Double, lon: Double) {
        googleMapView.camera = GMSCameraPosition.camera(withTarget: .init(latitude: lat, longitude: lon), zoom: 15)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(googleMapView)
        googleMapView.fillSuperview(padding: .zero)
    }
    
}
