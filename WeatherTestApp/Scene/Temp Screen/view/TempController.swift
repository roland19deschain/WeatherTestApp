//
//  TempController.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TempController: UIViewController {
    var tempLoader: TempLoaderProtocol!
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = TempView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    
    // MARK: - Load data
    private func loadData() {
        let view = self.view as! TempView
        tempLoader.loadTemp(city: navigationItem.title ?? "",
                            successHandle: { (response) in
                                view.setLabelText(temp: response.temp, description: response.description)
                                view.mapAction = { (map) in self.tempLoader.pushToMap(mapData: .init(type: map,
                                                                                                     lat: response.coordinates.lat,
                                                                                                     lon: response.coordinates.lon)) }
                            },
                            errorHandle: { (error) in
                                Alert.error(self, message: error.localizedDescription)
                                self.navigationController?.popViewController(animated: true)
                            })
    }

}
