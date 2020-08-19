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
    var tempHandler: TempHandlerProtocol!
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = TempView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    // MARK: - Load data
    private func handleData() {
        let view = self.view as! TempView
        navigationItem.title = tempHandler.title
        view.setLabelText(temp: tempHandler.temp, description: tempHandler.description)
        view.mapAction = { (map) in self.tempHandler.pushToMap(mapData: .init(city: self.tempHandler.title,
                                                                              type: map,
                                                                             lat: self.tempHandler.lat,
                                                                             lon: self.tempHandler.lon)) }
    }

}
