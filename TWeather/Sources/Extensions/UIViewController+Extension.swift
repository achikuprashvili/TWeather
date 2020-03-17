//
//  UIViewController+Extension.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

extension UIViewController {
    class func instantiateFromStoryboard(storyboardName: String, storyboardId: String) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName, storyboardId: storyboardId)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    func handleStatusMessage(_ message: StatusMessage, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: message.title, message: message.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        switch message {
        case .retry(_, let retry):
            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                retry()
                if let handler = handler {
                    handler()
                }
            }))
        default:
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                if let handler = handler {
                    handler()
                }
            }))
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivitiIndicator(value: Bool) {
        switch value {
        case true:
            if view.viewWithTag(Constants.activityIndicatorTag) != nil {
                break
            } else {
                let activityIndicator = MDCActivityIndicator()
                activityIndicator.tag = Constants.activityIndicatorTag
//                activityIndicator.cycleColors = [UIColor.AppColor.black]
                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(activityIndicator)
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                activityIndicator.startAnimating()
            }
        case false:
            guard let activityIndicator: MDCActivityIndicator = view.viewWithTag(Constants.activityIndicatorTag) as? MDCActivityIndicator else {
                return
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func setupNavigationBar(title: String, hidden: Bool = false) {
        navigationController?.setNavigationBarHidden(hidden, animated: true)
        let navigationTitleView = NavigationTitleView(title: title)
        navigationItem.titleView = navigationTitleView
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.green
        
    }
}

extension UIView {
    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
