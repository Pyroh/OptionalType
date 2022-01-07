import XCTest
@testable import OptionalType

protocol EquatableSequence: Sequence where Element: Equatable { }

final class OptionalTypeTests: XCTestCase {
    
    func testSequence() {
        func f<T: OptionalType>(_ a: [T]) -> [T.Wrapped] { a.compactMap { $0.wrapped } }
        
        let seq1: [Int?] = [1, 2, nil, 4]
        print(type(of: f(seq1)))
        
        XCTAssert(f(seq1) == [1, 2, 4])
    }
    
    func testLazySequence() {
        func f<T: OptionalType>(_ a: [T]) -> some Sequence { a.lazy.compactMap { $0.wrapped } }
        
        let seq1: [Int?] = [1, 2, nil, 4]
        print(type(of: f(seq1)))
        
        let seq2: [Int] = seq1.lazy.compact()
        
        XCTAssert(seq2 == [1, 2, 4])
    }
    
    func testSo() {
        let a: Int? = 22
        let b: Int? = nil
        
        var c: Int = 20
        
        a.so { c += $0 }
        b.so { c += $0 }
        
        XCTAssert(c == 42)
    }
}
