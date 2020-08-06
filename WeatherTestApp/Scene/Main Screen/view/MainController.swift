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
    private var tempController: TempController!
    var main: Main!

    override func loadView() {
        super.loadView()
        view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    func configureUI() {
        let view = self.view as! MainView
        view.showWeather = { city in
            self.main.push { (navItem) in city.bind(to: navItem.rx.title).disposed(by: DisposeBag()) }
        }
    }

}

