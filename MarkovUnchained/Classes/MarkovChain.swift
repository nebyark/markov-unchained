//
//  MarkovChain.swift
//  MarkovUnchained
//
//  Created by Ben Kray on 6/12/19.
//

import Foundation

public class MarkovChain<T: Hashable> {

    public enum SelectionType {
        case random
        case weighted
        case mixed
    }

    public private(set) var matrix = [T: MarkovState<T>]()

    public init() { }

    public func build(from states: [T], completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            states.enumerated().forEach { index, state in
                var link = MarkovState<T>()
                if let existing = self.matrix[state] {
                    link = existing
                }
                if states.indices.contains(index + 1) {
                    link.add(state: states[index + 1])
                    self.add(link, for: state)
                }
            }
            completion?()
        }
    }

    public func add(_ link: MarkovState<T>, for state: T) {
        matrix[state] = link
    }

    public func nextState(for state: T, using selectionType: SelectionType = .mixed) -> T? {
        switch selectionType {
        case .random:
            return matrix[state]?.random()
        case .weighted:
            return matrix[state]?.weightedRandom()
        case .mixed:
            if Bool.random() {
                return matrix[state]?.random()
            } else {
                return matrix[state]?.weightedRandom()
            }
        }
    }

    public func nextStates(for states: [T], using selectionType: SelectionType = .mixed) -> [T] {
        switch selectionType {
        case .random:
            return states.compactMap { matrix[$0]?.random() }
        case .weighted:
            return states.compactMap { matrix[$0]?.weightedRandom() }
        case .mixed:
            if Bool.random() {
                return states.compactMap { matrix[$0]?.random() }
            } else {
                return states.compactMap { matrix[$0]?.weightedRandom() }
            }
        }
    }

    public func nextStates(_ n: Int = 1, for state: T, using selectionType: SelectionType = .mixed) -> [T] {
        var result = [T]()
        var current = state
        let appendState: (T) -> Void = { state in
            result.append(state)
            current = state
        }
        for _ in 0...n {
            if selectionType == .random {
                if let nextState = matrix[current]?.random() {
                    appendState(nextState)
                }
            } else if selectionType == .weighted {
                if let nextState = matrix[current]?.weightedRandom() {
                    appendState(nextState)
                }
            } else if selectionType == .mixed {
                if Bool.random(),
                    let nextState = matrix[current]?.random() {
                    appendState(nextState)
                } else if let nextState = matrix[current]?.weightedRandom() {
                    appendState(nextState)
                }
            }
        }
        return result
    }

}
