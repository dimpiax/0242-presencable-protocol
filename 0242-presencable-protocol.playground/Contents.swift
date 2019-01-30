/*:
 ## Proposal for Swift Evolution
 # Presencable Protocol
 [0242-presencable-protocol](https://github.com/dimpiax/swift-evolution/blob/master/proposals/0242-presencable-protocol.md)
 */
import UIKit

protocol Emptiable {
    var isEmpty: Bool { get }
}

protocol Presencable: Emptiable {
    var presence: Self? { get }
}

extension Presencable {
    var presence: Self? {
        return isEmpty ? nil : self
    }
}

// example with Array and ArraySlice types only
extension Array: Presencable {
}

extension ArraySlice: Presencable {
}

let arr = [1, 3]
arr.dropFirst(2).presence // nil
arr.presence // Optional([1, 3])
arr.presence?.first! // strictly exist

// custom type
struct Foo: Presencable {
    let collection: Set<Int>

    var isEmpty: Bool { return collection.isEmpty }

    init(_ values: Int...) {
        collection = Set(values)
    }
}

Foo(1, 2, 3).presence // Optional(Foo)
Foo().presence // nil
