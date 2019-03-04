//
//  EnumCenter.swift
//  Desafio Beblue_LucasCordeiro
//
//  Created by Lucas Cordeiro on 03/03/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

enum RoverPhotosFilter: String {
    case curiosity
    case opportunity
    case spirit

    func stringValue() -> String {
        return rawValue
    }
}
