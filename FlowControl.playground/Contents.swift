import UIKit

// ========== 흐름 제어 ==========
// ========== 조건문 ==========

// if 구문
// if 구문 : 대표적인 조건문으로 if, else 등의 키워드를 사용하여 구현할 수 있습니다.
// 정수, 실수 등 0이 아닌 모든 값을 참으로 취급하여 조건 값이 될 수 있었던 다른 언어와는 달리
// 스위프트 if 구문은 조건의 값이 꼭 Bool 타입이어야 합니다.

// if 구문 기본 구현
let first : Int = 5
let second: Int = 7

if first > second {
    
    print("first > second")
} else if first < second {
    
    print("first < second")
} else {
    
    print("first == second")
}

// if 구문의 다양한 구현(소괄호가 없는 코드)
let first2: Int = 5
let second2: Int = 5
var biggerValue: Int = 0

if first2 > second2 { // 조건 수식을 소괄호로 묶어주는 것은 선택 사항입니다.
    
    biggerValue = first2
} else if first2 == second2 {
    
    biggerValue = first2
} else if first2 < second2 {
    
    biggerValue = second2
} else if first2 == 5 {
    
    // 조건이 충족하더라도 이미 first2 == second2라는 조건을 충족해 위에서 실행되었습니다.
    // 따라서 실행되지 않습니다.
    biggerValue = 100
}
// 마지막 else는 생략 가능합니다. 물론 else if도 생략 가능합니다.
// 즉, else나 else if 없이 if만 단독으로 사용할 수도 있습니다.

print(biggerValue)      // 5

// if 구문의 다양한 구현(소괄호가 있는 코드)
if (first2 > second2) {   // 조건 수식을 소괄호로 묶어주는 것은 선택 사항입니다.
    
    biggerValue = first
} else if (first2 == second2) {
    
    biggerValue = first
} else if (first2 < second2) {
    
    biggerValue = second
} else if (first2 == 5) {
    
    // 조건이 충족하더라도 이미 first2 == second2라는 조건을 충족해 위에서 실행되었습니다.
    // 따라서 실행되지 않습니다.
    biggerValue = 100
}

print(biggerValue)      // 5

// switch 구문
// switch 구문은 다른 언어와 비교했을 때 많이 달라진 문법 중 하나
// switch 구문도 소괄호 생략 가능. 단, break 키워드 사용은 선택 사항
// switch 구문의 case를 연속 실행하려면 fallthrough 키워드를 사용
// 비교될 값이 명확히 한정적인 값(열거형 값 등)이 아닐 때는 default를 꼭 작성
// 또한, 각 case에는 범위 연산자를 사용할 수도, where 절을 사용하여 조건을 확장 가능
/*
switch 입력 값 {
    case 비교 값 1:
        실행 구문
    case 비교 값 2:
        실행 구문
        // 이번 case를 마치고 switch 구문을 탈출하지 않습니다. 아래 case로 넘어갑니다.
        fallthrough
    case 비교 값 3, 비교 값 4, 비교 값 5:    // 한 번에 여러 값과 비교할 수 있습니다.
        실행 구문
        break       // break 키워드를 통한 종료는 선택 사항입니다.
    default:        // 한정된 범위가 명확지 않다면 default는 필수입니다.
        실행 구문
}
 */

// switch 구문 기본 구현
let integerValue: Int = 10

switch integerValue {
    
case 0:
    print("Value == zero")
case 1...10:
    print("Value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < Value <= 100")
}

// 부동소수 타입의 범위 연산을 통한 switch case 구성
let doubleValue: Double = 3.0

switch doubleValue {
    
case 0:
    print("Value == zero")
case 1.5...10.5:
    print("1.5 <= Value <= 10.5")
default:
    print("Value == \(doubleValue)")
}

// switch 구문의 입력 값으로 숫자 표현이 아닌 문자, 문자열, 열거형, 튜플, 범위, 패턴이
// 적용된 타입 등 다양한 타입의 값도 사용 가능
// 문자열 switch case 구성
var stringValue: String = "Liam Neeson"

switch stringValue {
    
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny", "Joker", "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are'")
}

// 잘못된 case 사용
/*
let stringValue: String = "Liam Neeson"

switch stringValue {
    
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
    
case "Jenny":
    // stringValue가 "Jenny"에 해당할 때 실행될 코드가 와야 합니다.
    // 비어 있으므로 오류 발생!
case "Joker":
    // stringValue가 "Joker"에 해당할 때 실행될 코드가 와야 합니다.
    // 비어 있으므로 오류 발생!
case "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are'")
}
*/

// fallthrough의 사용
stringValue = "Joker"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny":
    fallthrough
case "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said I don't know who you are.")
}

// 튜플 switch case 구성
typealias NameAge = (name: String, age: Int)
let tupleValue: NameAge = ("yagom", 99)

switch tupleValue {
    
case ("yagom", 99):
    print("정확히 맞췄습니다!")
default:
    print("누굴 찾나요?")
}

// 와일드카드 식별자를 사용한 튜플 switch case 구성
switch tupleValue {
    
case ("yagom", 50):
    print("정확히 맞췄습니다!")
case ("yagom", _) :
    print("이름만 맞았습니다. 나이는 \(tupleValue.age) 입니다.")
case (_, 99) :
    print("나이만 맞았습니다. 이름은 \(tupleValue.name) 입니다.")
default:
    print("누굴 찾나요?")
}

// 값 바인딩을 사용한 튜플 switch case 구성
switch tupleValue {
    
    case ("yagom", 50):
        print("정확히 맞췄습니다!")
    case ("yagom", let age) :
        print("이름만 맞았습니다. 나이는 \(age) 입니다.")
    case (let name, 99) :
        print("나이만 맞았습니다. 이름은 \(name) 입니다.")
    default:
        print("누굴 찾나요?")
}

// where를 사용하여 switch case 확장
let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
    
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다.")
case "사원" where 연차 > 5:
    print("연식 좀 된 사원입니다.")
case "사원":
    print("사원입니다.")
case "대리":
    print("대리입니다.")
default:
    print("사장입니까?")
}

// 열거형을 입력 값으로 받는 switch 구문
enum School {
    
    case primary, elementary, middle, high, college, university, graduate
}

let 최종학력: School = School.university

switch 최종학력 {
    
case .primary:
    print("최종학력은 유치원입니다.")
case .elementary:
    print("최종학력은 초등학교입니다.")
case .middle:
    print("최종학력은 중학교입니다.")
case .high:
    print("최종학력은 고등학교입니다.")
case .college, .university:
    print("최종학력은 대학(교)입니다.")
case .graduate:
    print("최종학력은 대학원입니다.")
}

// Menu 열거형의 모든 case를 처리하는 switch 구문의 상태
enum Menu {
    case chicken
    case pizza
}

let lunchMenu: Menu = .chicken

switch lunchMenu {
case .chicken:
    print("반반 무많이")
case .pizza:
    print("핫소스 많이 주세요")
case _:     //case default: 와 같은 표현
    print("오늘 메뉴가 뭐죠?")
}

// 차후에 Menu 열거형에 추가한 case를 처리하지 않으면 경고를 내어줄 unknown 속성
enum Menu2 {
    
    case chicken
    case pizza
    case hamburger
}

let lunchMenu2: Menu2 = .chicken

switch lunchMenu2 {
    
case .chicken:
    print("반반 무많이")
case .pizza:
    print("핫소스 많이 주세요")
@unknown case _:
    print("오늘 메뉴가 뭐죠?")
}

// ========== 반복문 ==========
// 반복문 : 같거나 비슷한 명령을 반복 실행할 때는 반복문만큼 중요한 것이 없습니다.
// 배열과 같은 시퀀스(Sequence), 순서가 있는 데이터는 반복문으로 더욱 편리하게 처리
// do-while 구문은 스위프트에서는 repeat-while 구문으로 구현되어 있습니다.

// for-in 구문
// 반복적인 데이터나 시퀀스를 다룰 때 많이 사용
/*
for 임시 상수 in 시퀀스 아이템 {
    실행 코드
}
 */
// for-in 반복 구문의 활용
for i in 0...2 {
    print(i)
}

for i in 0...5 {
    
    if i.isMultiple(of: 2) {
        
        print(i)
        continue        // continue 키워드를 사용하면 바로 다음 시퀀스로 건너뜁니다.
    }
    
    print("\(i) == 홀수")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift {
    print(char)
}

var result: Int = 1

// 시퀀스에 해당하는 값이 필요 없다면 와일드카드 식별자(_)를 사용하면 됩니다.
for _ in 1...3 {
     
    result *= 10
}

print("10의 3제곱은 \(result)입니다.")

// 기본 데이터 타입의 for-in 반복 구문 사용
// Dictionary
let friends: [String:Int] = ["Jay":35, "Joe":29, "Jenny":31]

for tuple in friends {
    print(tuple)
}

let 주소: [String: String] = ["도":"충청북도", "시군구":"청주시 청원구", "동읍면": "율량동"]

for (키, 값) in 주소 {
    print("\(키) : \(값)")
}

// Set
let 지역번호: Set<String> = ["02", "031", "032", "033", "041", "042", "043", "051",
                           "052", "053", "054", "055", "061", "062", "063", "064"]

for 번호 in 지역번호 {
    print(번호)
}

// while 구문
// while 반복 구문의 사용
var names: [String] = ["Joker", "Jenny", "Nova", "yagom"]

while names.isEmpty == false {
    print("Good bye \(names.removeFirst())")
    // removeFirst()는 요소를 삭제함과 동시에 삭제한 요소를 반환합니다.
}

// repeat-while 구문
// repeat-while 반복 구문의 사용
names = ["Joker", "Jenny", "Nova", "yagom"]

repeat {
    print("Good bye \(names.removeFirst())")
    // removeFirst()는 요소를 삭제함과 동시에 삭제한 요소를 반환합니다.
} while names.isEmpty == false

// ========== 구문 이름표 ==========
// 반복문을 작성하다 보면 종종 반복문을 중첩으로 작성하게 됨...
// 이때 반복문을 제어하는 키워드(break, continue 등)가 어떤 범위에 적용되어야 하는지 애매하거나
// 큰 범위의 반복문을 종료하고 싶은데 작은 범위의 반복문만 종료되는 등 예상치 못한 실수를 할 수도 있음
// 반복문 앞에 이름과 함께 콜론을 붙여 구문의 이름을 지정해주는 구문 이름표를 사용하면 좋음.
// 이름이 이정된 구문을 제어하고자 할 때는 제어 키워드와 구문 이름을 함께 써주면 됨.

// 중첩된 반복문의 구문 이름표 사용
var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
    printLoop: while true {
        
        print(num)
        count += 1
        print("num = \(num), count = \(count)")
        if count == num {
            break printLoop
        }
    }
    
    removeLoop: while true {
        
        if numbers.first != num {
            break numbersLoop
        }
        numbers.removeFirst()
    }
}
