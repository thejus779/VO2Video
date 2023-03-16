//
//  WeakObserverOrderedSet.swift
//  VO2Video
//
//  Created by Thejus on 16/03/2023.
//

import Foundation

struct WeakObserverOrderedSet<T> {
    
    struct WeakObserver {
        weak var value: AnyObject?
        init(_ value: AnyObject) {
            self.value = value
        }
    }
    
    var observers: [WeakObserver] = []
    
    private func indexOf(value: AnyObject) -> Int? {
        for (idx, val) in observers.enumerated() where val.value === value {
            return idx
        }
        return nil
    }
    
    @discardableResult
    mutating func add(value: T) -> Bool {
        let anyValue = value as AnyObject
        guard indexOf(value: anyValue) == nil else { return false }
        observers.append(WeakObserver(anyValue))
        return true
    }
    
    mutating func remove(value: T) {
        let anyValue = value as AnyObject
        guard let i = indexOf(value: anyValue) else { return }
        observers.remove(at: i)
    }
    
    func invoke(_ function: ((T) -> Void)) {
        for observer in observers {
            if let oValue = observer.value as? T {
                function(oValue)
            }
        }
    }
}
