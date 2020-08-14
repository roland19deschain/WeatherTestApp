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
    
}

struct Direction: Codable {
    let routes: [Route]
}

// MARK: - Route
struct Route: Codable {
    let overviewPolyline: OverviewPolyline

    enum CodingKeys: String, CodingKey {
        case overviewPolyline = "overview_polyline"
    }
}

// MARK: - OverviewPolyline
struct OverviewPolyline: Codable {
    let points: String
}
