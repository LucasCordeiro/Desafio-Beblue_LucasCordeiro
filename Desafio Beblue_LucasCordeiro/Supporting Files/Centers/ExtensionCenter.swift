//
//  ExtensionCenter.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation
import UIKit
import Lottie

extension Date {

    static func date(fromString: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: fromString)
    }
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }

    static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }

    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }

    func stringWithFormat(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.string(from: self)
    }
}

extension UIView {

    /// Get UIView's class name
    ///
    /// - Returns: UIView's class name
    static func classNameDescription() -> String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static func register(inCollection collection: UICollectionView) {
        let cellClasName = self.classNameDescription()
        let nib = UINib(nibName: cellClasName, bundle: nil)

        collection.register(nib, forCellWithReuseIdentifier: cellClasName)
    }
}

extension UITableViewCell {
    static func register(inTable table: UITableView) {
        let cellClasName = self.classNameDescription()
        let nib = UINib(nibName: cellClasName, bundle: nil)

        table.register(nib, forCellReuseIdentifier: cellClasName)
    }
}

extension UIViewController {

    /// Get ViewController's class name
    ///
    /// - Returns: ViewController's class name
    static func classNameDescription() -> String {
        return String(describing: self)
    }
}

extension LOTAnimationView {
    func showAndPlay(loopAnimation: Bool) {

        self.loopAnimation = loopAnimation
        self.play()
        self.loopAnimation = loopAnimation
        self.play()
        self.isHidden = false
        self.superview?.isHidden = false
        self.alpha = 0.0
        self.superview?.alpha = 0.0

        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
            self.superview?.alpha = 0.35
        }
    }

    func hideAndStop() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
            self.superview?.alpha = 0.0
        }, completion: { (_) in
            self.stop()
            self.superview?.isHidden = true
            self.isHidden = true
        })
    }
}
