//
//  MVVMViewController.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

protocol MVVMViewController: class {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
}

