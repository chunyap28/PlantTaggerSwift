//
//  DistionaryExtension.swift
//  Plant Tagger
//
//  Created by Chun Yap on 22/11/17.
//  Copyright © 2017 Chun Yap. All rights reserved.
//
import UIKit

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
