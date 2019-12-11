// ========== 모나드(Monad) ==========
/*
  프로그램에서 모나드가 갖춰야하는 조건
   * 타입을 인자로 받는 타입(특정 타입의 값을 포장)
   * 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재
   * 포장된 값을 변환하여 같은 형태로 포장하는 함수(메서드)가 존재
 */

// 모나드를 이해하는 출발점은 값을 어딘가에 포장하는 개념을 이해하는 것에서 출발합니다. 스위프트에서 모나드를 사용한 예 중에 하나가 바로 옵셔널입니다.
// 옵셔널은 값이 있을지 없을지 모르는 상태를 포장하는 것입니다.
// 함수객체(functor)와 모나드는 특정 기능이 아닌 디자인 패턴 혹은 자료구조라고 할 수 있습니다.
// 모나드를 이해하기 앞서 이해해야 할 몇 가지 개념이 있습니다.

// ========== 컨텍스트(Context) ==========
// 컨텍스트(Context)는 '콘텐츠(Contents)를 담은 그 무엇인가'를 뜻합니다.
// 컨텍스트에 대해 알아보기 전에 옵셔널을 다시 한번 되새겨볼 필요가 있습니다. 옵셔널은 열거형으로 구현되어 있어서 열거형 case의 연관 값을 통해 인스턴스 안에 연관 값을 갖는 형태입니다.
// 옵셔널에 값이 없다면 열거형의 .none case로, 값이 있다면 열거형의 .some(value) case로 값을 지니게 됩니다. 옵셔널의 값을 추출한다는 것은 열거형 인스턴스 내부의 .some(value) case의 연관 값을 꺼내오는 것과 같습니다.
// Optional은 Wrapped 타입을 인자로 받는 (제네릭)타입입니다. 즉, 앞서 살펴본 모나드의 조건 중 첫 번째 조건을 만족하는 타입입니다.
// 그리고 Optional 타입은 Optional<Int>. init(2)처럼 다른 타입(Int)의 값을 갖는 상태의 컨텍스트를 생성할 수 있으므로 모나드의 조건 중 두 번째 조건을 만족합니다.

// addThree 함수
func addThree(_ num: Int) -> Int {
    return num + 3
}

// 일반 값을 연산할 수 있는 addThree 함수
addThree(2)     // 5

// 옵셔널을 연산할 수 없는 addThree 함수
// addThree(Optional(2))       // 오류 발생!

// ========== 함수객체 ==========
// 맵은 컨테이너(컨테이너느 다른 타입의 값을 담을 수 있으므로 컨텍스트의 역할을 수행할 수 있습니다)의 값을 변형시킬 수 있는 고차함수입니다.
// 그리고 옵셔널은 컨테이너와 값을 갖기 때문에 맵 함수를 사용할 수 있습니다.

// 맵 메서드를 사용하여 옵셔널을 연산할 수 있는 addThree(_:)함수
Optional(2).map(addThree)       // Optional(5)

// 옵셔널에 맵 메서드와 클로저의 사용
var value: Int? = 2
value.map{ $0 + 3 }     // Optional(5)
value = nil
value.map{ $0 + 3 }     // nil(== Optional<Int>.none)

// 왜 맵을 언급했냐면 '함수객체(Functor)란 맵을 적용할 수 있는 컨테이너 타입'이라고 말할 수 있기 때문입니다.
// 우리가 앞서 맵을 사용해보았던 Array, Dictionary, Set 등등 스위프트의 많은 컬렉션 타입이 함수객체라는 것입니다.

// 옵셔널의 map 메서드 구현
/*
extension Optional {
    func map<U>(f: (Wrapped) -> U) -> U {
        switch self {
            case .some(let x): return f(x)
            case .none: return .none
        }
    }
}
 */
// 옵셔널의 map(_:) 메서드를 호출하면 옵셔널 스스로 값이 있는지 없는지 switch 구문으로 판단합니다.
// 값이 있다면 전달받은 함수에 자신의 값을 적용한 결과값을 다시 컨텍스트에 넣어 반환하고, 그렇지 않다면 함수를 실행하지 않고 빈 컨텍스트를 반환합니다.

// ========== 모나드 ==========
// 함수객체 중에서 자신의 컨텍스트와 같은 컨텍스트의 형태로 맵핑할 수 있는 함수객체를 닫힌 함수객체(Endofunctor)라고 합니다. 모나드(Monad)는 닫힌 함수객체입니다.
// 함수객체는 포장된 값에 함수를 적용할 수 있었습니다. 그래서 모나드도 컨텍스트에 포장된 값을 처리하여 포장된 값을 컨텍스트에 다시 반환하는 함수(맵)를 적용할 수 있습니다.
// 이 매핑의 결과가 함수객체와 같은 컨텍스트를 반환하는 함수객체를 모나드라고 할 수 있으며, 이런 맵핑을 수행하도록 플랫맵(flatMap)이라는 메서드를 활용합니다.
// 플랫맵은 맵과 같이 함수를 매개변수로 받고, 옵셔널은 모나드이므로 플랫맵을 사용할 수 있습니다.

// doubledEven(_:) 함수와 플랫맵의 사용
func doubledEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubledEven)
// nil(==Optional<Int>.none)

// map(_:) 메서드와 무슨 차이가 있는가? ( 두 메서드의 차이를 명확히 알지 못하면 map(_:)을 써야하는 경우에 flatMap(_:)을 잘못 사용하는 경우도 종종 있습니다.)
// 하지만 플랫맵은 맵과 다르게 컨텍스트 내부의 컨텍스트를 모두 같은 위상으로 평평(flat)하게 펼쳐준다는 차이가 있습니다. 즉, 포장된 값 내부의 포장된 값의 포장을 풀어서 같은 위상으로 펼쳐준다는 뜻입니다.

// 맵과 컴팩트의 차이
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map{ $0 }
let compactMapped: [Int] = optionals.compactMap{ $0 }

print(mapped)           // [Optional(1), Optional(2), nil, Optional(5)]
print(compactMapped)    // [1, 2, 5]

// optionals는 Array라는 컨테이너의 내부에 Optional이라는 형태의 컨테이너들이 여러개 들어가 있는 형태입니다. 이 배열의 맵 메서드와 플랫맵 메서드를 각각 호출해 본다면 다른 결과를 볼 수 있습니다.
// 맵 메서드를 사용한 결과는 Array 컨테이너 내부의 값 타입이나 형태가 어찌 되었든, Array 내부에 값이 있으면 그 값을 그저 클로저의 코드에서만 실행하고 결과를 다시 Array 컨테이너에 담기만 합니다.
// 그러나 플랫맵을 통해 클로저를 실행하면 알아서 내부 컨테이너까지 값을 추출합니다. 그렇기 떄문에 mapped는 다시 [Int?] 타입이 되며, compactMapped는 [Int] 타입이 됩니다.

// 중첩된 컨테이너에서 맵과 플랫맵(콤팩트맵)의 차이
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }

print(mappedMultipleContainer)
// [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]

print(flatmappedMultipleContainer)      // [1, 2, 3, 4, 5]

// 컨테이너 내부의 데이터에 다시 맵을 적용했을 때와 플랫맵을 적용했을 때의 결과는 확연히 다릅니다.
// 플래맵은 내부의 값을 1차원적으로 펼쳐놓는 작업도 하기 때문에, 값을 꺼내어 모두 동일한 위상으로 펼처놓는 모양새를 갖출 수 있습니다.
/// 그래서 값을 일자로 평평하게 펼친다(flatten)고 해서 플랫맵으로 불리는 것입니다.
// 스위프트에서 옵셔널에 관련된 여러 컨테이너의 값을 연달아 처리할 때, 바인딩을 통해 체인 형식으로 사용할 수 있기에 맵보다는 플랫맵이 더욱 유용하게 쓰일 수 있습니다.

// 플랫맵의 활용
func stringToInteger(_ string: String) -> Int? {
    return Int(string)
}

func integerToString(_ integer: Int) -> String? {
    return "\(integer)"
}

var optionalString: String? = "2"

let flattenResult = optionalString.flatMap(stringToInteger)
                                  .flatMap(integerToString)
                                  .flatMap(stringToInteger)
print(flattenResult)        // Optional(2)

let mappedResult = optionalString.map(stringToInteger)      // 더 이상 체인 연결 불가
print(mappedResult)     // Optional(Optional(2))

// 옵셔널의 맵과 플랫맵의 정의
/*
func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
*/

// 옵셔널 바인딩을 통한 연산
var result: Int?
if let string: String = optionalString {
    if let number: Int = stringToInteger(string) {
        if let finalString: String = integerToString(number) {
            if let finalNumber: Int = stringToInteger(finalString) {
                result = Optional(finalNumber)
            }
        }
    }
}

print(result)       // Optional(2)

if let string: String = optionalString,
    let number: Int = stringToInteger(string),
    let finalString: String = integerToString(number),
    let finalNumber: Int = stringToInteger(finalString) {
    
    result = Optional(finalNumber)
}

print(result)       // Optional(2)

// 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과
func integerToNil(param: Int) -> String? {
    return nil
}

optionalString = "2"

result = optionalString.flatMap(stringToInteger)
    .flatMap(integerToNil)
    .flatMap(stringToInteger)

print(result)       // nil

// flatMap(intToNil) 부분에서 nil, 즉 Optional.none을 반환받기 때문에 호출되는 메서드는 무시합니다.
// 이는 앞서 우리가 알아본 옵셔널 체이닝과 완전히 같은 동작입니다. 바로 옵셔널이 모나드이기 때문에 가능한 것입니다.
// 옵셔널 체이닝, 옵셔널 바인딩, 플랫맵 등은 모나드와 관련된 연산입니다. 스위프트의 기본 모나드 타입이 아니더라도 플랫맵 모양의 모나드 연산자를 구현하면 사용자 정의 타입(흔히 클래스 또는 구조체 등)도 모나드로 사용할 수 있습니다.
