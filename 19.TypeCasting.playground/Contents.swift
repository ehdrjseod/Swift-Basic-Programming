// ========== 타입캐스팅(TypeCasting) ==========
// 스위프트는 데이터 타입 안전을 위하여 각기 다른 타입끼리의 값 교환을 엄격히 제한합니다. 또, 다른 프로그래밍 언어에서 대부분 지원하는 암시적 데이터 타입 변환(Implicit Type Conversion)은 지원하지 않습니다.
// C 언어의 경우 데이터 타입 변환을 통해 손쉽게 다른 데이터 타입으로 변환해줄 수 있었습니다.
// 예를 들어 int num = (int)2.3f; 과 같이 표현하거나 int num = 2.3f; 처럼 표현하여 데이터 타입을 변환할 수 있었습니다.
// 스위프트에서 Int(2.3)처럼 부동소수 타입을 정수 타입의 값으로 변환해주는 형태와 C 언어의 데이터 타입 변환 형태는 크게 다를 것 없어 보이지만 사실은 사뭇 다릅니다.

// ========== 기존 언어의 타입 변환과 스위프트의 타입 변환 ==========
// C언어와 스위프트의 데이터 타입 변환 비교

// C 언어
/*
double value = 3.3
int convertedValue = (int)value
convertedValue = 5.5            // double -> int 암시적 데이터 타입 변환
*/

// 스위프트
/*
var value: Double = 3.3
var convertedValue: Int = Int(value)
convertedValue = 5.5                // 오류!!
 */
// C 언어 코드를 살펴보면 부동소수 타입인 double에서 정수 타입인 int로 데이터 타입을 변경했습니다. C 언어에서는 이를 타입 변환이라고 칭합니다.
// 그러나 스위프트 코드를 보면 Int(value)라는 형태로 데이터 타입의 형태를 변경해주는데, 이는 앞서 배운 이니셜라이저입니다.
// 즉, 기존 값을 전달인자로 받는 이니셜라이저를 통해 새로운 Int 구조체의 인스턴스를 생성합니다. 스위프트에서는 이를 타입 변환 혹은 타입캐스팅이라고 칭하지 않습니다.
// 다만 이니셜라이저를 통해 새로운 인스턴스를 생성하는 과정입니다. 그래서 Int 구조체의 정의를 들여다보면 다양한 이니셜라이저가 정의되어 있음을 확인할 수 있습니다.

// Int 구조체의 다양한 이니셜라이저 정의
/*
public struct Int: FixedWidthInteger, SignedInteger {
    
    /* 중략... */
    public init(bitPattern x: UInt)
    public init(_ source: Float)
    public init?(exactly source: Float)
    public init(_ source: Double)
    public init?(exactly source: Double)
    public init(_ source: Float80)
    public init?(exactly source: Float80)
    public init(bitPattern pointer: OpaquePointer?)
    public init(from decoder: Decoder) throws
    public init<T>(_ source: T) where T : BinaryFloatingPoint
    public init(bitPattern objectID: ObjectIdentifier)
    public init<U>(bitPattern: UnsafeMutablePointer<U>?)
    public init<U>(bitPattern: UnsafePointer<U>?)
    public init(bitPattern: UnsafeMutableRawPointer?)
    public init(bitPattern: UnsafeRawPointer?)
    
    /* 중략... */
    public convenience init?<S>(_ test: S, radix: Int = default) where S : StringProtocol
    public convenience init(integerLiteral value: Int)
    public convenience init()
    public convenience init?<T>(exactly source: T) where T : BinaryFloatingPoint
    public convenience init(littleEndian value: Int)
    public convenience init(bigEndian value: Int)
    public convenience init<Other>(clamping source: Other) where Other : BinaryInteger
    public convenience init<T>(truncatingIfNeeded source: T) where T : BinaryInteger
    public convenience init<T>(_ source: T) where T : BinaryInteger
    public convenience init?<T>(exactly source: T) where T : BinaryInteger
    /* 중략... */
}
*/
//
// Int의 이니셜라이저는 대부분 실패하지 않는 이니셜라이저로 정의되어 있습니다. 그러나 좀 더 살펴보면 실패 가능한 이니셜라이저도 포함되어 있습니다.
// StringProtocol 타입을 매개변수로 받는 public convenience init?<S>(_ text: S, radix: Int = default) where S : StringProtocol가 실패 가능한 이니셜라이저입니다.
// StringProtocol 타입의 데이터 text를 Int 타입으로 변경할 때, 적절하지 못한 매개변수가 전달된다면 새로운 인스턴스가 생성되지 않을 수 있다는 뜻입니다.

// 실패 가능한 Int 이니셜라이저
var stringValue: String = "123"
var integerValue: Int? = Int(stringValue)

print(integerValue)     // Optional(123)

stringValue = "A123"
integerValue = Int(stringValue)

print(integerValue)     // nil == Optional.none

// ========== 스위프트 타입캐스팅 ==========
// 스위프트에서는 다른 언어의 타입 변환 혹은 타입캐스팅을 이니셜라이저로 단순화했습니다.
// 스위프트에도 타입캐스팅은 있으며 대신 조금 다른 의미로 사용합니다. 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세할 수 있는 방법으로 사용할 수 있습니다.
// 스위프트의 타입캐스팅은 is와 as 연산자로 구현했습니다. 이 두 연산자로 값의 타입을 확인하거나 다른 타입으로 전환(Cast)할 수 있습니다. 또한 타입캐스팅을 통해 프로토콜을 준수하는지도 확인해볼 수 있습니다.

// Coffee 클래스와 Coffee 클래스를 상속받은 Latte와 Americano 클래스
class Coffee {
    let name: String
    let shot: Int
    
    var description: String {
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot: Int) {
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee {
    var flavor: String
    
    override var description: String {
        return "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int) {
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americano: Coffee {
    let iced: Bool
    
    override var description: String {
        return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool) {
        self.iced = iced
        super.init(shot: shot)
    }
}
// Latte와 Americano 클래스는 Coffee 클래스를 상속받은 것을 확인할 수 있습니다.
// Coffee 클래스가 갖는 특성들을 Latte나 Americano가 모두 포함한다는 사실도 알 수 있습니다. 다시 말하면 Coffee는 Latte나 Americano인 척할 수 없지만
// Latte나 Americano는 Coffee인 척할 수 있다는 뜻입니다. 왜냐하면 Latte나 Americano는 Coffee가 갖는 특성을 모두 갖기 때문입니다.

// ========== 데이터 타입 확인 ==========
// 타입 확인 연산자인 is를 사용하여 인스턴스가 어떤 클래스(혹은 어떤 클래스의 자식클래스)의 인스턴스인지 타입을 확인해볼 수 있습니다.
// 타입 확인 연산자는 인스턴스가 해당 클래스의 인스턴스거나 그 자식클래스의 인스턴스라면 true를 반환하고, 그렇지 않다면 false를 반환합니다.
// is 연산자는 클래스의 인스턴스뿐만 아니라 모든 데이터 타입에 사용할 수 있습니다.

// 데이터 타입 확인
let coffee: Coffee = Coffee(shot: 1)
print(coffee.description)           // 1 shot(s) coffee

let myCoffee: Americano = Americano(shot: 2, iced: false)
print(myCoffee.description)         // 2 shot(s) hot americano

let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
print(yourCoffee.description)       // 3 shot(s) green tea latte

print(coffee is Coffee)         // true
print(coffee is Americano)      // false
print(coffee is Latte)          // false

print(myCoffee is Coffee)       // true
print(yourCoffee is Coffee)     // true

print(myCoffee is Latte)        // false
print(yourCoffee is Latte)      // true
// coffee 인스턴스는 Coffee 타입입니다. 따라서 coffee는 Latte타입이나 Americano 타입이 될 수 없습니다.
// 그러나 myCoffee는 Americano 타입이며, yourCoffee는 Latte 타입이므로 myCoffee와 yourCoffee는 Coffee 타입인지 확인했을 때 true를 반환받습니다.
// 하지만 myCoffee와 yourCoffee는 서로 특성이 다르며 부모와 자식클래스의 관계가 아니기 때문에 서로 다른 타입입니다.

// is 연산자 외에도 타입을 확인해볼 수 있는 방법이 있습니다. 메타 타입(Meta Type) 타입을 이용하는 것입니다.
// 메타 타입 타입은 타입의 타입을 뜻합니다. 클래스 타입, 구조체 타입, 열거형 타입, 프로토콜 타입 등의 타입의 타입입니다. 즉, 타입 자체가 하나의 타입으로 또 표현할 수 있다는 것입니다.
// 클래스, 구조체, 열거형의 이름은 타입의 이름입니다. 그 타입의 이름 뒤에 .Type을 붙이면 이는 메타 타입을 나타냅니다. 프로토콜 타입의 메타 타입은 .Protocol이라고 붙여주면 됩니다.
// 예를 들어 SomeClass라는 클래스의 메타 타입은 SomeClass.Type이라고 표현하며, SomeProtocol의 메타 타입은 SomeProtocol.Protocol이라고 표현합니다.
// 또, self를 사용해서 타입을 값처럼 표현할 수 있습니다. 예를 들어 SomeClass.self라고 표현하면 SomeClass의 인스턴스가 아니라 SomeClass 타입을 값으로 표현한 값을 반환합니다.
// 그리고 SomeProtocol.self라고 표현하면 SomeProtocol을 준수하는 타입의 인스턴스가 아니라 SomeProtocol 프로토콜을 값으로 반환합니다.

// 메타 타입
protocol SomeProtocol { }
class SomeClass: SomeProtocol { }

let intType: Int.Type = Int.self
let stringType: String.Type = String.self
let classType: SomeClass.Type = SomeClass.self
let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self

var someType: Any.Type

someType = intType
print(someType)     // Int

someType = stringType

print(someType)     // String

someType = classType
print(someType)     // SomeClass

someType = protocolProtocol
print(someType)     // SomeProtocol
// 정의된 SomeProtocol, SomeClass 등의 메타 타입이 하나의 값으로 취급되어 someType 변수에 할당될 수 있음을 확인할 수 있습니다.
// 또 Int, String도 스위프트에서 구조체로 구현한 타입이므로 메타 타입을 값으로 취급해 할당될 수 있음을 확인할 수 있습니다.
// 만약 프로그램 실행 중에 인스턴스의 타입을 표현한 값을 알아보고자 한다면 type(of:) 함수를 사용합니다.
// 그래서 type(of: someInstance).self라고 표현하면 someInstance의 타입을 값으로 표현한 값을 반환합니다.
/*
  [NOTE] 인스턴스 self와 타입 self의 의미
   .self 표현은 값 뒤에 써주면 그 값 자신을, 타입 이름 뒤에 써주면 타입을 표현하는 값을 반환합니다.
   "stringValue".self는 "stringValue" 그 자체를, String.self는 String 타입을 나타내는 값입니다.
*/

// type(of:) 함수와 .self의 사용
print(type(of: coffee) == Coffee.self)          // true
print(type(of: coffee) == Americano.self)       // false
print(type(of: coffee) == Latte.self)           // false

print(type(of: coffee) == Americano.self)       // false
print(type(of: myCoffee) == Americano.self)     // true
print(type(of: yourCoffee) == Americano.self)   // false

print(type(of: coffee) == Latte.self)           // false
print(type(of: myCoffee) == Latte.self)         // false
print(type(of: yourCoffee) == Latte.self)       // true

// ========== 다운캐스팅(Down Casting) ==========
// 어떤 클래스의 타입의 변수 또는 상수가 정말로 해당 클래스의 인스턴스를 참조하지 않을 수도 있습니다.
// 예를 들어 Latte 클래스의 인스턴스가 Coffee 클래스의 인스턴스인양 Coffee 행세를 할 수 있습니다.

// Latte 타입의 인스턴스를 참조하는 Coffee 타입 actingConstant 상수
let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
print(actingConstant.description)       // 2 shot(s) vanilla latte
// actingConstant 상수는 Coffee 인스턴스를 참조하도록 선언했지만, 실제로는 Coffee 타입인 척 하는 Latte 타입의 인스턴스를 참조하고 있습니다.
// 이런 상황에서 actingConstant가 참조하는 인스턴스를 진짜 타입인 Latte 타입으로 사용해야 할 때가 있습니다.
// 가령 Latte 타입에 정의되어 있는 메서드를 사용하거나 프로퍼티에 접근해야 할 때 Latte 타입으로 변수의 타입을 변환해주어야 합니다. 이를 스위프트에서 다운캐스팅(Down Casting)이라고 합니다.
// 클래스의 상속 모식도에서 자식클래스보다 더 상위에 있는 부모클래스의 타입을 자식클래스의 타입으로 캐스팅한다고 해서 다운캐스팅이라고 부른 것입니다. Any 타입 등에서 다른 타입으로 캐스팅할 때도 다운캐스팅을 사용합니다.

// 타입캐스트 연산자(Type Cast Operator)에는 as?와 as! 두 가지가 있습니다. 타입캐스트 연산자를 사용하여 자식클래스 타입으로 다운캐스팅할 수 있습니다.
// 다운캐스팅은 실패의 여지가 충분히 있기 때문에 ?가 붙은 연산자와 !가 붙은 연산자 두 종류가 있습니다.
// 다운캐스팅을 시도해보는 조건부 연산자인 as? 연산자는 다운캐스팅이 실패했을 경우 nil을 반환하고 다운캐스팅을 강제하는 as! 연산자는 다운캐스팅에 실패할 경우 런타임 오류가 발생합니다.
// 따라서 as? 연산자는 반환 타입이 옵셔널이며, as! 연산자의 반환 타입은 옵셔널이 아닙니다.

// 다운캐스팅에 실패할 가능성이 있다면 조건부 연산자인 as?를 사용해야 합니다. 조건부 연산자 as?를 사용하면 다운캐스팅에 성공할 경우 옵셔널 타입으로 인스턴스를 반환하며, 실패할 경우 nil을 반환합니다.
// 다운캐스팅이 무조건 성공할 것이라고 확신한다면, 즉 해당 변수 또는 상수가 참조하는 인스턴스가 다운캐스팅하고자 하는 타입이 확실하다면 강제 연산자인 as!를 사용할 수 있습니다.
// as! 연산자를 사용하여 다운캐스팅이 성공할 경우 옵셔널이 아닌 인스턴스가 반환되며, 실패할 경우 런타임 오류가 발생합니다.

// 다운캐스팅
if let actingOne: Americano = coffee as? Americano {
    print("This is Americano")
} else {
    print(coffee.description)
}
// 1 shot(s) coffee

if let actingOne: Latte = coffee as? Latte {
    print("This is Latte")
} else {
    print(coffee.description)
}
// 1shot(s) coffee

if let actingOne: Coffee = coffee as? Coffee {
    print("This is Just Coffee")
} else {
    print(coffee.description)
}
// This is Just Coffee

if let actingOne: Americano = myCoffee as? Americano {
    print("This is Americano")
} else {
    print(coffee.description)
}
// This is Americano

if let actingOne: Latte = myCoffee as? Latte {
    print("This is Latte")
} else {
    print(coffee.description)
}
// 1 shot(s) coffee

if let actingOne: Coffee = myCoffee as? Coffee {
    print("This is Just Coffee")
} else {
    print(coffee.description)
}
// This is Just Coffee

// Success
//let castedCoffee: Coffee = yourCoffee as! Coffee

// 런타임 오류!!! 강제 다운캐스팅 실패!
//let castedAmericano: Americano = coffee as! Americano


// 항상 성공하는 다운캐스팅
// 항상 성공한다는 것을 컴파일러도 알고 있습니다.
let castedCoffee: Coffee = yourCoffee as Coffee
/*
  [NOTE] 타입캐스팅의 의미
   캐스팅은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아닙니다. 인스턴스는 메모리에는 똑같이 남아있을 뿐입니다.
   다만 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에 힌트를 주는 것뿐입니다.
*/

// ========== Any, AnyObject의 타입캐스팅 ==========
// 스위프트에는 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 Any와 AnyObject라는 특별한 타입이 있습니다.
// Any는 함수 타입을 포함한 모든 타입을 뜻하고, AnyObject는 클래스 타입만을 뜻합니다.
/*
 [TIP] Any와 AnyObject를 사용하면 예기치 못한 오류가 발생할 확률이 높아지므로 되도록이면 사용을 지양하는 것이 좋습니다.
*/
// 스위프트 표준 라이브러리에서는 Any나 AnyObject를 찾아보기 어렵지만 다른 프로그래머나 기업에서 만들어 제공하는 프레임워크의 API를 보면 Any 또는 AnyObject의 사용을 심심치 않게 볼 수 있습니다.
// API를 통해 어떤 타입의 데이터라도 전달할 수 있다는 의미로 해석해볼 수 있습니다. 그런데 문제는 반환되는 타입도 Any나 AnyObject라면 전달받은 데이터가 어떤 타입인지 확인하고 사용해야 합니다.
// 왜냐하면 스위프트는 암시적 타입 변환을 허용하지 않으며, 타입에 굉장히 엄격하기 때문입니다.

// AnyObject의 타입 확인
func checkType(of item: AnyObject) {
    if item is Latte {
        print("item is Latte")
    } else if item is Americano {
        print("item is Americano")
    } else if item is Coffee {
        print("item is Coffee")
    } else {
        print("Unknwon Type")
    }
}

checkType(of: coffee)           // item is Coffee
checkType(of: myCoffee)         // item is Americano
checkType(of: yourCoffee)       // item is Latte
checkType(of: actingConstant)   // item is Latte

// AnyObject의 타입캐스팅
func castTypeToAppropriate(item: AnyObject) {
    if let castedItem: Latte = item as? Latte {
        print(castedItem.description)
    } else if let castedItem: Americano = item as? Americano {
        print(castedItem.description)
    } else if let castedItem: Coffee = item as? Coffee {
        print(castedItem.description)
    } else {
        print("Unknown Type")
    }
    
    castTypeToAppropriate(item: coffee)         // 1 shot(s) coffee
    castTypeToAppropriate(item: myCoffee)       // 2 shot(s) hot americano
    castTypeToAppropriate(item: yourCoffee)     // 3 shot(s) green tea latte
    castTypeToAppropriate(item: actingConstant) // 2 shot(s) vanilla latte
}

// Any의 타입캐스팅
func checkAnyType(of item: Any) {
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.description)
    case let stringConverter as (String) -> String:
        print(stringConverter("yagom"))
    default:
        print("something else : \(type(of: item))")
    }
}

checkAnyType(of: 0)             // zero as an Int
checkAnyType(of: 0.0)           // zero as a Double
checkAnyType(of: 42)            // an integer value of 42
checkAnyType(of: 3.14159)       // a positive double value of 3.14159
checkAnyType(of: -0.25)         // some other double value that I don't want to print
checkAnyType(of: "hello")       // a stirng value of "hello"
checkAnyType(of: (3.0, 5.0))    // an (x, y) point at 3.0, 5.0
checkAnyType(of: yourCoffee)    // 3 shot(s) green tea latte
checkAnyType(of: coffee)        // something else : Coffee
checkAnyType(of: { (name: String) -> String in "Hello, \(name)" })     // Hello, yagom

/*
 [Tip] 옵셔널과 Any
  Any 타입은 모든 값 타입을 표현합니다. 더불어 옵셔널 타입도 표현할 수 있습니다. 그런데도 Any 타입의 값이 들어와야 할 자리에 옵셔널 타입의 값이 위치한다면 스위프트 컴파일러는 경고를 합니다.
  의도적으로 옵셔널 값을 Any 타입의 값으로 사용하고자 한다면 as 연산자를 사용하여 명시적 타입 캐스팅을 해주면 경고 메시지를 받지 않습니다.
  흔한 예로는 print() 함수를 생각해볼 수 있습니다.
 
  let optionalValue: Int? = 100
  print(optionalValue)          // 컴파일러 경고 발생
  print(optionalValue as Any)   // 경고 없음
*/
