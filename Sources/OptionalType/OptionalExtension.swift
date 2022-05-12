//
//  OptionalExtension.swift
//
//  OptionalType
//
//  MIT License
//
//  Copyright (c) 2022 Pierre Tacchi
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

public extension Optional {
    
    /// Evaluates the given closure when this Optional instance is not nil, passing the unwrapped value as a parameter.
    ///
    /// Like `map` but expected to return `Void`.
    ///
    /// - Parameter action: A closure that takes the unwrapped value of the instance.
    @inlinable func so(_ action: (Wrapped) throws -> ()) rethrows {
        switch self {
        case .none: return
        case .some(let wrapped): try action(wrapped)
        }
    }
    
    @inlinable func `as`<T>(_ type: T.Type) -> T? { self as? T }
}

extension Optional: OptionalType {
    @inlinable public var wrapped: Wrapped? { self }
    
    @inlinable public var isNil: Bool { self == nil }
    
    @inlinable public mutating func wrap(_ wrapping: Wrapped) { self = Self(wrapping) }
    
    @inlinable public static func wrap(_ wrapping: Wrapped) -> Optional<Wrapped> { Self(wrapping) }
}
