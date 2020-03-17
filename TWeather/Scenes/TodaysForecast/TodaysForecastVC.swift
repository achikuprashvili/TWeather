//
//  TodaysForecastVC.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodaysForecastVC: UIViewController, MVVMViewController {
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    let horizontalStackView1: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.clipsToBounds = false
        sv.spacing = 0
        
        return sv
    }()
    let horizontalStackView2: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.clipsToBounds = false
        sv.spacing = 0
        
        return sv
    }()
    var viewModel: TodaysForecastVMProtocol!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Today")
        setupObservables()
        viewModel.loadForecast()
    }
    
    func setupObservables() {
        viewModel.statusMessageHandler.subscribe(onNext: { (statusMessage) in
            self.handleStatusMessage(statusMessage)
        }).disposed(by: disposeBag)

        viewModel.screenState.subscribe(onNext: { (screenState) in
            switch screenState {
            case .empty:
                self.showActivitiIndicator(value: false)
            case .loading:
                self.showActivitiIndicator(value: true)
            case .showingForecast:
                self.showActivitiIndicator(value: false)
            }
        }).disposed(by: disposeBag)
        
        viewModel.didGetForecast.subscribe(onNext: { (forecast) in
            self.setupUI(forecast: forecast)
        }).disposed(by: disposeBag)
        
        shareButton.rx.tap.bind { () in
            self.takeScrollviewScreenAndShare()
        }.disposed(by: disposeBag)
    }
    
    func takeScrollviewScreenAndShare() {
        let screenShot = self.view.snapshot

        let imageToShare = [ screenShot ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setupUI(forecast: WeatherFullInfo) {
        guard let weatherDescription = forecast.weather.first else {
            return
        }
        let imageUrl = "\(Constants.WeatherApi.iconBaseUrl)/\(weatherDescription.icon)\(Constants.WeatherApi.iconSuffix)"
        var title = ""
        if let name = forecast.name {
            title.append(name)
        }
        if let country = forecast.sys?.country {
            title = title.isEmpty ? title : "\(title), "
            title.append(country)
        }
        let description = "\(forecast.main.temp) \(weatherDescription.main)"
        let weatherDescriptionVM = WeatherDescriptionVM(imageUrl: imageUrl, title: title, description: description)
        let weatherDescriptionView = WeatherDescriptionView(model: weatherDescriptionVM)
        
        stackView.addArrangedSubview(weatherDescriptionView)
        let humidity = WeatherItemView(weatherItem: .humidity(value: String(forecast.main.humidity)))
        let pressure = WeatherItemView(weatherItem: .pressure(value: String(forecast.main.pressure)))
        let wind = WeatherItemView(weatherItem: .wind(value: String(forecast.wind.speed)))
        let degree = WeatherItemView(weatherItem: .degree(value: compassDirection(for: forecast.wind.degree)))
        var sunsetValue: String = "N/A"
        if let sunsetTimeStamp = forecast.sys?.sunset {
            sunsetValue = Date(timeIntervalSince1970: TimeInterval(sunsetTimeStamp)).hourDateString()
        }

        var sunriseValue: String = "N/A"
        if let sunriseTimeStamp = forecast.sys?.sunset {
            sunriseValue = Date(timeIntervalSince1970: TimeInterval(sunriseTimeStamp)).hourDateString()
        }
        let sunset = WeatherItemView(weatherItem: .sunset(value: sunsetValue))
        let sunrise = WeatherItemView(weatherItem: .sunrise(value: sunriseValue))

        horizontalStackView1.addArrangedSubview(humidity)
        horizontalStackView1.addArrangedSubview(wind)
        horizontalStackView1.addArrangedSubview(degree)
        horizontalStackView2.addArrangedSubview(pressure)
        horizontalStackView2.addArrangedSubview(sunrise)
        horizontalStackView2.addArrangedSubview(sunset)

        stackView.addArrangedSubview(horizontalStackView1)
//        stackView.addArrangedSubview(horizontalStackView2)
        
    }
    
    func compassDirection(for heading: Double) -> String {
        if heading < 0 { return "N/A" }

        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
}
