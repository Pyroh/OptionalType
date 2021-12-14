//
//  OptionalType.swift
//
//  OptionalType
//
//  MIT License
//
//  Copyright (c) 2021 Pierre Tacchi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

public protocol OptionalType: ExpressibleByNilLiteral {
    associatedtype Wrapped
    
    
    var wrapped: Wrapped? { get }
    var isNil: Bool { get }
    mutating func wrap(_ wrapping: Wrapped)
    static func wrap(_ wrapping: Wrapped) -> Self
}

extension Optional: OptionalType {
    @inlinable public var wrapped: Wrapped? { self }
    
    @inlinable public var isNil: Bool { self == nil }
    
    @inlinable public mutating func wrap(_ wrapping: Wrapped) { self = Self(wrapping) }
    
    @inlinable public static func wrap(_ wrapping: Wrapped) -> Optional<Wrapped> { Self(wrapping) }
}

public extension OptionalType {
    @inlinable static func ??(_ lhs: Self,
                              _ rhs: @autoclosure () throws -> Self.Wrapped) rethrows -> Self.Wrapped {
        guard let lhs = lhs.wrapped else { return try rhs() }
        return lhs
    }
    
    @inlinable static func ??(_ lhs: Self,
                              _ rhs: @autoclosure () throws -> Self.Wrapped?) rethrows -> Self.Wrapped? {
        guard let lhs = lhs.wrapped else { return try rhs() }
        return lhs
    }
    
    @inlinable static func ??(_ lhs: Self,
                              _ rhs: @autoclosure () throws -> Self) rethrows -> Self {
        guard !lhs.isNil else { return try rhs() }
        return lhs
    }
}
