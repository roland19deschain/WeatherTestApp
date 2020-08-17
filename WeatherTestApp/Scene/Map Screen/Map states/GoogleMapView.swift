//
//  GoogleMapView.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import GoogleMaps
import RxSwift

final class GoogleMapView: UIView, MapStateProtocol {
    private let source: CLLocationCoordinate2D
    private var destination: GMSMarker?
    
    // MARK: - View
    private lazy var googleMapView: GMSMapView = {
        let map = GMSMapView()
        map.delegate = self
        return map
    }()
    
    // MARK: - Init
    init(lat: Double, lon: Double) {
        source = .init(latitude: lat, longitude: lon)
        super.init(frame: .zero)
        setPosition(lat: lat, lon: lon)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Configure
    func setPosition(lat: Double, lon: Double) {
        let coordinate = CLLocationCoordinate2D.init(latitude: lat, longitude: lon)
        googleMapView.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        addMark(coordinate: coordinate)
    }
    
    func addMark(coordinate: CLLocationCoordinate2D) {
        destination = GMSMarker(position: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
        destination?.map = googleMapView
    }
    
    func addDirections(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        APIService.shared.rxResponse(by: Constants.directionsApi,
                                     parameters: [
                                        "origin": "\(source.latitude),\(source.longitude)",
                                        "destination": "\(source.latitude),\(source.longitude)",
                                        "key": Constants.googleApiKey
                                        ])
        { (observable: Observable<Direction>?, error) in
            observable?
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { direction in
                    direction.routes.forEach({
                        let path = GMSPath(fromEncodedPath: $0.overviewPolyline.points)
                        let polyline = GMSPolyline(path: path)
                        polyline.strokeWidth = 10
                        polyline.strokeColor = .red
                        polyline.map = self.googleMapView
                    })
                }, onError: nil, onCompleted: nil, onDisposed: nil)
                .disposed(by: DisposeBag())
        }
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
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        destination?.map = nil
        addMark(coordinate: coordinate)
        addDirections(from: source, to: coordinate)
    }
    
}
