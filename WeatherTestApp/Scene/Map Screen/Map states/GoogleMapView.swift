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
    private lazy var googleMapView: GMSMapView = {
        let map = GMSMapView()
        map.delegate = self
        return map
    }()
    
    // MARK: - Init
    init(lat: Double, lon: Double) {
        super.init(frame: .zero)
        addMark(lat: lat, lon: lon)
        addMark(lat: lat + 1, lon: lon + 1)
        addDirections(from: .init(latitude: lat, longitude: lon),
                      to: .init(latitude: lat + 1, longitude: lon + 1))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Configure
    func setPosition(lat: Double, lon: Double) {
        googleMapView.camera = GMSCameraPosition.camera(withTarget: .init(latitude: lat, longitude: lon), zoom: 15)
    }
    
    func addMark(lat: Double, lon: Double) {
        let mark = GMSMarker(position: .init(latitude: lat, longitude: lon))
        mark.map = googleMapView
    }
    
    func addDirections(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let path = GMSMutablePath()
        path.add(source)
        path.add(destination)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 10
        polyline.strokeColor = .red
        polyline.map = googleMapView
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(googleMapView)
        googleMapView.fillSuperview(padding: .zero)
    }
    
}

// MARK: - Delegate
extension GoogleMapView: GMSMapViewDelegate {
    
}
