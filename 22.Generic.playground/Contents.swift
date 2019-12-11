// ========== 제너릭(Generic) ==========
// 제너릭(Generic)은 스위프트의 강력한 기능 중 하나입니다.
// 제너릭을 이용해 코드를 구현하면 어떤 타입에도 유연하게 대응할 수 있습니다.
// 또한 제네릭으로 구현한 기능과 타입은 재사용하기도 쉽고, 코드의 중복을 줄일 수 있기에 깔끔하고 추상적인 표현이 가능합니다.

// 스위프트 표준 라이브러리 또한 수많은 제네릭 코드로 구성되어 있습니다. 사실 우리는 지금까지 제네릭 기능을 수없이 사용하고 있었습니다.
// 예를 들어 Array, Dictionary, Set 등의 타입은 모두 제네릭 컬렉션입니다.
// Int나 String 타입을 요소로 갖는 배열을 만들거나 그 외의 어떤 타입도 배열을 요소로 가질 수 있었던 것은 모두 제네릭 덕분입니다. Dictionary도, Set도 마찬가지입니다.

// 제네릭, 프로토콜, 서브스크립트 등 다양한 기능으로 구현된 Array 타입 선언부
/*
public struct Array<Element> : RandomAccessCollection, MutableCollection {
    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<[Element]>.Element
    // 중략...
    public var startIndex: Int { get }
    public var endIndex: Int { get }
    // 중략...
    public subscript(index: Int) -> Element
    public subscript(bounds: Range<Int>) -> ArraySlice<Element>
    // 중략...
    public mutating func popLast() -> Element?
    // 중략...
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    // 중략...
    public var last: Element? { get }
    // 중략...
    public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
}
*/

// 제네릭을 사용하고자 할 때는 제네릭이 필요한 타입 또는 메서드의 이름 뒤의 홀화살과롷 기호(<>) 사이에 제네릭을 위한 타입 매개변수를 써주어 제네릭을 사용할 것임을 표시합니다.
/*
  제네릭을 사용하고자 하는 타입 이름 <타입 매개변수>
  제네릭을 사용하고자 하는 함수 이름 <타입 매개변수> ( 함수의 매개변수... )
*/

// Array는 타입 매개변수 Element가 있으며, map 메서드는 타입 매개변수가 T가 있습니다.
// Array는 제네릭을 사용하는 제네릭 타입이고, map 메서드는 제네릭을 사용하는 제네릭 함수이기 때문입니다.

// 전위 연산자 구현과 사용
prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)        // 25
// 사용자 정의 연사자 **는 조금 한정된 범위에서만 사용할 수 있습니다.
// 즉, Int 타입에서만 사용자 정의 연산자를 사용할 수 있습니다. UInt 타입, 즉 부호가 없는 정수 타입에서는 Int 타입에 구현해준 사용자 정의 연산자를 사용하지 못합니다.
// 그래서 우리는 조금 더 범용적으로 사용하기 위하여 '정수의 제곱을 구하는 연산자'를 구하려고 합니다.
// 프로토콜과 제네릭이라는 스위프트의 훌륭한 기능을 조합하여 정수 타입 프로토콜, 즉 BinaryInteger 프로토콜에 해당하는 값이면 해당 연산자를 사용할 수 있도록 (제네릭을 이용하여) 구현해줄 수 있습니다.
// 그렇게 되면 UInt 타입에서도 해당 연산자를 사용할 수 있습니다.

// 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용
prefix operator **

prefix func ** <T: BinaryInteger> (value: T) -> T {
    return value * value
}

minusFive = -5
let five: UInt = 5

sqrtMinusFive = **minusFive
let sqrtFive:UInt = **five

print(sqrtMinusFive)        // 25
print(sqrtFive)             // 25

// Int 타입의 두 변숫값을 교환하는 swapTwoInts(_:_:) 함수를 바꿔볼 것입니다.
// 어떻게 하면 코드의 중복을 줄이고 타입에 유연하도록 구현할 수 있는지 제네릭 코드를 사용하여 차근차근 살펴보겠습니다.

// 제네릭을 사용하지 않은 swapTwoInts(_:_:)함수
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA: Int = a
    a = b
    b = temporaryA
}

var numberOne: Int = 5
var numberTwo: Int = 10

swapTwoInts(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")     // 10, 5

// swapTwoInts(_:_:) 함수는 두 Int 타입의 변숫값을 교환하는 역할을 충분히 해낼 수 있습니다.
// 그렇지만 만약 Int 타입이 아닌 Double이나 String타입의 변숫값을 서로 교환하고 싶다면 별도의 함수를 다시 구현해주어야 합니다.

// 제네릭을 사용하지 않은 swapTwoStrings(_:_:) 함수
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA: String = a
    a = b
    b = temporaryA
}

var stringOne: String = "A"
var stringTwo: String = "B"

swapTwoStrings(&stringOne, &stringTwo)

print("\(stringOne), \(stringTwo)")     // "B, A"

// swapTwoStrings(_:_:) 함수는 두 String 타입의 변수끼리 값을 교환하는 역할은 충분히 해냈지만 이 함수도 마찬가지로 String 타입끼리의 교환만 허용할 뿐입니다.
// Double 타입의 값 교환을 원한다면 또 다른 함수를 구현해야 합니다. 그리고 타입맏 다른 함수를 써줘야 하는 불편함도 있습니다.

// 제네릭을 사용하지 않은 swapTwoValues(_:_:) 함수
func swapTwoValues(_a: inout Any, _ b: inout Any) {
    let temporaryA: Any = Any
    a = b
    b = temporaryA
}

var anyOne: Any = 1
var anyTwo: Any = "Two"

swapTwoValues(_a: &anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")       // "Two", 1

anyOne = stringOne
anyTwo = stringTwo

swapTwoValues(_a: &anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")           // "A, B"
print("\(stringOne), \(stringTwo)")     // "B, A"

// swapTwoValues(_a: &stringOne, stringTwo)        // 오류 - Any 외 다른 타입의 전달인자 전달 불가
// Any 타입의 anyOne과 anyTwo 변수의 값을 교환하는 데는 무리가 없습니다. 다만 우리는 Any 타입의 두 변수에 어떤 타입의 값이 들어있을지 모릅니다.
// Int면 Int끼리, String이면 String끼리 교환하고 싶은데, 그런 제한을줄 수 없는 것입니다.
// 또 다른 문제점도 있습니다. Any 타입의 inout 매개변수를 통해 전달될 전달인자의 타입은 Any로 전달되어야 합니다. 다른 타입인 String 타입의 변수(stringOne, stringTwo)를 전달인자로 전달할 수가 없습니다.
// 그래서. String 타입의 값을 Any 타입의 변수(anyOne, anyTwo)에 넣어 함수를 호출해야 하는데, 그 순간 값은 복사되어 할당합니다.
// 즉, 새로운 변수로만 함수를 호출할 수 있는 겁니다. 그렇게 되면 우리가 원했던 stringOne과 stringTwo의 값은 교환할 수 없습니다.

// ========== 제너릭(Generic) 함수 ==========
// 같은 타입인 두 변수의 값을 교환한다는 목적을 타입에 상관없이 할 수 있도록 단 하나의 함수로 구현할 수 있습니다.
/*
  [NOTE] swap 함수
   스위프트 표준 라이브러리에는 swapTwoValue(_:_:)와 같은 기능을 실행하는 더 안전한 함수인 swap(_:_:)이 따로 구현되어 있습니다.
   
   piublic func swap<T>(_ a: inout T, _ b: inout T)
 
   이 함수를 사용하는 것이 따로 값 교환 함수를 구현하여 사용하는 것보다 안전하므로 표준 함수를 사용하는 쪽을 권장합니다.
*/

// 제네릭을 사용한 swapTwoValues(_:_:) 함수
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA: T = a
    a = b
    b = temporaryA
}

swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")     // 10, 5

swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)")     // "B, A"

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")           // "Two", 1

//swapTwoValues(&numberOne, &stringOne)   // 오류!! - 같은 타입끼리만 교환 가능
// 제네릭 함수는 실제 타입 이름(Int, String 등)을 써주는 대신에 플레이스홀더(Placeholder - (위 함수에서는 T))를 사용합니다.
// 플레이스홀더(T)는 타입의 종류를 알려주지 않지만 말 그대로 어떤 타입이라는 것은 알려줍니다. 즉, 매개변수로 플레이스홀더 타입이 T인 두 매개변수가 있으므로, 두 매개변수는 같은 타입이라는 정도는 알 수 있습니다.
// T의 실제 타입은함수가 호출되는 그 순간 결정됩니다. Int 타입의 변수가 전달인자로 전달되었다면 T는 Int가 되고, String 타입의 변수가 전달인자로 전달되었다면 그 호출 순간에 T는 String이 됩니다.

// 제네릭 함수의플레이스 홀더를 지정하는 방법은 함수 이름 오른쪽 홀화살괄호 기호(<>) 안쪽에 플레이스홀더 이름들을 나열하는 것입니다.
// 예를 들어 func swapTwoValues<T>에서는 T가 이 함수의 플레이스홀더로 사용된다는 것을 뜻합니다. T가 플레이스홀더로 사용되기 때문에 스위프트 컴파일러는 함수의 문법을 검사할 때, T의 실제 타입을 신경쓰지 않습니다.

// 플레이스홀더 타입 T는 타입 매개변수(Type parameter)의 한 예로 들 수 있습니다. 타입 매개변수는 플레이스홀더 타입의 이름을 지정하고 명시하는 역할을 하며, 함수의 이름 뒤 홀화살괄호 기호(<>) 안쪽에 위치합니다.
// 타입 매개변수를 지정해주면 이를 함수의 매개변수의 타입으로 사용할 수 있습니다. 또는 함수의 반환 타입으로 사용할 수도 있으며, 함수 내부 변수의 타입 지정을 위해 사용할 수도 있습니다.
// 각각의 경우 타입 매개변수는 함수를 호출할 때마다 실제 타입으로 치환됩니다. 즉, 호출할 때마다 다른 타입으로 작동한다는 뜻입니다.
// 여러 개의 타입 매개변수를 갖고 싶다면 홀화살괄호 기호 안쪽에 쉼표로 분리한 여러 개의 타입 매개변수를 지정해줄 수 있습니다. <T, U, V>

// 타입 매개변수 대부분은 의미있는 이름을 갖게 되는 경우가 많습니다. 예를 들어 딕셔너리에 쓰이는 Key, Value와 같은 이름들입니다.
// Dictionary<Key, Value>와 같이 표현했던 것, 그리고 배열에서 요소를 표현하기 위해 Array<Element>와 같이 표현했습니다.
// 이렇게 의미있는 이름으로 타입 매개변수의 이름을 지정해주면 제네릭 타입 및 제네릭 함수와 타입 매개변수와의 관계를 조금 더 명확히 표현해줄 수 있습니다.
// 그러나 특별히 관계의 의미를 이름으로 표현하기 어려울 때는 관용적으로 T, U, V 등의 대문자 한 글자로 표현합니다.
/*
  [TIP] 타입 매개변수 이름은 타입 이름이기도 하므로 대문자 카멜케이스를 사용하여 표현합니다.
        T, Key, Value, Element, TypeParamterName과 같이 각 단어의 첫 글자를 대문자로 표현해줍니다.
*/

// ========== 제너릭(Generic) 타입 ==========
// 제네릭 타입을 구현하면 사용자 정의 타입인 구조체, 클래스, 열거형 등이 어떤 타입과도 연관되어 동작할 수 있습니다.
// Array와 Dictionary 타입이 자신의 요소로 모든 타입을 대상으로 동작할 수 있는 것과 유사합니다.
// 스택(Stack)은 배열과 유사하게 순서가 있는 값들의 모음입니다. 배열은 중간중간 요소를 삽입하거나 삭제할 수 있지만,
// 스택은 컬렉션의 끝 부분에서만 요소를 추가하고 삭제할 수 있습니다. 추가를 푸시(Push), 삭제를 팝(Pop)이라 칭합니다.

// 제네릭을 사용하지 않은 IntStack 구조체 타입
struct IntStack {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

var integerStack: IntStack = IntStack()

integerStack.push(3)
print(integerStack.items)       // [3]

integerStack.push(2)
print(integerStack.items)       // [3, 2]

integerStack.push(3)
print(integerStack.items)       // [3, 2, 3]

integerStack.push(5)
print(integerStack.items)       // [3, 2, 3, 5]

integerStack.pop()
print(integerStack.items)       // [3, 2, 3]

integerStack.pop()
print(integerStack.items)       // [3, 2]

integerStack.pop()
print(integerStack.items)       // [3]

integerStack.pop()
print(integerStack.items)       // []

// 제네릭을 사용한 Stack 구조체 타입
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)        // [1.0]
doubleStack.push(2.0)
print(doubleStack.items)        // [1.0, 2.0]
doubleStack.pop()
print(doubleStack.items)        // [1.0]

var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)        // ["1"]
stringStack.push("2")
print(stringStack.items)        // ["1", "2"]
stringStack.pop()
print(stringStack.items)        // ["1"]

var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)           // [1.0]
anyStack.push("2")
print(anyStack.items)           // [1.0, "2"]
anyStack.push(3)
print(anyStack.items)           // [1.0, "2", 3]
anyStack.pop()
print(anyStack.items)           // [1.0, "2"]
// Stack의 인스턴스를 생성할 때 실제로 Element 대신 어떤 타입을 사용할지 명시해주는 방법은 Stack<Type>처럼 선언해주면 됩니다.
// 그래서 Stack<Double>이라고 타입을 선언해준 doubleStack 인스턴스는 Element의 타입으로 Double을 사용합니다.
// 마치 우리가 Array 타입을 사용할 때 Array<Type>, Dictionary 타입을 사용할 때 Dictionary<KeyType, ValueType>처럼 표기해줬던 것과 유사하죠. Array도 제네릭 타입입니다.

// ========== 제너릭(Generic) 타입 확장 ==========
// 만약 익스텐션을 통해 제네릭을 사용하는 타입에 기능을 추가하고자 한다면 익스텐션 정의에 타입 매개변수를 명시하지 않아야 합니다.
// 대신 원래의 제네릭 정의에 명시한 타입 매개변수를 익스텐션에서 사용할 수 있습니다.

// 익스텐션을 통한 제네릭 타입의 기능 추가
extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}

print(doubleStack.topElement)       // Optional(1.0)
print(stringStack.topElement)       // Optional("1")
print(anyStack.topElement)          // Optional("2")
// Stack은 제네릭 타입이지만 익스텐션 정의에는 따로 타입 매개변수를 명시해주지 않았습니다.
// 대신 기존의 제네릭 타입에 정의되어 있는 Element라는 타입을 사용할 수 있습니다.

// ========== 타입 제약 ==========
