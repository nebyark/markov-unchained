# MarkovUnchained

[![Version](https://img.shields.io/cocoapods/v/MarkovUnchained.svg?style=flat)](https://cocoapods.org/pods/MarkovUnchained)
[![License](https://img.shields.io/cocoapods/l/MarkovUnchained.svg?style=flat)](https://cocoapods.org/pods/MarkovUnchained)
[![Platform](https://img.shields.io/cocoapods/p/MarkovUnchained.svg?style=flat)](https://cocoapods.org/pods/MarkovUnchained)

MarkovUnchained is a simple, generic Swift implementation for working with Markov chains. See http://setosa.io/ev/markov-chains/ for a nice description of Markov chains (with c00l visuals). With MarkovUnchained, you can build a Markov chain with a set of states, and predict the next state for any given existing state.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
The project uses George Orwell's 1984 text as a corpus, and generates 100 words from a given initial word.

## Installation

MarkovUnchained is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MarkovUnchained'
```

## Usage

### Building a Markov chain

The Markov chain can be built with any `Hashable` type. The `.build(from: _)` function and provided callback runs on a background queue.

```swift
let corpus = readSomeTextFile()
let chain = MarkovChain<String>()
chain.build(from: corpus) {
    // on complete
}
```

### Using a Markov chain

Each retrieval of a predicted state can set how the selection should be made via the following enum:
```swift
public enum SelectionType {
    case random // purely random as to which state is chosen
    case weighted // states with higher weights are likely to be chosen
    case mixed // default, either random or weighted is used to choose next state
}
```

##### A single predicted state

```swift
let nextState = chain.nextState(for: "me", selectionType: .random)
```

##### A list of predicted states

```swift
let states = "This is a short sentence but now it's long".split(separator: " ")
let predictedStates = chain.nextStates(for: states, selectionType: .weighted)
```

##### N predicted states

```swift
let predictedStates = chain.nextStates(100, for: "lmao", using: .mixed)
```

## License

MarkovUnchained is available under the MIT license. See the LICENSE file for more info.
