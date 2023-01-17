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
    
    func testAs() {
        let a: Any? = Int(23)
        
        XCTAssert(a.as(Int.self) == Int(23))
        
        let seq: [Any?] = [nil, Double(1), Int(4), nil, Float(22)]
        
        XCTAssert(seq.as(Double.self) == [nil, Double(1), nil, nil, nil])
        XCTAssert(seq.compactAs(Double.self) == [Double(1)])
    }
    
    func testLazySequence() {
        func f<T: OptionalType>(_ a: [T]) -> some Sequence { a.lazy.compactMap { $0.wrapped } }
        
        let seq1: [Int?] = [1, 2, nil, 4]
        print(type(of: f(seq1)))
        
        let seq2: [Int] = seq1.lazy.compact()
        
        XCTAssert(seq2 == [1, 2, 4])
    }
    
    func testLazyAs() {
        let seq: [Any?] = [nil, Double(1), Int(4), nil, Float(22)]
        
        print(type(of: seq.lazy.as(Double.self)))
        print(type(of: seq.lazy.compactAs(Double.self)))
        
        XCTAssert(seq.lazy.as(Double.self) == [nil, Double(1), nil, nil, nil])
        XCTAssert(seq.lazy.compactAs(Double.self) == [Double(1)])
    }
    
    func testSo() {
        let a: Int? = 22
        let b: Int? = nil
        
        var c: Int = 20
        
        a.so { c += $0 }
        b.so { c += $0 }
        
        XCTAssert(c == 42)
    }
    
    func testReplaceNil() {
        let a: Int? = 22
        let b: Int? = nil
        
        XCTAssertFalse(a.replaceNil(with: 42) == 42)
        XCTAssertTrue(b.replaceNil(with: 42) == 42)
    }
}
