//
//  MainController.swift
//  WeatherTestApp
//
//  Created by User on 8/5/20.
//  Copyright © 2020 vironIT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MainController: UIViewController {
    var main: MainProcessorProtocol!

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Configure
    private func configureUI() {
        let view = self.view as! MainView
        view.showWeather = { city in
            self.main.push { (navItem) in city.bind(to: navItem.rx.title).disposed(by: DisposeBag()) }
        }
    }

}

