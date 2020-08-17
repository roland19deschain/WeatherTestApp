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
        configureGesture()
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
            response.routes.forEach({
                self.appleView.addOverlay($0.polyline)
                
            })
        }
    }
    
    func addLine(from source: MKAnnotation, to destination: MKAnnotation) {
        let points = [
            MKMapPoint(source.coordinate),
            MKMapPoint(destination.coordinate)
        ]
        let geodesic = MKGeodesicPolyline(points: points, count: points.count)
        appleView.addOverlay(geodesic)
    }
    
    // MARK: - Tap gesture
    private func configureGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
        appleView.addGestureRecognizer(gesture)
    }
    
    @objc private func tapHandle(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            if appleView.annotations.count > 1 {
                appleView.removeAnnotation(destination)
                appleView.removeOverlays(appleView.overlays)
            }
            let point = recognizer.location(in: appleView)
            let coordinate = appleView.convert(point, toCoordinateFrom: appleView)
            destination = CustomMark(coordinate: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
            appleView.addAnnotation(destination)
            addDirection(from: source, to: destination)
            addLine(from: source, to: destination)
        default: break
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
        render.strokeColor = (overlay is MKGeodesicPolyline) ? .red : .green
        return render
    }
}
