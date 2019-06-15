//
//  MarkovState.swift
//  MarkovUnchained
//
//  Created by Ben Kray on 6/15/19.
//

import Foundation

public class MarkovState<T: Hashable> {

    private(set) var states = [T: Int]()

    public init() { }

    public func add(state: T) {
        if let count = states[state] {
            states[state] = count + 1
        } else {
            states[state] = 1
        }
    }

    public func random() -> T? {
        return states.randomElement()?.key
    }

    public func weightedRandom() -> T? {
        let sum = states.values.reduce(0, +)
        var random = Int.random(in: 1...sum)
        for (_, weight) in states.values.enumerated() {
            random -= weight
            if random <= 0 {
                return states.filter { weight == $0.value }.first?.key
            }
        }
        return nil
    }

}
