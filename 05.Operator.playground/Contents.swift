import UIKit

// ========== 연산자 ==========
// 연산자 : 특정한 문자로 표현한 함수
// 연산자에 의해 연산 되는 값의 수에 따라 단항, 이항, 삼항 등으로 구분하기도 하며,
// 연산자의 위치에 따라 전위, 중위, 후위 등으로 구분하기도 합니다.

/*
   - 연산자의 구분
  단항 연사자 > 피연산자(연산 대상)가 한 개인 연산자 > !A
  이항 연산자 > 피연산자가 두 개인 연산자 > A + B
  삼항 연산자 > 피연산자가 세 개인 연산자 > A ? B : C
  전위 연산자 > 연산자가 피연산자 앞에 위치하는 연산자 > !A
  중위 연산자 > 연산자가 피연산자 사이에 위치하는 연산자 > A + B
  후위 연산자 > 연산자가 피연산자 뒤에 위치하는 연산자 > A!
 */

// ========== 연산자의 종류 ==========
// 할당 연산자 > 값을 할당할 때 사용하는 연산자 > A = B > A에 B의 값을 할당합니다. 서로 다른 데이터 타입이라면 오류가 발생
// 산술 연산자 > 산술 연산자는 대체로 수학에서 쓰이는 연사ㄴ자와 같은 역할을 수행
/*
  더하기 연산자 > A + B > A와 B를 더한 값을 반환합니다.
  빼기 연산자 > A - B > A에서 B를 뺀 값을 반환합니다.
  곱하기 연산자 > A * B > A와 B를 곱한 값을 반환합니다.
  나누기 연산자 > A / B > A를 B로 나눈 값을 반환합니다.
  나머지 연산자 > A % B > A를 B로 나눈 나머지를 반환합니다.
 */

/*
 [NOTE] 스위프트의 나머지 연산과 나누기 연산자
  스위프트에서는 부동소수점 타입의 나머지 연산까지 지원합니다. 기존의 프로그래밍 언어에서는 나머지 연산자가
  정수 타입만 지원하는 경우가 많았는데 스위프트에서는 부동소수점 타입도 나머지 연산을 할 수 있습니다.

  let number: Double = 5.0
  let result: Double = number.truncatingRemainder(dividingBy: 1.5)  // 0.5
  result = 12.truncatingRemainder(dividingBy: 2.5)                  // 2.0
 
  나누기 연산은 기존의 프로그래밍 언어처럼 나머지나 소수점을 제외한 정수만을 결과값으로 반환합니다.
  
  var result: Int = 5 / 3   // 1
  result = 10 / 3           // 3
 
  또한, 스위프트는 데이터 타입에 굉장히 엄격하므로 서로 다른 자료형끼리의 연산을 엄격히 제한합니다.
  서로 다른 자료형끼리의 연산을 실행하려면 값을 해당 타입으로 변환한 후 연산해야 합니다.
  심지어 같은 정수 타입인 Int 타입과 UInt 타입끼리의 연산도 엄격히 제한됩니다.
 */

// 비교 연산자 > 두 값을 비교할 때 사용합니다.
/*
 값이 같다 : A == B : A와 B가 같은 값인지 비교하여 불리언 값을 반환
 값이 크거나 같다 : A >= B : A가 B보다 크거나 같은 값인지 비교하여 불리언 값을 반환
 값이 작거나 같다 : A <= B : A가 B보다 작거나 같은 값인지 비교하여 불리언 값을 반환
 값이 크다 : A > B : A가 B보다 큰 값인지 비교하여 불리언 값을 반환
 값이 작다 : A < B : A가 B보다 작은 값인지 비교하여 불리언 값을 반환
 값이 같지 않다 : A != B : A와 B가 다른 값인지 비교하여 불리언 값을 반환
 참조가 같다 : A === B : A와 B가 참조(레퍼런스) 타입일 때 A와 B가 같은 인스턴스를 가리키는지 비교하여 불리언 값을 반환
 참조가 같지 않다 : A !== B : A와 B가 참조(레퍼런스0 타입일 때 A와 B가 같지 않은 인스턴스를 가리키는지 비교하여 불리언 값을 반환
 패턴 매치 : A ~= B : A와 B의 패턴이 매치되는지 확인하여 불리언 값을 반환
 */

/*
 [NOTE] 참조 비교 연산자
 스위프트의 유일한 참조(Reference) 타입인 인스턴스에서만 참조 비교 연산자를 사용할 수 있습니다.
 (물론 다른 데이터 타입에서 === 등의 연산자를 프로그래머가 정의하면 다른 용도로 사용이 가능합니다)
 스위프트의 기본 데이터 타입은 모두 구조체로 구현되어 있기 때문에 값 타입입니다.
 그렇기 때문에 값의 비교 연산에는 ==를 사용하고 클래스의 인스턴스인 경우에만 ===를 사용합니다.
 
 let valueA: Int = 3
 let valueB: Int = 5
 let valueC: Int = 5
 
 let isSameValueAB: Bool = valueA == valueB     // false
 let isSameValueBC: Bool = valueB == valueC     // true
 
 let referenceA: SomeClass = SomeClass()
 let referenceB: SomeClass = SomeClass()
 let referenceC: SomeClass = referenceA
 
 let isSameReferenceAB: Bool = referenceA === referenceB    // false
 let isSameReferenceAC: Bool = referenceA === referenceC    // true
 */

// 삼항 조건 연산자 : 피연사자가 세 개인 삼항 조건 연산자
// 삼항 조건 연사자 > Question ? A : B > Question(불리언 값)이 참이면 A를, 거짓이면 B를 반환합니다.

// 삼항 조건 연산자의 사용
var valueA: Int = 3
var valueB: Int = 5
var biggerValue: Int = valueA > valueB ? valueA : valueB    // 5

valueA = 0
valueB = -3
biggerValue = valueA > valueB ? valueA : valueB             // 0

var stringA: String = ""
var stringB: String = "String"
var resultValue: Double = stringA.isEmpty ? 1.0 : 0.0       // 1.0
resultValue = stringB.isEmpty ? 1.0 : 0.0                   // 0.0

// 범위 연산자 : 값(수)의 범위를 나타내고자 할 때 사용
/*
 폐쇄 범위 연산자 | A...B | A부터 B까지의 수를 묶어 범위를 표현합니다. A와 B를 포함합니다.
 반폐쇄 범위 연산자 | A..<B | A부터 B미만까지의 수를 묶어 범위를 표현합니다. A를 포함하고 B를 포함하지 않습니다.
 단방향 범위 연산자 | A... | A 이상의 수를 묶어 범위를 표현합니다. A를 포함합니다.
               | ...A | A 이하의 수를 묶어 범위를 표현합니다. A를 포함합니다.
               | ..<A | A 미만의 수를 묶어 범위를 표현합니다. A를 포함하지 않습니다.
 */

// 부울 연산자 : 불리언 값의 논리 연산을 할 때 사용합니다.
/*
 NOT(부정) 부울 연산자 > !B > B(불리언 값)의 참, 거짓을 반전합니다.
 AND 부울 연산자 > A && B > A와 B의 불리언 AND 논리 연산을 실행합니다.
 OR 부울 연산자 > A || B > A와 B의 불리언 OR 논리 엲산을 실행합니다.
 */

// 부울 논리 연산과 비트 논리 연산을 잘 이해하고 구분하여 사용해야 합니다.

// 비트 연산자 : 값의 비트 논리 연산을 위한 연산자
/*
 NOT(부정) 비트 연산자 : ~A : A의 비트를 반전한 결과를 반환
 AND 비트 연산자 : A & B : A와 B의 비트 AND 논리 연산을 실행
 OR 비트 연산자 : A | B : A와 B의 비트 OR 논리 연산을 실행
 XOR 비트 연산자 : A ^ B : A와 B의 비트 XOR 논리 연산을 실행
 비트 이동 연산자(시프트 연산자) : A >> B : A의 비트를 B만큼 비트를 시프트(이동)
                         : A << B :
 */

/*
 [TIP] 비트 시프트(이동)
  시프트 연산자는 지정하는 수만큼 피연산자를 왼쪽(<<) 또는 오른쪽(>>)으로 이동합니다.
  예를 들어 정수 4(0100(2))를 왼쪽으로 1 시프트 연산할 때 4 << 1로 표현해줄 수 있습니다.
  왼쪽으로 비트를 이동했기 때문에 결과는 8(1000(2))이 됩니다.
  반대로 오른쪽 1 시프트 연산을 하면 4 >> 1로 표현할 수 있고 결과는 2(0010(2))가 됩니다.
  위의 왼쪽 비트 연산의 결과처럼 시프트 한 후 빈 자리는 0으로 채워집니다.
  반대로 시프트 연산을 하면서 비트 범위를 벗어난 비트는 버려집니다.
  만약 7(0111(2))를 오른쪽 2 시프트 연산을 하면, 결과는 1(0001(2))이 됩니다.
 */

// 복합 할당 연산자(Compound Assignment) : 할당 연산자와 다른 연산자가 하는 일을 한 번에 할 수 있도록 연산자를 결합
/*
 A += B : A와 B의 합을 A에 할당 : A = A + B
 A -= B : A와 B의 차를 A에 할당 : A = A - B
 A *= B : A와 B의 곱을 A에 할당 : A = A * B
 A /= B : A를 B로 나눈 값을 A에 할당 : A = A / B
 A %= B : A를 B로 나눈 나머지를 A에 할당 : A = A % B
 A <<= N : A를 N만큼 왼쪽 비트 시프트 한 값을 A에 할당 : A = A << N
 A >>= N : A를 N만큼 오른쪽 비트 시프트 한 값을 A에 할당 : A = A >> N
 A &= B : A와 B의 비트 AND 연산 결과를 A에 할당 : A = A & B
 A |= B : A와 B의 비트 OR 연산 결과를 A에 할당 : A = A | B
 A ^= B : A와 B의 비트 XOR 연산 결과를 A에 할당합니다 : A = A ^ B
 */

// 오버플로 연산자
/*
 오버플로 더하기 연산 | &+ | 오버플로에 대비한 덧셈 연산을 합니다.
 오버플로 빼기 연산 | &- | 오버플로에 대비한 뺄셈 연산을 합니다.
 오버플로 곱하기 연산 | &* | 오버플로에 대비한 곱셈 연산을 합니다.
 */
// 오버플로 연산자의 사용
var unsignedInteger: UInt8 = 0
//let errorUnderflowResult: UInt8 = unsignedInteger - 1       // 런타임 오류
let underflowedValue: UInt8 = unsignedInteger &- 1          // 255

unsignedInteger = UInt8.max                                 // 255
//let errorOverflowResult: UInt8 = unsignedInteger + 1        // 런타임 오류
let overflowedValue: UInt8 = unsignedInteger &+ 1           // 0

// 기타 연산자
/*
 nil 병합 연산자 | A ?? B | A가 nil이 아니면 A를 반환하고, A가 nil이면 B를 반환합니다.
 부호변경 연산자 | -A | A(수)의 부호를 변경합니다.
 옵셔널 강제 추출 연산자 | O! | O(옵셔널 개체)의 값을 강제로 추출합니다.
 옵셔널 연산자 | V? | V(옵셔널 값)를 안전하게 추출하거나, V(데이터 타입)가 옵셔널임을 표현합니다.
 */

/*
 [NOTE] nil 병합 연산자
 nil 병합 연산자는 옵셔널을 사용할 때 아주 유용한 연산자입니다. 아직 옵셔널에 대해 배우지 않았지만 차후
 옵셔널을 배우고 nil 병합 연산자를 다시 확인해보기 바랍니다. 다음 두 코드는 같은 역할을 하지만, 아래의 nil
 병합 연산자를 사용하는 것이 훨씬 안전하고 간단한 방법입니다.
 
 let valueInt: Int = someOptionalInt != nil ? someOptionalInt! : 0
 
 // 위 코드와 같은 결과를 볼 수 있지만 훨씬 안전하게 옵셔널을 다룰 수 있습니다.
 let valueInt: Int = someOptionalInt ?? 0
 
 참고로 옵셔널 강제 추출 연산자 사용은 지양하는 편이 좋습니다.
 */

// ========== 연산자 우선순위와 결합방향 ==========
/*
 스위프트에서는 연산자 우선순위(Precedence)를 지정해 놓았기 때문에 코딩하다가 헷갈리는 경우 확인하면 됩니다.
 우선순위가 높은 연산자는 자신에 비해서 우선순위가 낮은 연산자보다 먼저 실행됩니다.
 연산자가 연산하는 결합방향(Associativity)도 지정되어 있습니다.
 기본 연산자들의 우선도와 결합방향을 알아보려면 스위프트 표준 라이브러리의 연산자 정의를 참고
 */

// 연산자 우선순위에 따른 처리순서
let intValue: Int = 1
let resultValue1: Int = intValue << 3 + 5       // 8 + 5 => 13
let resultValue2: Int = 1 * 3 + 5               // 3 + 5 => 8

/*
 [NOTE] Objective-C, C언어, 스위프트의 연산자 우선순위와 결합방향
 
 스위프트의 연산자 우선순위와 결합방향 규칙은 C언어나 Objective-C보다 훨씬 간단하고 예측 가능합니다.
 그렇지만 C계열 언어와 스위프트의 연산자 우선순위나 결합뱡향이 완전히 같지는 않습니다.
 기존의 C계열 언어를 스위프트로 변환할 때 이를 명심해야 합니다.
 */

// ========== 사용자 정의 연산자 ==========
// 사용자 정의 연산자 : 사용자(프로그래머)의 입맛에 맞게 연산자 역할을 부여
/*
 [NOTE] = 과 ? :
 할당 연산자(=)와 삼항 연산자(?:)는 사용자 정의 역할을 부여할 수 없습니다.
 */

// ========== 전위 연산자 정의와 구현 ==========
//기존에 없던 연산자를 만들고 싶다면 연산자 정의를 먼저 해주어야 합니다.

prefix operator **

prefix func ** (_ value: Int) -> Int {
    
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)        // 25

// 전위 연산자 함수 중복 정의와 사용
prefix func ! (_ value: String) -> Bool {
    
    return value.isEmpty
}

var stringValue: String = "yagom"
var isEmptyString: Bool = !stringValue

print(isEmptyString)        // false

stringValue = ""
isEmptyString = !stringValue

print(isEmptyString)

prefix func ** (_ value: String) -> String {
    
    return value + " " + value
}

let resultString: String = **"yagom"

print(resultString)     // yagom yagom

// ========== 후위 연산자 정의와 구현 ==========
postfix operator **

postfix func ** (_ value: Int) -> Int {
    
    return value + 10
}

let five: Int = 5
let fivePlusTen: Int = five**

print(fivePlusTen)      // 15

// 전위 연산자와 후위 연산자 동시 사용
prefix operator ***
postfix operator ***

prefix func *** (_ value: Int) -> Int {
    
    return value * value
}

postfix func *** (_ value: Int) -> Int {
    
    return value + 10
}

let five2: Int = 5
let sqrtFivePlusTen: Int = ***five2***

print(sqrtFivePlusTen)

// ========== 중위 연산자 정의와 구현 ==========
// 중위 연산자 정의도 전위 연산자나 후위 연산자 정의와 크게 다르지 않습니다.
// 중위 연산자는 우선순위 그룹을 명시해줄 수 있습니다.
// 만약 중위 연산자를 정의할 때 우선순위 그룹을 명시해주지 않는다면
// 우선순위가 가장 높은 DefaultPrecedence 그룹을 우선순위 그룹으로 갖게 됩니다.
/*
precedencegroup 우선순위 그룹 이름 {
    
    higerThan: 더 낮은 우선순위 그룹 이름
    lowerThan: 더 높은 우선순위 그룹 이름
    associativity: 결합방향(left / right / none)
    assignment: 할당방향 사용(true / false)
}
*/
// 중위 연산자의 구현과 사용
// String 타입의 contains(_:) 메서드를 사용하기 위해 Foundation 프레임워크를 임포트합니다.
import Foundation

// 중위 연산자의 정의
infix operator ** : MultiplicationPrecedence

func ** (_ lhs: String, rhs: String) -> Bool {
    
    return lhs.contains(rhs)
}

let helloYagom: String = "Hello yagom"
let yagom: String = "yagom"
let isContainsYagom: Bool = helloYagom ** yagom     // true

// 클래스 및 구조체의 비교 연산자 구현
class Car {
    
    var modelYear: Int?     // 연식
    var modelName: String?  // 모델 이름
}

struct SmartPhone {
    
    var company: String?        // 제조사
    var model: String?          // 모델
}

// Car 클래스의 인스턴스끼리 == 연산했을 때 modelName이 같다면 true를 반환
func == (_ lhs: Car, rhs: Car) -> Bool {
    
    return lhs.modelName == rhs.modelName
}

// SmartPhone 구조체의 인스턴스끼리 == 연산했을 때 model이 같다면 true를 반환
func == (_ lhs: SmartPhone, rhs: SmartPhone) -> Bool {
    
    return lhs.model == rhs.model
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar)     // true
print(myPhone == yourPhone) // false

// 타입 메서드로 구현된 사용자 정의 비교 연산자
class Car2 {
    
    var modelYear: Int?     // 연식
    var modelName: String?  // 모델 이름
    
    // Car2 클래스의 인스턴스끼리 == 연산했을 때 modelName이 같다면 true를 반환
    static func == (lhs: Car2, rhs: Car2) -> Bool {
        
        return lhs.modelName == rhs.modelName
    }
}

struct SmartPhone2 {
    
    var company: String?    // 제조사
    var model: String?      // 모델
    
    // SmartPhone 구조체의 인스턴스끼리 == 연산했을 때 model이 같다면 true를 반환
    static func == (_ lhs: SmartPhone2, rhs: SmartPhone2) -> Bool {
        
        return lhs.model == rhs.model
    }
}
