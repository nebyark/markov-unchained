//
//  ViewController.swift
//  MarkovUnchained
//
//  Created by Ben Kray on 6/11/19.
//

import UIKit
import MarkovUnchained

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let corpus = readFile()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        let chain = MarkovChain<String>()
        chain.build(from: corpus) {
            let initialState = "The"
            let states = chain.nextStates(100, for: initialState, using: .mixed)
            var text = [initialState]
            text.append(contentsOf: states)
            print(text.joined(separator: " "))
        }
    }

    private func readFile() -> [String] {
        guard let path = Bundle.main.path(forResource: "corpus", ofType: "txt") else {
            return []
        }

        do {
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            let filtered = contents.replacingOccurrences(of: "\n", with: " ")
            return filtered.split(separator: " ").map { String($0) }
        } catch {
            return []
        }
    }

}
