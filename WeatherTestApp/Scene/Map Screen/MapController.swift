//
//  MapController.swift
//  WeatherTestApp
//
//  Created by User on 8/6/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit

final class MapController: UIViewController {
    private var mapView: UIView!
    var type: Map! {
        didSet { mapView = MapView(type: type, lat: 51.5266, lon: -0.0798) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.fillSuperview(padding: .zero)
    }
    
}
