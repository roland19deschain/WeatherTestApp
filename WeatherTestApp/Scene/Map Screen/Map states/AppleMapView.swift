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
    private let source: CustomMark
    private var destination: CustomMark!
    
    // MARK: - View
    private lazy var appleView: MKMapView! = {
        let map = MKMapView()
        map.delegate = self
        map.showsUserLocation = true
        map.register(CustomMark.self, forAnnotationViewWithReuseIdentifier: CustomMark.identifier)
        return map
    }()
    
    // MARK: - Init
    init(lat: Double, lon: Double) {
        source = CustomMark(coordinate: .init(latitude: lat, longitude: lon))
        super.init(frame: .zero)
        setPosition(lat: lat, lon: lon)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Configure
    func setPosition(lat: Double, lon: Double) {
        let region = MKCoordinateRegion(center: .init(latitude: lat, longitude: lon),
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        appleView.setRegion(region, animated: true)
        appleView.addAnnotation(source)
    }
    
    func addDirection(from source: MKAnnotation, to destination: MKAnnotation) {
        let request = MKDirections.Request()
        request.source = source.mapItem
        request.destination = destination.mapItem
        request.transportType = .any
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response else { return }
            response.routes.forEach({ self.appleView.addOverlay($0.polyline) })
        }
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(appleView)
        appleView.fillSuperview(padding: .zero)
    }
    
}

// MARK: - Delegate
extension AppleMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 10
        render.strokeColor = .green
        return render
    }
}
