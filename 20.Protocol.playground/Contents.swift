// ========== 프로토콜(Protocol) ==========
//프로토콜 지향 프로그래밍(Protocol Oriented Programming)

// ========== 프로토콜(Protocol)이란 ==========
// 프로토콜(Protocol)은 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의합니다.
// 구조체, 클래스, 열거형은 프로토콜을 채택(Adopted)해서 특정 기능을 실행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있습니다.
// 어떤 프로토콜의 요구사항을 모두 따르는 타입은 '해당 프로토콜을 준수한다(Conform)'고 표현합니다.
// 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야 합니다. 즉, 프로토콜은 정의하고 제시를 할 뿐이지 스스로 기능을 구현하지는 않습니다.

// ========== 프로토콜(Protocol) 채택 ==========
// 프로토콜은 구조체, 클래스, 열거형의 모양과 비슷하게 정의할 수 있으며 protocol 키워드를 사용합니다.
/*
protocol 프로토콜 이름 {
    프로토콜 정의
}
*/

// 구조체, 클래스, 열거형 등에서 프로토콜을 채택하려면 타입 이름 뒤에 콜론(:)을 붙여준 후 채택할 프로토콜 이름을 쉼표(,)로 구분하여 명시해줍니다.

// 타입의 프로토콜 채택
/*
struct SomeStruct: AProtocol, AnotherProtocol {
    // 구조체 정의
}

class SomeClass: AProtocol, AnotherProtocol {
    // 클래스 정의
}

enum SomeEnum: AProtocol, AnotherProtocol {
    // 열거형 정의
}
*/

// SuperClass를 상속받는 클래스의 프로토콜 채택
/*
class SomeClass: SuperClass, AProtocol, AnotherProtocol {
    // 클래스 정의
}
*/

// SomeClass는 SuperClass를 상속받았으며 동시에 AProtocol과 AnotherProtocol 프로토콜을 채택한 클래스입니다.

// ========== 프로토콜(Protocol) 요구사항 ==========
// 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 기능을 요구합니다. 프로토콜이 자신을 채택한 타입에 요구하는 사항은 프로퍼티나 메서드와 같은 기능들입니다.

// 프로퍼티 요구
// 프로토콜은 자신을 채택한 타입이 어떤 프로퍼티를 구현해야 하는지 요구할 수 있습니다. 그렇지만 프로토콜은 그 프로퍼티의 종류(연산 프로퍼티인지, 저장 프로퍼티인지 등)는 따로 신경쓰지 않습니다.
// 프로토콜을 채택한 타입은 프로토콜이 요구하는 프로퍼티의 이름과 타입만 맞도록 구현해주면 됩니다. 다만 프로퍼티를 읽기 전용으로 할지 혹은 읽고 쓰기가 모두 가능하게 할지는 프로토콜이 정해야 합니다.
// 만약 프로토콜이 읽고 쓰기가 가능한 프로퍼티를 요구한다면 읽기만 가능한 상수 저장 프로퍼티 또는 읽기 전용 연산 프로퍼티를 구현할 수 없습니다.
// 만약 프로토콜이 읽기 가능한 프로퍼티를 요구한다면 타입에 프로퍼티를 구현할 때 상수 저장 프로퍼티나 읽기 전용 연산 프로퍼티를 포함해서 어떤 식으로든 프로퍼티를 구현할 수 있습니다.
// 쓰기만 가능한 프로퍼티는 없으니 타입에 구현해주는 프로퍼티는 무엇이 되어도 상관없습니다.
// 프로토콜의 프로퍼티 요구사항은 항상 var 키워드를 사용한 변수 프로퍼티로 정의합니다. 읽기와 쓰기가 모두 가능한 프로퍼티는 프로퍼티의 정의 뒤에 { get set }이라고 명시하며,
// 읽기 전용 프로퍼티는 프로퍼티의 정의 뒤에 { get }이라고 명시해줍니다.

// 프로퍼티 요구
protocol SomeProtocol {
    var settableProperty: String { get set }
    var notNeedToBeSettableProperty: String { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
    static var anotherTypeProperty: Int { get }
}
// SomeProtocol에 정의된 settableProperty는 읽기와 쓰기 모두를 요구했고, notNeedToBeSettableProperty는 읽기만 가능하다면 어떻게 구현되어도 상관없다는 요구사항입니다.
// 타입 프로퍼티를 요구하려면 static 키워드를 사용합니다. 클래스의 타입 프로퍼티에는 상속 가능한 타입 프로퍼티인 class 타입 프로퍼티와 상속 불가능한 static 타입 프로퍼티가 있습니다만
// 이 두 타입 프로퍼티를 따로 구분하지 않고 모두 static 키워드를 사용하여 타입 프로퍼티를 요구하면 됩니다. AnotherProtocol에 정의된 someProperty와 anotherProperty는 모두 타입 프로퍼티를 요구합니다.

// Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스
protocol Sendable {
    var from: String { get }
    var to: String { get }
}

class Message: Sendable {
    var sender: String
    var from: String {
        return self.sender
    }
    
    var to: String
    
    init(sender: String, receiver: String) {
        self.sender = sender
        self.to = receiver
    }
}

class Mail: Sendable {
    var from: String
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}
// Sendable 프로토콜은 무언가의 전송을 가능하게 하기 위한 프로퍼티인 from과 to를 요구합니다.
// 그래서 Sendable 프로토콜을 채택하여 준수하는 Message와 Mail 클래스는 모두 from과 to 프로퍼티를 갖습니다.
// 다만 Message 클래스의 from 프로퍼티는 읽기 전용 연산 프로퍼티라는 점이 Mail 클래스의 from 프로퍼티와 다를 뿐입니다.
// Sendable 프로토콜에서 요구한 프로퍼티는 읽기 가능한 프로퍼티였지만 실제로 프로토콜을 채택한 클래스에서 구현할 때는 읽고 쓰기가 가능한 프로퍼티로 구현해도 전혀 문제가 없습니다.

// 메서드 요구
// 프로토콜은 특정 인스턴스 메서드나 타입 메서드를 요구할 수도 있습니다. 프로토콜이 요구할 메서드는 프로토콜 정의에서 작성합니다.
// 다만 메서드의 실제 구현부인 중괄호({}) 부분은 제외하고 메서드의 이름, 매개변수, 반환 타입 등만 작성하며 가변 매개변수도 허용합니다.
// 프로토콜의 메서드 요구에서는 매개변수 기본값을 지정할 수 없습니다. 타입 메서드를 요구할 때는 타입 프로퍼티 요구와 마찬가지로 앞에 static 키워드를 명시합니다.
// static 키워드를 사용하여 요구한 타입 메서드를 클래스에서 실제 구현할 때는 static 키워드나 class 키워드 어느 쪽을 사용해도 무방합니다.

// Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스
// 무언가를 수신받을 수 있는 기능
protocol Receiveable2 {
    func received(data: Any, from: Sendable2)
}

// 무언가를 발신할 수 있는 기능
protocol Sendable2 {
    var from: Sendable2 { get }
    var to: Receiveable2? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

// 수신, 발신인 가능한 Message 클래스
class Message2: Sendable2, Receiveable2 {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var from: Sendable2 {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var to: Receiveable2?
    
    // 메시지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable2 = self.to else {
            print("Message has no receiver")
            return
        }
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    
    // 메시지를 수신합니다.
    func received(data: Any, from: Sendable2) {
        print("Message received \(data) from \(from)")
    }
    
    // class 메서드이므로 상속이 가능합니다.
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Mail 클래스
class Mail2: Sendable2, Receiveable2 {
    var from: Sendable2 {
        return self
    }
    
    var to: Receiveable2?
    
    func send(data: Any) {
        guard let receiver: Receiveable2 = self.to else {
            print("Mail has no receiver")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable2) {
        print("Mail received \(data) from \(from)")
    }
    
    // static 메서드이므로 상속이 불가능합니다.
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message2 = Message2()
let yourPhoneMessage: Message2 = Message2()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")      // Message has no receiver

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")      // Message received Hello from Message

// 두 Mail 인스턴스를 생성합니다.
let myMail: Mail2 = Mail2()
let yourMail: Mail2 = Mail2()

myMail.send(data: "Hi")     // Mail has no receiver

// Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있습니다.
myMail.to = yourMail
myMail.send(data: "Hi")     // Mail received Hi from Mail

myMail.to = myPhoneMessage
myMail.send(data: "Bye")    // Message received Bye from Mail

// String은 Sendable2 프로토콜을 준수하지 않습니다.
Message2.isSendableInstance("Hello")            // false

// Mail2와 Message2는 Sendable2 프로토콜을 준수합니다.
Message2.isSendableInstance(myPhoneMessage)     // true

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태입니다.
Message2.isSendableInstance(yourPhoneMessage)   // false
Mail2.isSendableInstance(myPhoneMessage)        // true
Mail2.isSendableInstance(myMail)                // true
// Receiveable2 프로토콜은 수신받을 수 있는 received(data:from:) 메서드를 요구합니다.
// Sendable2 프로토콜은 데이터를 발신할 수 있는 Sendable2 프로토콜 타입의 인스턴스를 할당할 수 있는 from 프로퍼티와 데이터를 수신할 수 있는 Receiveable2 프로토콜 타입의 인스턴스를 할당할 수 있는 to 프로퍼티를 요구합니다.
// 또, 데이터를 발신하는 메서드인 send(data:) 인스턴스 메서드를 요구하며, 전달받은 인스턴스가 발신 가능한 상태인지 확인하는 isSendableInstance(_:) 타입 메서드를 요구합니다.
// Message2와 Mail2 클래스는 Sendable2와 Receiveable2 프로토콜을 준수합니다. 그래서 두 프로토콜에서 요구하는 프로퍼티와 메서드를 모두 구현해야 합니다.
// 두 프로토콜에서 요구한 프로퍼티와 메서드 각각의 이름과 타입은 같지만 실제 클래스에서 구현해줄 때는 조금 다른 동작과 용도로 구현하기도 합니다.
// Mail2와 Message2 클래스의 isSendableInstance(_:) 메서드는 각각 class와 static 타입 메서드로 구현했습니다.
// 프로토콜에서 static 키워드를 통해 타입 메서드를 요구했지만 클래스에서 실제로 구현할 때 class 타입 메서드로 구현할지, static 타입 메서드로 구현할지는 프로토콜을 채택하여 사용하는 클래스의 특성에 따라 골라 사용하면 됩니다.

/*
 [NOTE] 타입으로서의 프로토콜
  프로토콜은 요구만 하고 스스로 기능을 구현하지는 않습니다. 그렇지만 프로토콜은 코드에서 완전한 하나의 타입으로 사용되기에 여러 위치에서 프로토콜을 타입으로 사용할 수 있습니다.
   - 함수, 메서드, 이니셜라이저에서 매개변수 타입이나 반환 타입으로 사용될 수 있습니다.
   - 프로퍼티, 변수, 상수 등의 타입으로 사용될 수 있습니다.
   - 배열, 딕셔너리 등 컨테이너 요소의 타입으로 사용될 수 있습니다.
  또, 프로토콜은 스위프트의 다른 타입들과 마찬가지로 이름을 정할 때 대문자 카멜케이스를 사용합니다.
  즉, Receiveable2와 Sendable2와 같이 이름의 첫 글자를 대문자로 표현합니다.
*/

// 가변 메서드 요구
// 가끔은 메서드가 인스턴스 내부의 값을 변경할 필요가 있습니다. 값 타임(구조체와 열거형)의 인스턴스 메서드에서 자신 내부의 값을 변경하고자 할 때는 메서드의 func 키워드 앞에
// mutating 키워드를 적어 메서드에서 인스턴스 내부의 값을 변경하고자 할 때는 메서드의 func 키워드 앞에 mutating 키워드를 적어 메서드에서 인스턴스 내부의 값을 변경한다는 것을 확실히 해줍니다.
// 프로토콜이 어떤 타입이든 간에 인스턴스 내부의 값을 변경해야 하는 메서드를 요구하려면 프로토콜의 메서드 정의 앞에 mutating 키워드를 명시해야 합니다.
// 참조 타입인 클래스의 메서드 앞에는 mutating 키워드를 명시하지 않아도 인스턴스 내부 값을 바꾸는 데 문제가 없지만,
// 값 타입인 구조체와 열거형의 메서드 앞에는 mutating 키워드를 붙인 가변 메서드 요구(Mutating Method Requirements가 필요합니다.
// 프로토콜에 mutating 키워드를 사용한 메서드 요구가 있다고 하더라도 클래스 구현에서는 mutating 키워드를 써주지 않아도 됩니다.

// Resettable 프로토콜의 가변 메서드 요구
protocol Resettable {
    mutating func reset()
}

class Person: Resettable {
    var name: String?
    var age: Int?
    
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable {
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable {
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}
// Resettable 프로토콜은 reset()이라는 가변 메서드를 요구합니다. Resettable 프로토콜을 채택한 Person 클래스에는 mutating 키워드를 제외하고 reset() 메서드를 구현했고,
// 값 타입인 Point 구조체와 Direction 열거형은 mutating 키워드를 포함하여 구현했습니다.
// 만약 Resettable 프로토콜에서 가변 메서드를 요구하지 않는다면, 값 타입의 인스턴스 내부 값을 변경하는 mutating 메서드는 구현이 불가능합니다.

// 이니셜라이저 요구
// 프로토콜은 프로퍼티, 메서드 등과 마찬가지로 특정한 이니셜라이저를 요구할 수도 있습니다.
// 프로토콜에서 이니셜라이저를 요구하려면 메서드 요구와 마찬가지로 이니셜라이저를 정의하지만 구현은 하지 않습니다.
// 즉, 이니셜라이저의 매개변수를 지정하기만 할 뿐, 중괄호를 포함한 이니셜라이저 구현은 하지 않습니다.

// 프로토콜의 이니셜라이저 요구와 구조체의 이니셜라이저 요구 구현
protocol Named {
    var name: String { get }
    
    init(name: String)
}

struct Pet: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 클래스의 이니셜라이저 요구 구현
class Person2: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}
// 클래스 타입에서 프로토콜의 이니셜라이저 요구에 부합하는 이니셜라이저를 구현할 대는 이니셜라이저가 지정 이니셜라이저인지 편의 이니셜라이저인지는 중요하지 않습니다.
// 그러나 이니셜라이저 요구에 부합하는 이니셜라이저를 구현할 때는 required 식별자를 붙인 요구 이니셜라이저로 구현해야 합니다.
// Person2 클래스를 상속받는 모든 클래스는 Named2 프로토콜을 준수해야 하며, 이는 곧 상속받는 클래스에 해당 이니셜라이저를 모두 구현해야 한다는 뜻입니다.
// 그렇기 때문에 Named2에서 요구하는 init(name:) 이니셜라이저를 required 식별자를 붙인 요청 이니셜라이저로 구현해야 합니다.
// 만약에 클래스 자체가 상속받을 수 없는 final 클래스라면 required 식별자를 붙여줄 필요가 없습니다. 상속할 수 없는 클래스의 요청 이니셜라이저 구현은 무의미하기 때문입니다.

// 상속 불가능한 클래스의 이니셜라이저 요구 구현
final class Person3: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

// 만약 특정 클래스에 프로토콜이 요구하는 이니셜라이저가 이미 구현되어 있는 상황에서 그 클래스를 상속받은 클래스가 있다면,
// required와 override 식별자를 모두 명시하여 프로토콜에서 요구하는 이니셜라이저를 구현해주어야 합니다.

// 상속받은 클래스의 이니셜라이저 요구 구현 및 재정의
class School {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override init(name: String) {
        super.init(name: name)
    }
}
// School 클래스는 Named 프로토콜을 채택하지 않았지만 Named 프로토콜이 요구하는 이니셜라이저가 이미 있는 상태입니다.
// 그런데 MiddleSchool 클래스는 School 클래스를 상속받았으며, Named 프로토콜을 채택했습니다.
// 그래서 School 클래스에서 상속받은 init(name:) 이니셜라이저를 재정의해야 하며 동시에 Named 프로토콜의 이니셜라이저 요구도 충족시켜주어야 합니다.
// 그래서 override와 required 식별자를 모두 표기해야 합니다.
// 두 식별자 중 어떤 것이 먼저 위치해도 상관 없습니다. 즉, override required로 표기해도 무방합니다.
// 프로토콜은 일반 이니셜라이저 외에도 실패 가능한 이니셜라이저를 요구할 수도 있습니다. 실패 가능한 이니셜라이저를 요구하는 프로토콜을 준수하는 타입은
// 해당 이니셜라이저를 구현할 때 실패 가능한 이니셜라이저로 구현해도, 일반적인 이니셜라이저로 구현해도 무방합니다.

// 실패 가능한 이니셜라이저 요구를 포함하는 Named2 프로토콜과 Named2 프로토콜을 준수하는 다양한 타입들
protocol Named2 {
    var name: String { get }
    
    init?(name: String)
}

struct Animal2: Named2 {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct Pet2: Named2 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person4: Named2 {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class School2: Named2 {
    var name: String
    
    required init?(name: String) {
        self.name = name
    }
}

// ========== 프로토콜의 상속과 클래스 전용 프로토콜 ==========
// 프로토콜은 하나 이상의 프로토콜을 상속받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있습니다.
// 프로토콜 상속 문법은 클래스의 상속 문법과 유사합니다.

// 프로토콜의 상속
protocol Readable {
    func read()
}

protocol Writeable{
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func write() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}
// ReadSpeakable 프로토콜은 Readable 프로토콜을, ReadWriteSpeakable 프로토콜은 Readable과 Writeable 프로토콜을 상속받았습니다.
// 그래서 ReadWriteSpeakable 프로토콜을 채택한 SomeClass는 세 프로토콜이 요구하는 read(), write(), speak() 메서드를 모두 구현해야 합니다.

// 프로토콜의 상속 리스트에 class 키워드를 추가해 프로토콜이 클래스 타입에만 채택될 수 있도록 제한할 수도 있습니다.
// 클래스 전용 프로토콜로 제한을 주기 위해서는 프로토콜의 상속 리스트의 맨 처음에 class키워드가 위치해야 합니다.

// 클래스 전용 프로토콜의 정의
protocol ClassOnlyProtocol: class, Readable, Writeable {
    // 추가 요구사항
}

class SomeClass2: ClassOnlyProtocol {
    func read() { }
    func write() { }
}

// 오류!! ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능합니다.
/*
struct SomeStruct: ClassOnlyProtocol {
    func read() { }
    func write() { }
}
*/

// ========== 프로토콜 조합과 프로토콜 준수 확인 ==========
// 하나의 매개변수가 여러 프로토콜을 모두 준수하는 타입이어야 한다면 하나의 매개변수에 여러 프로토콜을 한 번에 조합(Composition)하여 요구할 수 있습니다.
// 프로토콜을 조합하여 요구할 때는 SomeProtocol & AnotherProtocol과 같이 표현합니다. 또, 하나의 매개변수가 프로토콜을 둘 이상 요구할 수도 있습니다.
// 이때도 마찬가지로 앰퍼샌드(&)를 여러 프로토콜 이름 사이에 써주면 됩니다.

// 더불어 특정 클래스의 인스턴스 역할을 할 수 있는지 함께 확인할 수 있습니다. 구조체나 열거형 타입은 조합할 수 없습니다. 그리고 조합 중 클래스 타입은 한 타입만 조합할 수 있습니다.

// 프로토콜 조합 및 프로토콜, 클래스 조합
protocol Named3 {
    var name: String { get }
}

protocol Aged3 {
    var age: Int { get }
}

struct Person5: Named3, Aged3 {
    var name: String
    var age: Int
}

class Car3: Named3 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Truck3: Car3, Aged3 {
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }
}

func celebrateBirthday(to celebrator: Named3 & Aged3) {
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let yagom3: Person5 = Person5(name: "yagom3", age: 99)
celebrateBirthday(to: yagom3)       // Happy birthday yagom3!! Now you are 99

let myCar3: Car3 = Car3(name: "Boong Boong")
// celebrateBirthday(to: myCar3)       // 오류 발생!! Aged를 충족시키지 못합니다.

// 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합할 수 있습니다. 오류 발생!!
// var someVariable: Car3 & Truck3 & Aged3

// Car3 클래스의 인스턴스 역할도 수행할 수 있고, Aged3 프로토콜을 준수하는 인스턴스만 할당할 수 있습니다.
var someVariable: Car3 & Aged3

// Truck3 인스턴스는 Car3 클래스 역할을 할 수 있고 Aged3 프로토콜도 준수하므로 할당할 수 있습니다.
someVariable = Truck3(name: "Truck3", age: 5)

// Car3 인스턴스인 myCar3는 Aged3 프로토콜을 준수하지 않으므로 할당할 수 없습니다.
// 오류 발생!
// someVariable = myCar3

// 타입캐스팅에 사용하던 is와 as 연산자를 통해 대상이 프로토콜을 준수하는지 확인할 수도 있고, 특정 프로토콜로 캐스팅할 수 있습니다.
// 프로토콜을 준수하는지 확인하거나 다른 프로토콜로 캐스팅하는 방법은 타입캐스팅 방법과 똑같습니다.
/*
  * is 연산자를 통해 해당 인스턴스가 특정 프로토콜을 준수하는지 확인할 수 있습니다.
  * as? 다운캐스팅 연산자를 통해 다른 프로토콜로 다운캐스팅을 시도해볼 수 있습니다.
  * as! 다운캐스팅 연산자를 통해 다른 프로토콜로 강제 다운캐스팅 할 수 있습니다.
 */

// 프로토콜 확인 및 캐스팅
print(yagom3 is Named3)     // true
print(yagom3 is Aged3)      // true

print(myCar3 is Named3)     // true
print(myCar3 is Aged3)      // false

if let castedInstance: Named3 = yagom3 as? Named3 {
    print("\(castedInstance) is Named3")
}       // Person3 is Named3

if let castedInstance: Aged3 = yagom3 as? Aged3 {
    print("\(castedInstance) is Aged3")
}       // Person3 is Aged3

if let castedInstance: Named3 = myCar3 as? Named3 {
    print("\(castedInstance) is Named3")
}       // Car3 is Named3

if let castedInstance: Aged3 = myCar3 as? Aged3 {
    print("\(castedInstance) is Aged3")
}       // 출력 없음... 캐스팅 실패

// ========== 프로토콜의 선택적 요구 ==========
// 프로토콜의 요구사항 중 일부를 선택적 요구사항으로 지정할 수 있습니다. 선택적 요구사항을 정의하고 싶은 프로토콜은 objc 속성이 부여된 프로토콜이어야 합니다.
// objc 속성은 해당 프로토콜을 Objective-C 코드에서 사용할 수 있도록 만드는 역할을 합니다. 그렇지만 해당 프로토콜을 Objective-C 코드와 공유하고 싶지 않더라도,
// 혹은 프로젝트를 Objective-C 코드와 공유하지 않더라도 objc 속성이 부여되어야만 선택적 요구사항을 정의할 수 있습니다.

// objc 속성이 부여되는 프로토콜은 Objective-C 클래스를 상속받은 클래스에서만 채택할 수 있다는 것입니다. 즉, 열거형이나 구조체 등에서는 objc 속성이 부여된 프로토콜은 아예 채택할 수 없습니다.

/*
  [NOTE] Foundation 프레임워크
   objc 속성을 사용하려면 애플의 Foundation 프레임워크 모듈을 임포트해야 합니다.
*/

// 선택적 요구를 하면 프로토콜을 준수하는 타입에 해당 요구사항을 필수로 구현할 필요가 없습니다. 선택적 요구사항은 optional 식별자를 요구사항의 정의 앞에 붙여주면 됩니다.
// 만약 서드나 프로퍼티를 선택적 요구사항으로 요구하게 되면 그 요구사항의 타입은 자동적으로 옵셔널이 됩니다. 예를 들어 (Int) -> String 타입의 메서드는 ((Int) -> String)? 타입이 됩니다.
// 메서드의 매개변수나 반환 타입이 옵셔널이 된 것이 아니라 메서드(함수) 자체의 타입이 옵셔널이 된 것입니다.

// 선택적 요구사항은 그 프로토콜을 준수하는 타입에 구현되어 있지 않을 수 있기 때문에 옵셔널 체이닝을 통해 호출할 수 있습니다. 프로퍼티뿐만 아니라 메서드도 마찬가지 입니다.

// 프로토콜의 선택적 요구
import Foundation

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

// 걷기만 할 수 있는 호랑이
class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiger walks")
    }
}

// 걷고 날 수 있는 새
class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    
    func fly() {
        print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()        // Tiger walks
bird.walk()         // Bird walks
bird.fly()          // Bird flys

var movableInstance: Moveable = tiger
movableInstance.fly?()      // 응답 없음

movableInstance = bird
movableInstance.fly?()      // Bird flys
// Moveable 프로토콜은 선택적 요구사항인 fly() 메서드를 포함하므로 objc 속성을 부여했습니다. objc 속성의 프로토콜을 사용하기 위해 Tiger와 Bird는 각각 Objective-C의 클래스인 NSObject를 상속받았습니다.
// Tiger는 날 수 없으므로 fly() 메서드를 구현하지 않았고, Bird는 날 수 있으므로 fly() 메서드를 구현했습니다. 각 클래스의 인스턴스를 구현하여 사용할 때는 타입에 메서드가 구현되어 있는지 확인할 수 있지만,
// Moveable 프로토콜 변수에 할당되었을 때는 인스턴스의 타입에 실제로 fly() 메서드가 구현되어 있는지 알 수 없으므로 옵셔널 체인을 이용하여 fly() 메서드 호출을 시도해봅니다.
// 옵셔널 체인을 사용할 때는 메서드 이름 뒤에 물음표를 붙여 표현합니다.

// ========== 프로토콜 변수와 상수 ==========
// 프로토콜 이름을 타입으로 갖는 변수 또는 상수에는 그 프로토콜을 준수하는 타입의 어떤 인스턴스라도 할당할 수 있습니다.

// 프로토콜 타입 변수
var someNamed: Named2 = Animal2(name: "Animal2")
someNamed = Pet2(name: "Pet2")
someNamed = Person4(name: "Person4")
someNamed = School2(name: "School")!
// 프로토콜은 프로토콜 이름만으로 자기 스스로 인스턴스를 생성하고 초기화할 수는 없습니다.
// 그렇지만 프로토콜 변수나 상수를 생성하여 특정 프로토콜을 준수하는 타입의 인스턴스를 할당할 수는 있습니다.
// Pet2, Person4, School2 타입은 모두 Named2 프로토콜을 준수합니다.
// 그렇기 때문에 Named 프로토콜을 타입으로 갖는 변수 someNamed에 Pet2, Person4, School2 타입의 인스턴스가 할당될 수 있습니다.

// ========== 위임을 위한 프로토콜 ==========
// 위임(Delegation)은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴입니다.
// 책무를 위임하기 위해 정의한 프로토콜을 준수하는 타입은 자신에게 위임될 일정 책무를 할 수 있다는 것을 보장합니다. 그렇기 때문에 다른 인스턴스에게 자신이 해야할 일을 믿고 맡길 수 있습니다.
// 위임은 사용자의 특정 행동에 반응하기 위해 사용되기도 하며, 비동기 처리에도 많이 사용합니다.

// 위임 패턴(Delegation Pattern)은 애플의 프레임워크에서 사용하는 주요한 패턴 중 하나입니다.
// 언어 자체로의 기능이 아닌 하나의 디자인 패턴이지만 애플의 프레임워크에서 중요하게 사용되는 만큼, 개념을 알아두면 앞으로 애플 플랫폼의 애플리케이션을 만들 때 도움이 됩니다.
// 애플의 프레임워크에 사용하는 위임 패턴을 위해 다양한 프로토콜이 '0000Delegate'라는 식의 이름으로 정의되어 있습니다.
// 예를 들어 UITableView 타입의 인스턴스가 해야 하는 일을 위임받아 처리하는 인스턴스는 UITableViewDelegate 프로토콜을 준수하면 됩니다.
// 위임받은 인스턴스, 즉 UITableViewDelegate 프로토콜을 준수하는 인스턴스는 UITableView의 인스턴스가 해야하는 일을 대신 처리해줄 수 있습니다.

