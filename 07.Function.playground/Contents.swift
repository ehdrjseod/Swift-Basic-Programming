import UIKit

// ========== 함수 ==========
// ========== 함수와 메서드 ==========
// 메서드: 구조체, 클래스, 열거형 등 특정 타입에 연관되어 사용하는 함수
// 함수: 모듈 전체에서 전역적으로 사용할 수 있는 함수

// ========== 함수의 정의와 호출 ==========
// 함수와 메서드는 정의하는 위치와 호출되는 범위만 다를 뿐, 정의하는 키워드와 구현방법은 같습니다.
// 조건문이나 반복문 같은 스위프트의 다른 문법과 달리 함수에서는 소괄호를 생략할 수 없습니다.
// 스위프트의 함수는 재정의(오버라이드)와 중복 정의(오버로드)를 모두 지원
// 매개변수 타입이 다르면 같은 이름의 함수를 여러개 만들 수 있음.

// 기본적인 함수의 정의와 호출
// 기본으로 함수의 이름과 매개변수(Parameter, 파라미터), 반환타입(Return Type)등을 사용하여 함수를 정의
// 반환을 위한 키워드는 다른 언어처럼 return 입니다.
/*
func 함수 이름(매개변수....) -> 반환 타입 {
    실행 구문
    return 반환 값
}
*/

// 기본 형태의 함수 정의와 사용
func hello(_ name:String) -> String {
    
    return "Hello \(name)!"
}

let helloJenny:String = hello("Jenny")
print(helloJenny)       // Hello Jenny!

func introduce(_ name: String) -> String {
    
    // return "제 이름은 " + name + "입니다"]와 같은 동작을 합니다.
    "제 이름은 " + name + "입니다"
}

let introduceJenny: String = introduce("Jenny")
print(introduceJenny)       // 제 이름은 Jenny입니다.

// 생략할 수 있거나 추가 가능한 부분을 살펴보면 스위프트에서 함수를 얼마나 다양하게 정의할 수 있는지 알 수 있음.
// 결과값의 타입이 함수의 반환 타입과 일치한다면 return 키워드를 생략해도 그 표현의 결괏값이 함수의 반환값이 됨.
/*
 [NOTE] 매개변수와 전달인자
  매개변수는 함수를 정의할 때 외부로부터 받아들이는 전달 값의 이름을 의미
  전달인자(Argument) 혹은 인자는 함수를 실제로 호출할 때 전달하는 값을 의미
 */

// 매개변수
// 매개변수가 없는 함수와 매개변수가 여러 개인 함수
// 매개변수가 없는 함수 정의와 사용
func helloWorld() -> String {
    return "Hello, world!"
}

print(helloWorld()) //Hello, world!

// 매개변수가 여러 개 필요한 함수를 정의할 때는 쉼표로 매개변수를 구분
// 주의할 점은 함수를 호출할 때, 매개변수 이름을 붙여주고 콜론(:)을 적어준 후 전달인자를 보내줌
// 매개변수 이름 : 매개변수에 붙이는 이름
// 매개변수가 여러 개인 함수의 정의와 사용
func sayHello(_ myName: String, yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}

print(sayHello("yagom", yourName: "Jenny"))     // Hello Jenny! I'm yagom

// 매개변수 이름(Parameter Name)과 전달인자 레이블(Argument Label)
/*
 [TIP] 스위프트에서 기본적으로 사용하는 키워드 대부분은 매개변수 이름으로 사용할 수 없습니다.
  하지만 이름을 지정해줄 때 강세표 혹은 backquote(`)로 이름을 감싸주면 대부분의 키워드를
  이름으로 사용할 수 있습니다. 예를 들어 var라는 단어는 스위프트의 키워드이므로 이름으로 사용하면
  컴파일 오류가 발생하지만, 강세표를 사용하여 `var`처럼 작성해주면 이름으로 사용할 수 있습니다.
 */
/*
func 함수 이름(전달인자레이블 매개변수이름: 매개변수타입, 전달인자레이블 매개변수이름: 매개변수타입...) -> 반환 타입 {
    
    실행 구문
    return 반환 값
}
 */
// 매개변수 이름과 전달인자 레이블을 가지는 함수 정의와 사용
// from과 to라는 전달인자 레이블이 있으며
// myName과 name이라는 매개변수 이름이 있는 sayHello 함수
func sayHello(from myName:String, to name:String) -> String {
    
    return "Hello \(name)! I'm \(myName)"
}

print(sayHello(from: "yagom", to: "Jenny")) // Hello Jenny! I'm yagom

// 전달인자 레이블이 없는 함수 정의와 사용
func sayHello(_ name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Chope", 2))     // Hello Chope! Hello Chope!

// 전달인자 레이블 변경을 통한 함수 중복 정의
func sayHello(to name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

func sayHello(to name: String, repeatCount times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello(to: "Chope", 2))
print(sayHello(to: "Chope", repeatCount: 2))

// 매개변수 기본값
// 매개변수 기본값이 있는 함수의 정의와 사용
// times 매개변수가 기본값 3을 갖습니다.
func sayHello(_ name: String, times: Int = 3) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

// times 매개변수의 전달 값을 넘겨주지 않아 기본값 3을 반영해서 세 번 출력합니다.
print(sayHello("Hana"))     // Hello Hana! Hello Hana! Hello Hana!

// times 매개변수의 전달 값을 2로 넘겨주었기 때문에 전달 값을 반영해서 두 번 출력합니다.
print(sayHello("Joe", times: 2))    // Hello Joe! Hello Joe!

/*
 [TIP] print 함수
 우리가 콘솔 로그를 남길 때 사용하는 print() 함수의 원형을 살펴보면
 public func print(_ items: Swift.Any..., separator: String = default, terminator: String = default)로
 정의되어 있습니다. 우리가 단순히 print() 함수에 items 전달인자만 넘겨도 자동으로 동작할 수 있었던 이유입니다.
 terminator 매개변수의 default 값은 줄바꿈 문자(\n)입니다. 그래서 우리가 문자열 끝에 줄바꿈을 해주지 않더라고 print() 함수를
 통해 로그를 생성하면 자동으로 줄이 바뀝니다. 하지만 terminator 매개변수에 빈 문자열("")을 넣어주면 자동으로 줄바꿈이 되지 않습니다.
 참고로 separator 매개변수는 items 매개변수를 통해 들어온 값을 분리해서 표시해주는 문자열을 뜻합니다. 기본으로는 공백(띄어쓰기)으로 동작합니다.*
 */

// 가변 매개변수와 입출력 매개변수
// 매개변수로 몇 개의 값이 들어올지 모를 때, 가변 매개변수를 사용할 수 있습니다.
// 가변 매개변수는 0개 이상(0개 포함)의 값을 받아올 수 있으며,
// 가변 매개변수로 들어온 인자 값은 배열처럼 사용할 수 있습니다.
// 함수마다 가변 매개변수는 하나만 가질 수 있습니다.

// 가변 매개변수를 가지는 함수의 정의와 사용
func sayHelloToFriends(_ me:String, friends names:String...) -> String {
    
    var result:String = ""
    
    for friend in names {
        
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm " + me + "!"
    
    return result
}

print(sayHelloToFriends("yagom", friends: "Johansson", "Jay", "Wizplan"))
// Hello Johansson! Hello Jay! Hello Wizplan! I'm yagom!

print(sayHelloToFriends("yagom"))
// I'm yagom!

// 입출력 매개변수의 전달 순서
/*
 1. 함수를 호출할 때, 전달인자의 값을 복사합니다.
 2. 해당 전달인자의 값을 변경하면 1에서 복사한 것을 함수 내부에서 변경합니다.
 3. 함수를 반환하는 시점에 2에서 변경된 값을 원래의 매개변수에 할당합니다.
 */

// inout 매개변수의 활용
var numbers:[Int] = [1, 2, 3]

func nonReferenceParameter(_ arr:[Int]) {
    
    var copiedArr:[Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1])       // 2

referenceParameter(&numbers)        // 참조를 표현하기 위해 &을 붙여줍니다.
print(numbers[1])

// 반환이 없는 함수
// 함수는 특정 연산을 실행한 후 결괏값을 반환합니다.
// 반환 값이 없는 함수라면 반환 타입을 '없음'을 의미하는 Void로 표기하거나 아예 반환 타입 표현을 생략해도 됩니다.
// 즉, 반환 타입이 Void이거나 생략되어 있다면 반환 값이 없는 함수입니다.

// 반환 값이 없는 함수의 정의와 사용
func sayHelloWorld() {
    print("Hello, world!")
}
sayHelloWorld()     // Hello, world!

func sayHello2(from myName: String, to name: String) {
    print("Hello \(name)! I'm \(myName)")
}
sayHello2(from: "yagom", to: "Mijeong")      //Hello Mijeong! I'm yagom

func sayGoodbye() -> Void {     // Void를 명시해주어도 상관없습니다.
    print("Good bye")
}
sayGoodbye()    // Good bye

// 데이터 타입으로서의 함수
// 스위프트의 함수는 일급 객체이므로 하나의 데이터 타입으로 사용할 수 있습니다.
// 즉, 각 함수는 매개변수 타입과 반환 타입으로 구성된 하나의 타입으로 사용(정의)할 수 있습니다.
// (매개변수 타입의 나열) -> 반환 타입
// 다음 표현은 모두 (Void) -> Void와 같은 표현입니다.
// (Void) -> Void, () -> Void, () -> ()

/*
 [NOTE] 함수의 축약 표현
  함수를 간략히 표현하고자 할 때 앞에서 소개한 축약 표현을 사용하기도 합니다.
  앞의 sayHello(name: String, times: Int) -> String 함수 같은 경우는
  sayHello(name:times:)와 같이 이름과 매개변수 개수 등을 이용해 함수를 표현할 수 있습니다.
 */

// 함수 타입의 사용
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a:Int, _ b:Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a:Int, _ b:Int) -> Int {
    return a * b
}

var mathFunction:CalculateTwoInts = addTwoInts

// var mathFunction: (Int, Int) -> Int = addTwoints와 동일한 표현입니다.
print(mathFunction(2, 5))   // 2 + 5 = 7

mathFunction = multiplyTwoInts
print(mathFunction(2, 5))   // 2 * 5 = 10

/*
 [NOTE] 매개변수 타입과 반환 타입
 함수형 프로그래밍에서 특정 로직에 관여할 함수의 매개변수와 반환타입은 매우 중요합니다.
 타입 별칭을 통해 손쉽게 함수를 관리할 수 있으며 매개변수와 반환 타입만 잘 연계된다면
 굉장히 훌륭한 패턴을 완성할 수 있습니다.
 */

// 전달인자로 함수를 전달받는 함수
func printMathResult(_ mathFunction:CalculateTwoInts, _ a: Int, _ b: Int) {
    
    print("Result : \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)       // Result : 8

// 특정 조건에 따라 적절한 함수를 반환해주는 함수
func chooseMathFunction(_ toAdd:Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)     // Result : 8

/*
 [TIP] 전달인자 레이블과 함수 타입
  전달인자 레이블은 함수 타입의 구성요소가 아니므로 함수 타입을 작성할 때는
  전달인자 레이블을 써줄 수 없스ㅂ니다.
  let someFunction: (lhs:Int, rhs:Int) -> Int       // 오류
  let someFunction: (_ lhs:Int, _ rhs:Int) -> Int   // OK
  let someFunction: (Int, Int) -> Int               // OK

 */

// ========== 중첩 함수 ==========
// 원점으로 이동하기 위한 함수
typealias MoveFunc = (Int) -> Int

func goRight(_ currentPosition:Int) -> Int {
    return currentPosition + 1
}

func goLeft(_ currentPosition:Int) -> Int {
    return currentPosition - 1
}

func functionForMove(_ shouldGoLeft:Bool) -> MoveFunc {
    print("\(shouldGoLeft)??")
    return shouldGoLeft ? goLeft : goRight
}

var position:Int = 3        // 현 위치

// 현 위치가 0보다 크므로 전달되는 인자 값은 true가 됩니다.
// 그러므로 goLeft(_:) 함수가 할당될 것입니다.
var moveToZero:MoveFunc = functionForMove(position > 0)
print("원점으로 갑시다.")

// 원점에 도착하면(현 위치가 0이면) 반복문이 종료됩니다.
while position != 0 {
    
    print("\(position)...")
    position = moveToZero(position)
}

print("원점 도착!!\(position)")

// 중첩 함수의 사용
func functionForMove2(_ shouldGoLeft:Bool) -> MoveFunc {
    
    func goRight2(_ currentPosition:Int) -> Int {
        return currentPosition + 1
    }
    
    func goLeft2(_ currentPosition:Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft2 : goRight2
}

position = -4       // 현 위치

// 현 위치가 0보다 작으므로 전달되는 인자 값은 false가 됩니다.
// 그러므로 goRight(_:) 함수가 할당될 것입니다.
moveToZero = functionForMove2(position > 0)

// 원점에 도착하면(현 위치가 0이면) 반복문이 종료됩니다.
while position != 0 {
    print("\(position)...")
    position = moveToZero(position)
}

print("원점 도착!\(position)")

// ========== 종료되지 않는 함수 ==========
// 스위프트에는 종료(return)되지 않는 함수가 있습니다.
// 종료되지 않는다는 의미는 정상적으로 끝나지 않는 함수라는 뜻입니다.
// 이를 비반환 함수(Nonreturning function) 또는 비반환 메서드(Nonreturning method)라고 합니다.
// 비반환 함수(메서드)는 정상적으로 끝날 수 없는 함수입니다. 이 함수를 실행하면 프로세스 동작은 끝났다고 볼 수 있습니다.
// 비반환 함수 안에서는 오류를 던진다든가, 중대한 시스템 오류를 보고하는 등의 일을 하고 프로세스를 종료해 버립니다.
// 비반환 함수는 어디서든 호출이 가능하고 guard 구문의 else 블록에서도 호출할 수 있습니다.
// 비반환 메서드는 재정의는 할 수 있지만 비반환 타입이라는 것은 변경할 수 없습니다.
// 비반환 함수(메서드)는 반환 타입을 Never라고 명시해주면 됩니다.

// 비반환 함수의 정의와 사용
func crashAndBurn() -> Never {
    fatalError("Something very, very bad happened")
}

//crashAndBurn()  // 프로세스 종료 후 오류 보고

func someFunction(_ isAllIsWell:Bool) {
    
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다!!")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(true)      // All is well
//someFunction(false)     // 마을에 도둑이 들었습니다!
// 프로세스 종료 후 오류 보고

// ========== 반환 값을 무시할 수 있는 함수 ==========
// 프로그래머가 의도적으로 함수의 반환 값을 사용하지 않을 경우, 컴파일러가 함수의 결과 값을 사용하지 않앗다는 경고를 보낼 때도 있습니다.
// 이런 경우 함수의 반환 값을 무시해도 된다는 @discardableResult 선언 속성(부록G)을 사용하면 됩니다.

// @discardableResult 선언 속성 사용
func say(_ something:String) -> String {
    print(something)
    return something
}

@discardableResult func discardableResultSay(_ something:String) -> String {
    print(something)
    return something
}

// 반환 값을 사용하지 않았으므로 컴파일러가 경고를 표시할 수 있습니다.
say("hello")        // hello

// 반환 값을 사용하지 않을 수 있다고 미리 알렸기 때문에
// 반환 값을 사용하지 않아도 컴파일러가 경고하지 않습니다.
discardableResultSay("hello")       // hello
