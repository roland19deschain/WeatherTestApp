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
            self.tempController = TempController()
            city.bind(to: self.tempController.navigationItem.rx.title).disposed(by: DisposeBag())
            self.navigationController?.pushViewController(self.tempController, animated: true)
        }
    }

}

