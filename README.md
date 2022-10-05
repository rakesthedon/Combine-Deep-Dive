# Combine "Deep" Dive

## What is it?

The Combine framework provides a declarative Swift API for processing values over time. These values can represent many kinds of asynchronous events. Combine declares publishers to expose values that can change over time, and subscribers to receive those values from the publishers.


Source: [Apple Developer Website](https://developer.apple.com/documentation/combine)

## Requirements

- iOS/iPadOS 13.0+
- macOS 10.15+

## How does it work

There is essentialy three actors involved in using Combine:

### 1.The `Publisher`

Responsible for the delivery of a sequence of values over time.

### 2.The `Subscriber`

The receiver of the values sent by the `Publisher`

### 3.The `Operators`

Collection of method that let you modify and handle values emited by a `Publisher` before the subscriber received them.

## Exemple in the project

### Single image loading:

Downloading an image using `URLSession.DataPublisher` and displaying it in a SwiftUI Image View

### Email and password validation

Form validation for email and password with use of `debounce` and `Publishers.CombineLatest`.

### ImageGrid loading:

Loading a given number of random images from [unsplash](https://www.unsplash.com) 
