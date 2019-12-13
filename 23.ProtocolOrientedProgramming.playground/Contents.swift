// ========== 프로토콜 지향 프로그래밍(Protocol Oriented Programming) ==========
// 스위프트는 프로토콜 지향 언어(Protocol-Oriented Language)입니다.
// Objective-C 등 객체지향 프로그래밍 패러다임에 기반을 둔 언어는 대부분 클래스의 상속을 사용해 타입에 공통된 기능을 구현합니다.
// 스위프트의 표준 라이브러리에서 타입과 관련된 것을 살펴보면 대부분이 구조체로 구현되어 있습니다. 클래스로 구현된 타입은 별로 없고, 대부분 구조체로 기본 타입이 구현되어 있습니다.

// ========== 프로토콜 초기구현 ==========
// 익스텐션은 기존 타입의 기능을 확장하며, 프로토콜은 프로토콜을 채택한 타입이 원하는 기능을 강제로 구현한다는 점을 우리는 알고 있습니다.
// 그런데 특정 프로토콜을 정의하고 여러 타입에서 이 프로토콜을 준수하게 만들어 타입마다 똑같은 메서드, 프로퍼티, 서브스크립트 등을 구현해야 한다면 얼마나 많은 코드를 중복 사용해야 하며,
// 유지보수는 얼마나 힘들어질지 생각만 해도 머리가 아플 겁니다. 이때 필요한게 바로 익스텐션과 프로토콜의 결합입니다.

// 익스텐션을 통한 프로토콜의 실제 구현
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

extension Receiveable {
    // 메시지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("\(self) received \(data) from \(from)")
    }
}

// 무언가를 발신할 수 있는 기능
protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var from: Sendable {
        return self
    }
    
    // 메시지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Message 클래스
class Message: Sendable, Receiveable {
    var to: Receiveable?
}

// 수신, 발신이 가능한 Mail 클래스
class Mail: Sendable, Receiveable {
    var to: Receiveable?
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")      // Message has no receiver

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")      // Message received Hello from Message

// Mail 인스턴스를 두 개 생성합니다.
let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")                 // Mail has no receiver

// Message와 Mail 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있습니다.
myMail.to = yourMail
myMail.send(data: "Hi")                 // Mail received Hi from Mail

myMail.to = myPhoneMessage
myMail.send(data: "Bye")                // Message

// String은 Sendable 프로토콜을 준수하지 않습니다.
Message.isSendableInstance("Hello")     // false

// Message와 Mail은 Sendable 프로토콜을 준수합니다.
Message.isSendableInstance(myPhoneMessage)      // true

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태입니다.
Message.isSendableInstance(yourPhoneMessage)    // false
Mail.isSendableInstance(myPhoneMessage)         // true
Mail.isSendableInstance(myMail)                 // true
// Message와 Mail 클래스는 Receiveable과 Sendable 프로토콜을 채택하고 있지만, 실제로 구현한 것은 저장 인스턴스 프로퍼티인 to뿐입니다.
// 그 외의 기능은 이미 각 프로토콜의 익스텐션에 구현되어 있습니다. 프로토콜을 정의할 때는 그 프로토콜을 채택한 타입에서 구현해주어야 하는 프로토콜의 요구사항을 구현할 수 없습니다.
// 단지 요구사항을 정의만 할 수 있을 뿐입니다. 그러나 프로토콜의 익스텐션에는 프로토콜이 요구하는 기능을 실제로 구현해줄 수 있습니다.
// 다만 익스텐션에는 저장 프로퍼티를 구현할 수 없으므로 저장 프로퍼티는 각각의 타입에서 직접 구현해야 합니다.
// 이처럼 프로토콜의 요구사항을 익스텐션을 통해 구현하는 것을 프로토콜 초기구현(Protocol Default Implementations)이라고 합니다.

// 익스텐션을 통해 구현된 메서드 재정의
class Mail2: Sendable, Receiveable {
    var to: Receiveable?
    
    func send(data: Any) {
        print("Mail2의 send 메서드는 재정의되었습니다.")
    }
}

let mail2Instance: Mail2 = Mail2()
mail2Instance.send(data: "Hello")       // Mail2의 send 메서드는 재정의되었습니다.
// 사실 send(data:) 메서드를 구현한 것은 재정의라고 할 수 없습니다. 이미 프로토콜을 준수하는 타입의 메서드를 호출했기 때문입니다.
// 특정 프로토콜을 준수하는 타입에 프로토콜의 요구사항을 찾아보고 이미 구현되어 있다면 그 기능을 호출하고, 그렇지 않다면 프로토콜 초기구현의 기능을 호출합니다.
// 여기에 제네릭까지 더한다면 코드의 재사용성은 훨씬 더 좋아질 것입니다.

// 제네릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성
protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable where Self: Container {
    func printSelf() {
        print(items)
    }
}

protocol Container: SelfPrintable {
    associatedtype ItemType
    
    var items: [ItemType] { get set }
    var count: Int { get }
    
    mutating func append(item: ItemType)
    subscript(i: Int) -> ItemType { get }
}

extension Container {
    mutating func append(item: ItemType) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

protocol Popable: Container {
    mutating func pop() -> ItemType?
    mutating func push(_ item: ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    
    mutating func push(_ item: ItemType) {
        self.append(item: item)
    }
}

protocol Insertable: Container {
    mutating func delete() -> ItemType?
    mutating func insert(_ item: ItemType)
}

extension Insertable {
    mutating func delete() -> ItemType? {
        return items.removeFirst()
    }
    
    mutating func insert(_ item: ItemType) {
        self.append(item: item)
    }
}

struct Stack<Element>: Popable {
    var items: [Element] = [Element]()
}

struct Queue<Element>: Insertable {
    var items: [Element] = [Element]()
}

var myIntStack: Stack<Int> = Stack<Int>()
var myStringStack: Stack<String> = Stack<String>()
var myIntQueue: Queue<Int> = Queue<Int>()
var myStringQueue: Queue<String> = Queue<String>()

myIntStack.push(3)
myIntStack.printSelf()          // [3]

myIntStack.push(2)
myIntStack.printSelf()          // [3, 2]

myIntStack.pop()                // 2
myIntStack.printSelf()          // [3]

myStringStack.push("A")
myStringStack.printSelf()       // ["A"]

myStringStack.push("B")
myStringStack.printSelf()       // ["A", "B"]

myStringStack.pop()             // "B"
myStringStack.printSelf()       // ["A"]

myIntQueue.insert(3)
myIntQueue.printSelf()          // [3]

myIntQueue.insert(2)
myIntQueue.printSelf()          // [3, 2]

myIntQueue.delete()             // 3
myIntQueue.printSelf()          // [2]

myStringQueue.insert("A")
myStringQueue.printSelf()       // ["A"]

myStringQueue.insert("B")
myStringQueue.printSelf()       // ["A", "B"]

myStringQueue.delete()          // "A"
myStringQueue.printSelf()       // ["B"]
// SelfPrintable 프로토콜을 비롯해 Container, Popable, Insertable 프로토콜, 익스텐션 각각, Stack과 Queue 구조체의 구현으로 이루어져 있습니다.
// Container 프로토콜은 연관 타입을 활용하여 제네릭에 더욱 유연하게 대응할 수 있도록 정의했습니다.
// Stack과 Queue 구조체는 익스텐션을 통한 초기구현으로 프로토콜을 채택했을 뿐인데, 구조체 내부에서는 프로토콜 준수를 위해 추가 구현이 필요없습니다.
// 또, Popable과 Insertable 프로토콜은 Container 프로토콜을 상속받아 추가로 특정 목적을 갖는 컨테이너 타입에 필요한 기능을 요구합니다.
// 그러나 이 프로토콜들도 초기구현을 통해 미리 공통 기능을 구현했기에 실제 프로토콜을 따르는 타입은 추가 구현이 필요 없습니다.

// Stack 구조체와 Queue 구조체는 서로 동작하는 방식은 다르지만, 특정 아이템을 가질 수 있는 컨테이너라는 특성은 공유합니다.
// 따라서 그저 Container 프로토콜을 채택하기만 하면 됩니다. 그러나 세부 요구사항이 조금 다르기 때문에 최종적으로는 Container 프로토콜을 상속 받은 다른 프로토콜을 채택합니다.

// 더불어 각각의 요소 타입은 제네릭을 통해 사용할 때 결정하므로 타입에 대해 매우 유연하게 동작할 수 있습니다.
// 이는 클래스의 상속보다도 훨씬 강력하게 기능의 단위를 공유할 수 있는 방법으로 사용합니다. 스위프트의 클래스는 다중상속을 지원하지 않으므로 부모클래스의 기능으로 부족하다면 자식클래스에서 다시 구현해야 하지만,
// 프로토콜 초기 구현을 한 프로토콜을 채택했다면 상속도 추가 구현도 필요 없습니다. 게다가 상속을 지원하지 않는 값 타입인 구조체와 열거형도 상속을 받지 못한다고 아쉬워할 필요가 없습니다.
// 초기구현을 한 프로토콜만 채택한다면 기능이야 얼마든지 추가할 수 있습니다.

// 이처럼 프로토콜 초기구현을 통해 기능을 구현한다면 프로토콜 채택만으로 타입에 기능을 추가해 사용할 수 있습니다. 이것이 프로토콜 지향 프로그래밍의 핵심 콘셉트 중 하나입니다.

// 스위프트 표준 라이브러리의 Array 정의
/*
public struct Array<Element> : RandomAccessCollection, MutableCollection {
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<[Element]>
    
    public var startIndex: Int { get }
    public var endIndex: Int { get }
    
    public func index(after i: Int) -> Int
    public func formIndex(after i: inout Int)
    public func index(before i: Int) -> Int
    public func formIndex(before i: inout Int)
    public func index(_ i: Int, offsetBy distance: Int) -> Int
    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int?
    
    public func distance(from start: Int, to end: Int) -> Int
    public typealias Indices = CountableRange<Int>
    
    public subscript(index: Int) -> Element
    public subscript(bounds: Range<Int>) -> ArraySlice<Element>
    
    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R
    public mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R
    public mutating func replaceSubrange<C where C: Collection, C.Iterator.Element == _Buffer.Element>(_ subrange: Range<Int>, with newElements: C)
    
    public mutating func popLast() -> Element?
    public func dropLast(_ n: Int) -> ArraySlice<Element>
    public func suffix(_ maxLength: Int) -> ArraySlice<Element>
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    public func dropFirst(_ n: Int) -> ArraySlice<Element>
    public func prefix(_ maxLength: Int) -> ArraySlice<Element>
    // 중략...
    public func reversed() -> ReversedRandomAccessCollection<Array<Element>>
    // 생략...
}
*/
// 익스텐션을 통한 각 프로토콜의 초기구현은 구현코드를 볼 수 없기 때문에 어떻게 구현했는지는 확실히 볼 수 없지만
// Array의 정의만 보더라도 제네릭, 프로토콜을 다양하게 사용한 것을 볼 수 있습니다. 아마도 각 타입별로 공유하는 초기구현은 익스텐션으로 구현했을 것입니다.
// 스위프트 표준 라이브러리를 살펴보면서 어떤 기능을 통해 구현했는지, 어떻게 연관이 되는지 읽어보고, 해석해보고, 상상해보는 것도 언어를 이해하는 데 도움이 됩니다.

// ========== 맵, 필터, 리듀스 직접 구현해보기 ==========
// 맵은 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환하는 함수입니다.
// 필터는 컨테이너 내부의 값을 걸러서 추출해 새로운 컨테이너에 값을 담아 반환하는 함수입니다.
// 리듀스는 컨테이너 내부의 콘텐츠를 하나로 합쳐주는 기능을 실행하는 함수입니다.

// Array 타입의 맵 사용
let items: Array<Int> = [1, 2, 3]

let mappedItems: Array<Int> = items.map{ (item: Int) -> Int in
    return item * 10
}
print(mappedItems)      // [10, 20, 30]

// Stack 구조체의 맵 메서드
extension Stack {
    //// Stack 구조체 구현부
    func map<T>(transform: (Element) -> T) -> Stack<T> {
        var transformedStack: Stack<T> = Stack<T>()
        
        for item in items {
            transformedStack.items.append(transform(item))
        }
        
        return transformedStack
    }
}

//// Stack 구조체 구현부 외부
var myIntStack2: Stack<Int> = Stack<Int>()
myIntStack2.push(1)
myIntStack2.push(5)
myIntStack2.push(2)
myIntStack2.printSelf()      // [1, 5, 2]
var myStrStack2: Stack<String> = myIntStack2.map{ "\($0)" }
myStrStack2.printSelf()      // ["1", "5", "2"]

// Array 타입의 필터 사용
let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
    return item % 2 == 0
}

print(filteredItems)        // [2]

// Stack 구조체의 필터 메서드
extension Stack {
    ////  Stack 구조체 구현부
    func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
        var filteredStack: Stack<ItemType> = Stack<ItemType>()
        
        for item in items {
            if includeElement(item) {
                filteredStack.items.append(item)
            }
        }
        
        return filteredStack
    }
}

////  Stack 구조체 구현부 외부
let filteredStack: Stack<Int> = myIntStack2.filter { (item: Int) -> Bool in
    return item < 5
}

filteredStack.printSelf()       // [1, 2]

// Array 타입의 리듀스 사용
let combinedItems: Int = items.reduce(0) { (result: Int, next: Int) -> Int in
    return result + next
}

print(combinedItems)        // 6

let combinedItemsDoubled: Double = items.reduce(0.0) { (result: Double, next: Int) -> Double in
    return result + Double(next)
}

print(combinedItemsDoubled)     // 6.0

let combinedItemsString: String = items.reduce("") { (result: String, item: Int) -> String in
    return result + "\(next) "
}

print(combinedItemsString)      // "1 2 3 "

// Stack 구조체의 리듀스 메서드
extension Stack {
    //// Stack 구조체 구현부
    func reduce<T>(_ initialResult: T, nextPartialResult: (T, Element) -> T) -> T {
        var result: T = initialResult
        
        for item in items {
            result = nextPartialResult(result, item)
        }
        
        return result
    }
}

////  Stack 구조체 구현부 외부
let combinedInt: Int = myIntStack2.reduce(100) { (result: Int, next: Int) -> Int in
    return result + next
}

print(combinedInt)      // 108

let combinedDouble: Double = myIntStack2.reduce(100.0) { (result: Double, next: Int) -> Double in
    return result + Double(next)
}

print(combinedDouble)   // 108.0

let combinedString: String = myIntStack2.reduce("") { (result: String, next: Int) -> String in
    return result + "\(next) "
}

print(combinedString)       // "1 5 2 "

// ========== 기본 타입 확장 ==========
// 프로토콜 초기구현을 통해 스위프트의 기본 타입을 확장하여 내가 원하는 기능을 공통적으로 추가해볼 수도 있습니다.
// 스위프트 표준 라이브러리에 정의되어 있는 타입은 실제 구현코드를 보고 수정할 수 없기 때문에
// 익스텐션, 프로토콜, 프로토콜의 초기구현을 사용해 기본 타입에 기능을 추가해볼 수 있습니다.

// SelfPrintable 프로토콜의 초기구현과 기본 타입의 확장
protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable { }
extension String: SelfPrintable { }
extension Double: SelfPrintable { }

1024.printSelf()        // 1024
3.14.printSelf()        // 3.14
"hana".printSelf()      // "hana"
// 코드를 수정할 수 없는 스위프트의 기본 타입인 Int, String, Double에 SelfPrintable 프로토콜과 그 프로토콜의 초기구현으로 공통 기능을 간단히 추가해본 것입니다.
// 스위프트 표준 라이브러리 내부의 공통 기능이 이렇게 프로토콜 초기구현을 통해 구현하지 않았을까 상상해볼 수 있습니다.
