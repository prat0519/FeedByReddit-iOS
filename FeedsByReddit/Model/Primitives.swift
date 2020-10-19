//
//  Primitives.swift
//  FeedsByReddit
//
//  Created by Pandey, Prashant A (CORP) on 10/19/20.
//

import Foundation

enum Alphabet {
    static let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
    static let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let space = " "
    static let numbers = "0123456789"

    static let defaultAlphabet = lowercaseLetters + uppercaseLetters + numbers + space
}

func randomInt(max: UInt32 = UInt32.max) -> Int {
    return Int(arc4random_uniform(max))
}

func randomDouble() -> Double {
    return (Double(arc4random()) / Double(UInt32.max)) * Double(randomInt())
}

func randomBool() -> Bool {
    return randomInt(max: 2) == 1
}

func randomDate() -> Date {
    return Date()
}

func randomString(maxLength: UInt32, alphabet: String = Alphabet.defaultAlphabet) -> String {
    let len = UInt32(alphabet.count)

    var randomString = ""

    for _ in 0 ..< randomInt(max: maxLength) {
        let index = alphabet.index(alphabet.startIndex, offsetBy: randomInt(max: len))
        randomString.append(alphabet[index])
    }

    return randomString
}

func randomOptionalString(maxLength: UInt32) -> String? {
    return randomBool() ? randomString(maxLength: maxLength) : nil
}

func randomOptionalInt(max: UInt32 = UInt32.max) -> Int? {
    return randomBool() ? randomInt() : nil
}
