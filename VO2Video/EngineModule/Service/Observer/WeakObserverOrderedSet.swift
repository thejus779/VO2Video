//
//  WeakObserverOrderedSet.swift
//  VO2Video
//
//  Created by Shiny on 16/03/2023.
//

import Foundation

struct WeakObserverOrderedSet<T> {
    
    struct Weak {
        weak var value: AnyObject?
        init(_ value: AnyObject) {
            self.value = value
        }
    }
    
    var elements: [Weak] = []
    
    private func indexOf(value: AnyObject) -> Int? {
        for (idx, val) in elements.enumerated() where val.value === value {
            return idx
        }
        return nil
    }
    
    @discardableResult
    mutating func add(value: T) -> Bool {
        let anyValue = value as AnyObject
        guard indexOf(value: anyValue) == nil else { return false }
        elements.append(Weak(anyValue))
        return true
    }
    
    mutating func remove(value: T) {
        let anyValue = value as AnyObject
        guard let i = indexOf(value: anyValue) else { return }
        elements.remove(at: i)
    }
    
    func invoke(_ function: ((T) -> Void)) {
        for elem in elements {
            if let eVal = elem.value as? T {
                function(eVal)
            }
        }
    }
}
