//
//  LocationService.swift
//  WeatherTestApp
//
//  Created by User on 8/21/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    // MARK: - Nested type
    enum LocationError: String, Error {
        case servicesDisabled = "Services disabled"
        case denied, restricted
        case locality = "Can't get you're locality"
    }
    
    // MARK: - Stored properties
    private var manager: CLLocationManager!
    private var geocoder: CLGeocoder!
    var result: ((Result<String, LocationError>) -> Void)?
    
    // MARK: - Singleton
    static let shared = LocationService()
    private override init() { super.init() }
    
    // MARK: - Configure
    func setup() {
        if CLLocationManager.locationServicesEnabled() {
            createManager()
            return
        }
        result?(.failure(.servicesDisabled))
    }
    
    private func createManager() {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = .greatestFiniteMagnitude
        manager.requestWhenInUseAuthorization()
    }
    
    private func getLocality(from location: CLLocation) {
        geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first else {
                self.result?(.failure(.locality))
                return
            }
            let city = placemark.locality ?? ""
            self.result?(.success(city))
        }
    }
    
}

// MARK: - Delegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        getLocality(from: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse: manager.startUpdatingLocation()
        case .denied: result?(.failure(.denied))
        case .restricted: result?(.failure(.restricted))
        default: break
        }
    }
}
