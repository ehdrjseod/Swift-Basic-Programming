// ========== 맵(Map), 필터(Filter), 리듀스(Reduce) ==========
// 스위프트는 함수를 일급 객체로 취급합니다. 따라서 함수를 다른 함수의 전달인자로 사용할 수 있습니다.
// 매개변수로 함수를 갖는 함수를 고차함수라고 부르는데, 스위프트에 유용한 대표적인 고차함수로는 맵, 필터, 리듀스 등이 있습니다.

// ========== 맵(Map) ==========
// 맵(Map)은 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수입니다.
// 스위프트의 Sequence, Collection 프로토콜을 따르는 타입과 옵셔널은 모두 맵을 사용할 수 있습니다.
// 맵을 사용하면 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환합니다.
// 기존 컨테이너의 값은 변경되지 않고 새로운 컨테이너가 생성되어 반환됩니다. 그래서 맵은 기존 데이터를 변형(transform)하는 데 많이 사용합니다.

// 맵 메서드의 호출 및 결과
/*
container.map(f(x)) 컨테이너의 map 메서드 호출
 -> return f(container의 각 요소) // 새로운 컨테이너
 */

// map 메서드의 사용법은 앞서 알아본 for-in 구문과 별반 차이가 없습니다. 다만 코드의 재사용 측면이나 컴파일러 최적화 측면에서 본다면 성능 차이가 있습니다.
// 또, 다중 스레드 환경일 때 대상 컨테이너 값이 스레드에서 변경되는 시점에 다른 스레드에서도 동시에 값이 변경되려고 할 때 예측치 못한 결과가 발생하는 부작용을 방지할 수도 있습니다.
/*
 [TIP]
  15장에서는 배열에서의 map, filter, reduce를 소개하지만 스위프트의 다른 컬렉션 타입(세트, 딕셔너리 등)을 위한 map, filter, reduce도 있습니다.
  또, 딕셔너리에는 키에 해당하는 값을 위한 mapValue, compactMapValue, flatMapValue 등도 있으니 한 번 살펴보세요.
 */

// for-in 구문과 맵 메서드의 사용 비교
let numbers: [Int] = [0, 1, 2, 3, 4]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// for 구문 사용
for number in numbers {
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)       // [0, 2, 4, 6, 8]
print(strings)              // ["0", "1", "2", "3", "4"]

// map 메서드 사용
doubledNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})

strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubledNumbers)   // [0, 2, 4, 6, 8]
print(strings)          // ["0", "1", "2", "3", "4"]

// map 메서드를 사용했을 때 for-in 구문을 사용한 것보다 간결하고 편리하게 각 요소의 연산을 실행하는 것을 볼 수 있습니다.
// 심지어 map 메서드를 사용하면 for-in 구문을 사용하기 위하여 빈 배열을 처음 생성해주는 작업도 필요 없습니다. 배열의 append 연산을 실행하기 위한 시간도 필요 없습니다.

// 클로저 포현의 간략화
let numbers2: [Int] = [0, 1, 2, 3, 4]

// 기본 클로저 표현식 사용
var doubledNumbers2 = numbers.map({ (number: Int) -> Int in
    return number * 2
})

// 매개변수 및 반환 타입 생략
doubledNumbers2 = numbers.map({ return $0 * 2 })
print(doubledNumbers2)          // [0, 2, 4, 6, 8]

// 반환 키워드 생략
doubledNumbers2 = numbers.map({ $0 * 2 })
print(doubledNumbers2)          // [0, 2, 4, 6, 8]

// 후행 클로저 사용
doubledNumbers2 = numbers.map { $0 * 2 }
print(doubledNumbers2)          // [0, 2, 4, 6, 8]

// 클로저 표현을 간략화하니 조금씩 코드가 더 간결해졌습니다. 그런데 처음에 언급했던 코드의 재사용 측면에 대해 생각해볼 필요가 있습니다.
// 같은 기능을 여러 번 사용할 것이라면 하나의 클로저를 여러 map메서드에서 사용하는 편이 좋을 것 같습니다.

// 클로저의 반복 사용
let evenNumbers: [Int] = [0, 2, 4, 6, 8]
let oddNumbers: [Int] = [0, 1, 3, 5, 7]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubledEvenNubmers = evenNumbers.map(multiplyTwo)
print(doubledEvenNubmers)       // [ 0, 4, 8, 12, 16]

let doubledOddNumbers = oddNumbers.map(multiplyTwo)
print(doubledOddNumbers)        // [0, 2, 6, 10, 14]

// 다양한 컨테이너 타입에서의 앱의 활용
let alphabetDictionary: [String: String] = ["a":"A", "b":"B"]

var keys: [String] = alphabetDictionary.map { (tuple: (String, String)) -> String in
    return tuple.0
}

keys = alphabetDictionary.map{ $0.0 }

let values: [String] = alphabetDictionary.map{ $0.1 }
print(keys)     // ["b", "a"]
print(values)   // ["B", "A"]

var numberSet: Set<Int> = [1, 2, 3, 4, 5]
let resultSet = numberSet.map{ $0 * 2 }
print(resultSet)        // [2, 4, 6, 8, 10]

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map{ $0 * 2 }
print(resultInt)        // 6 - 경고가 발생하는 이유는 타입캐스팅의 TIP에서 설명합니다.

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map{ $0 * 2 }
print(resultRange)      // [0, 2, 4, 6]

// ========== 필터(Filter) ==========
// 필터(Filter)는 말 그대로 컨테이너 내부의 값을 걸러서 추출하는 역할을 하는 고차함수입니다. 맵과 마찬가지로 새로운 컨테이너에 값을 담아 반환해줍니다.
// 다만 맵처럼 기존 콘텐츠를변형하는 것이 아니라, 특정 조건에 맞게 걸러내는 역할을 할 수 있다는 점이 다릅니다.
// filter 함수의 매개변수로 전달되는 함수의 반환 타입은 Bool입니다. 해당 콘텐츠의 값을 갖고 새로운 컨테이너에 포함될 항목이라고 판단하면 true를, 포함하지 않으려면 false를 반환해주면 됩니다.

// 필터 메서드의 사용
let numbers3: [Int] = [0, 1, 2, 3, 4, 5]

let evenNumbers3: [Int] = numbers3.filter{ (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)      // [0, 2, 4]

let oddNumbers3: [Int] = numbers3.filter{ $0 % 2 == 1 }
print(oddNumbers3)      // [1, 3, 5]

// 맵과 필터 메서드의 연계 사용
let numbers4: [Int] = [0, 1, 2, 3, 4, 5]
let mappedNumbers: [Int] = numbers4.map{ $0 + 3 }
let evenNumbers4: [Int] = mappedNumbers.filter{ (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers4)     // [4, 6, 8]

// mappedNumbers4를 굳이 여러 번 사용할 필요가 없다면 메서드를 체인처럼 연결하여 사용할 수 있습니다.
let oddNumbers4: [Int] = numbers.map{ $0 + 3 }.filter{ $0 % 2 == 1 }
print(oddNumbers4)      // [3. 5. 7]

// ========== 리듀스(Reduce) ==========
// 리듀스(Reduce) 기능은 사실 결합(Combine)이라고 불러야 마땅한 기능입니다. 리듀스는 컨테이너 내부의 콘텐츠를 하나로 합하는 기능을 실행하는 고차함수입니다.
// 배열이라면 배열의 모든 값을 전달인자로 전달받은 클로저의 연산 결과로 합해줍니다.
// 스위프트의 리듀스는 두 가지 형태로 구현되어 있습니다. 첫 번째 리듀스는 클로저가 각 요소를 전달받아 연산한 후 값을 다음 클로저 실행을 위해 반환하며 컨테이너를 순환하는 형태입니다.

// public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
// initialResult이라는 이름의 매개변수로 전달되는 값을 통해 초깃값을 지정해줄 수 있으며, nextPartialResult라는 이름의 매개변수로 클로저를 전달받습니다.
// nextPartialResult 클로저의 첫 번째 매개변수는 리듀스 메서드의 initialResult 매개변수를 통해 전달받은 초깃값 또는 이전 클로저의 결괏값입니다.
// 모든 순회가 끝나면 리듀스의 최종 결괏값이 됩니다. 두 번째 매개변수는 리듀스 메서드가 순환하는 컨테이너의 요소입니다.

// 두 번쨰 리듀스 메서드는 컨테이너를 순환하며 클로저가 실행되지만 클로저가 따로 결괏값을 반환하지 않는 형태입니다.
// 대신 inout 매개변수를 사용하여 초깃값에 직접 연산을 실행하게 됩니다.
/*
public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
*/
// updateAccumulatingResult 매개변수로 전달받는 클로저의 매개변수 중 첫 번째 매개변수를 inout 매개변수로 사용합니다.
// updateAccumulatingResult 클로저의 첫 번째 매개변수는 리듀스 메서드의 initialResult 매개변수를 이용해 전달받은 초깃값 또는 이전에 실행된 클로저 때문에 변경되어 있는 결괏값입니다.
// 모든 순회가 끝나면 리듀스의 최종 결괏값이 됩니다. 두 번째 매개변수는 리듀스 메서드가 순환하는 컨테이너의 요소입니다. 상황에 따라서는 리듀스를맵과 유사하게 사용할 수도 있습니다.

// 리듀스의 메서드의 사용
let numbers5: [Int] = [1, 2, 3]

// 첫 번째 형태인 reduce(_:_:) 메서드의 사용

// 초깃값이 0이고 정수 배열의 모든 값을 더합니다.
var sum: Int = numbers5.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    // 0 + 1
    // 1 + 2
    // 3 + 3
    return result + next
})

print(sum)      // 6


// 초깃값이 0이고 정수 배열의 모든 값을 뺍니다.
let subtract: Int = numbers5.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    // 0 - 1
    // -1 - 2
    // -3 - 3
    return result - next
})

print(subtract)    // -6

// 초깃값이 3이고 정수 배열의 모든 값을 더합니다.
let sumFromThree: Int = numbers5.reduce(3) {
    print("\($0) + \($1)")
    // 3 + 1
    // 4 + 2
    // 6 + 3
    return $0 + $1
}

print(sumFromThree)     // 9

// 초깃값이 3이고 정수 배열의 모든 값을 뺍니다.
var subtractFromThree: Int = numbers5.reduce(3) {
    print("\($0) - \($1)")
    // 3 - 1
    // 2 - 2
    // 0 - 3
    return $0 - $1
}

print(subtractFromThree)        // -3

// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결시킵니다.
let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reducedNames: String = names.reduce("yagom's friend : ") {
    return $0 + ", " + $1
}

print(reducedNames)     // "yagom's friend : , Chope, Jay, Joker, Nova"

// 두 번째 형태인 reduce(into:_:) 메서드의 사용

// 초깃값이 0이고 정수 배열의 모든 값을 더합니다.
// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서
// 직접 이전 값을 변경한다는 점이 다릅니다.
sum = numbers5.reduce(into: 0, { (result: inout Int, next: Int) in
    print("\(result) + \(next)")
    // 0 + 1
    // 1 + 2
    // 3 + 3
    result += next
})

print(sum)      // 6

// 초깃값이 3이고 정수 배열의 모든 값을 뺍니다.
// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서
// 직접 이전 값을 변경한다는 점이 다릅니다.
subtractFromThree = numbers5.reduce(into: 3, {
    print("\($0) - \($1)")
    // 3 - 1
    // 2 - 2
    // 0 - 3
    $0 -= $1
})

print(subtractFromThree)        // -3

// 첫 번째 리듀스 형태와 다르기 때문에 다른 컨테이너에 값을 변경하여 넣어줄 수도 있습니다.
// 이렇게 하면 맵이나 필터와 유사한 형태로 사용할 수도 있습니다.
// 홀수는 걸러내고 짝수만 두 배로 변경하여 초깃값인 [1, 2, 3] 배열에 직접 연산합니다.
var doubledNumbers3: [Int] = numbers5.reduce(into: [1, 2]) { (result: inout [Int], next: Int) in
    
    print("result: \(result) next : \(next)")
    // result: [1, 2] next : 1
    // result: [1, 2] next : 2
    // result: [1, 2, 4] next : 3
    
    guard next.isMultiple(of: 2) else {
        return
    }
    
    print("\(result) append \(next)")
    // [1, 2] append 2
    
    result.append(next * 2)
}

print(doubledNumbers3)      // [1, 2, 4]

// 필터와 맵을 사용한 모습
doubledNumbers3 = [1, 2] + numbers.filter{ $0.isMultiple(of: 2) }.map{ $0 * 2 }
print(doubledNumbers3)      // [1, 2, 4]

// 이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산합니다.
var upperCasedNames: [String]
upperCasedNames = names.reduce(into: [], {
    $0.append($1.uppercased())
})

print(upperCasedNames)      // ["CHOPE", "JAY", "JOKER", "NOVA"]

// 맵을 사용한 모습
upperCasedNames = names.map{ $0.uppercased() }
print(upperCasedNames)      // ["CHOPE", "JAY", "JOKER", "NOVA"]

// 맵, 필터,리듀스 메서드의 연계 사용
let numbers6: [Int] = [1, 2, 3, 4, 5, 6, 7]

// 짝수를 걸러내어 각 값에 3을 곱해준 후 모든 값을 더합니다.
var result: Int = numbers6.filter{ $0.isMultiple(of: 2) }.map{ $0 * 3 }.reduce(0) { $0 + $1 }
print(result)       // 36

// for-in 구문 사용 시
result = 0

for number in numbers6 {
    guard number.isMultiple(of: 2) else {
        continue
    }
    
    result += number * 3
}

print(result)       // 36

// ========== 맵, 필터, 리듀스의 활용 ==========
// 친구들의 정보 생성
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()
friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYong", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))

// 조건에 맞는 친구 결과 출력
// 서울 외의 지역에 거주하며 25세 이상인 친구
var result2: [Friend] = friends.map{
    Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1)
}

result2 = result2.filter{ $0.location != "서울" && $0.age >= 25 }

let string: String = result2.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") {
    $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"
}

print(string)
// 서울 외의 지역에 거주하며 25세 이상인 친구
// Yoobato male 발리 27세
// JiSoo male 시드니 25세
// JuHyun male 경기 31세
// JungKi unknown 대전 30세
// YoungMin male 경기 25세
