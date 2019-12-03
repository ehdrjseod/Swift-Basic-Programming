import UIKit

// ========== 옵셔널(Optionals) ==========
// 옵셔널은 1장에서 언급한 스위프트의 특징 중 하나인 안정성(Safe)을 문법으로 담보하는 기능입니다.
// 옵셔널은 단어 뜻 그대로 "선택적인", 즉 값이 '있을 수도, 없을 수도 있음'을 나타내는 표현입니다.
// 이는 '변수나 상수 등에 꼭 값이 있다는 것을 보장할 수 없다. 즉 변수 또는 상수의 값이 nil일 수도 있다'는 것을 의미합니다.
// 스위프트에서는 옵셔널 하나만으로도 nil이 전달되어도 되는지 충분히 표현할 수 있기 때문에(문서에 명시하지 않아도)
// 문법적 표현만으로 모든 의미를 전달할 수 있습니다. 게다가 옵셔널과 옵셔널이 아닌 값은 철저히 다른 타입으로 인식하기 때문에 컴파일 할 때 바로 오류를 걸러낼 수 있습니다.

// ========== 옵셔널 사용 ==========
// Int타입의 0이나 String타입의 빈문자열("")은 갑싱 있는 것이다.
// 변수 또는 상수에 정말로 값이 없을때 nil로 표현합니다.
// 이는 함수형 프로그래밍 패러다임에서 자주 등장하는 모나드(Monad) 개념과 일맥상통합니다.
// 옵셔널을 읽을 때 "해당 변수 또는 상수에는 값이 없을 수 있다.
// 즉, 변수 또는 상수가 nil일 수도 있으므로 사용에 주의하라'는 뜻으로 직관적으로 받아들일 수 있습니다.
// 값이 없는 옵셔널 변수 또는 상수에(강제로) 접근하려면 런타임 오류가 발생합니다. 그렇게 되면 OS가 프로그램을 강제 종료시킬 확률이 매우 높습니다.

// 오류가 발생하는 nil 할당
//var myName:String = "yagom"
//myName = nil        // 오류!

// 옵셔널 변수의 선언 및 nil 할당
var myName:String? = "yagom"
print(myName)   // yagom
// 옵셔널 타입의 값을 print 함수를 통해 출력하면
// Optional("yagom")이라고 출력되는 것이 정상입니다.
// 또, 옵셔널 타입의 값을 print 함수의 매개변수로 전달하면
// 컴파일러 경고가 발생할 수 있습니다.

myName = nil
//print(myName)       // nil

// 옵셔널은 어떤 상황에 사용할까요? 왜 굳이 변수에 nil이 있음을 가정해야 할까요?
// 이 질문에 답할 수 있는 예로 우리가 만든 함수에 전달되는 전달인자의 값이 잘못된 값일 경우
// 제대로 처리하지 못했음을 nil을 반환하여 표현하는 것을 들 수 있습니다.
// 물론 기능상 심각한 오류라면 별도로 처리해야겠지만, 간단히 nil을 반환해서 오류가 있음을 알릴 수도 있습니다.
// 또는, 매개변수를 굳이 넘기지 않아도 된다는 뜻으로 매개변수의 타입을 옵셔널로 정의할 수도 있습니다.
// 스위프트 프로그래밍을 하면서 매개변수가 옵셔널일 때는 '아, 이 매개변수에는 값이 없어도 되는구나'라는 것을 API 문서를 보지 않고도 알아야 합니다.

// 원시 값을 통한 열거형 초기화

enum School:String {
    
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let primary = School(rawValue: "유치원")       // Primary
let graduate = School(rawValue: "석박사")      // nil

enum Numbers:Int {
    
    case zero
    case one
    case two
    case ten = 10
}

let one = Numbers(rawValue: 1)      // One
let three = Numbers(rawValue: 3)    // nil

// 옵셔널 열거형의 정의
/*
public enum Optional<Wrapped> : ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
    public init(_ some: Wrapped)
    // 중략....
}
 */

// switch를 통한 옵셔널 값의 확인
func checkOptionalValue(value optionalValue: Any?) {
    switch optionalValue {
        case .none:
            print("This Optional variable is nil")
        case .some(let value):
            print("Value is \(value)")
    }
    
    var myName:String? = "yagom"
    checkOptionalValue(value: myName)       // Value is yagom
    
    myName = nil
    checkOptionalValue(value: myName)       // This Optional variable is nil
}

// switch를 통한 옵셔널 값의 확인
let numbers:[Int?] = [2, nil, -4, nil, 100]

for number in numbers {
    switch number{
    case .some(let value) where value < 0 :
        print("Negative value!! \(value)")
    case .some(let value) where value > 10 :
        print("Large value!! \(value)")
    case .some(let value) :
        print("Value \(value)")
    case .none:
        print("nil")
    }
}

// ========== 옵셔널 추출(Optional Unwrapping) ==========
// 강제 추출
// 옵셔널 강제 추출(Forced Unwrapping) 방식은 옵셔널의 값을 추출하는 가장 간단하지만 가장 위험한 방법입니다.
// 런타임 오류가 일어날 가능성이 가장 높기 때문입니다. 또, 옵셔널을 만든 의미가 무색해지는 방법이기도 합니다.
// 옵셔널의 값을 강제 추출하려면 옵셔널 값의 뒤에 느낌표(!)를 붙여주면 값을 강제로 추출하여 반환해줍니다.
// 만약 강제 추출 시 옵셔널에 값이 없다면, 즉 nil이라면 런타임 오류가 발생합니다.

// 옵셔널 값의 강제 추출
myName = "yagom"

// 옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없습니다. 추출해서 할당해주어야 합니다.
var yagom:String = myName!

myName = nil
//yagom = myName!     // 런타임 오류!

// if 구문 등 조건문을 이용해서 조금 더 안전하게 처리해볼 수 있습니다.
if myName != nil {
    print("My name is \(myName!)")
} else {
    print("myName == nil")
}
// 런타임 오류의 가능성을 항상 내포하기 때문에 옵셔널 강제 추출 방식은 사용하는 것을 지양해야 합니다.

// 옵셔널 바인딩(Optional Binding)
// 옵셔널 바인딩을 사용한 옵셔널 값의 추출
myName = "yagom"

// 옵셔널 바인딩을 통한 임시 상수 할당
if let name = myName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// My name is yagom

// 옵셔널 바인딩을 통한 임시 변수 할당
if var name = myName {
    name = "wizplan"        // 변수이므로 내부에서 변경이 가능합니다.
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// My name is wizplan

// 옵셔널 바인딩을 사용한 여러 개의 옵셔널 값의 추출
myName = "yagom"
var yourName:String? = nil

// friend에 바인딩이 되지 않으므로 실행되지 않습니다.
if let name = myName, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}

yourName = "eric"

if let name = myName, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}
// We are friend! yagom & eric

// 암시적 추출 옵셔널(Implicitly Unwrapped Optionals)
// 때때로 nil을 할당하고 싶지만, 옵셔널 바인딩으로 매번 값을 추출하기 귀찮거나 로직상 nil 때문에
// 런타임 오류가 발생하지 않을 것 같다는 확신이 들 때(매우 위험한 생각) nil을 할당해줄 수 있는 옵셔널이 아닌
// 변수나 상수가 있으면 좋을 겁니다. 이때 사용하는 것이 바로 암시적 추출 옵셔널입니다.
// 옵셔널을 표시하고자 타입 뒤에 물음표(?)를 사용했지만, 암시적 추출 옵셔널을 사용하려면 타입 뒤에 느낌표(!)를 사용해주면 됩니다.
// 암시적 추출 옵셔널로 지정된 타입은 일반 값처럼 사용할 수 있으나, 여전히 옵셔널이기 때문에 nil도 할당해줄 수 있습니다.
// 그러나 nil이 할당되어 있을 때 접근을 시도하면 런타임 오류가 발생합니다.

// 암시적 추출 옵셔널의 사용
var myName2:String! = "yagom"
print(myName2)      // yagom
myName2 = nil

// 암시적 추출 옵셔널도 옵셔널이므로 당연히 바인딩을 사용할 수 있습니다.
if let name = myName2 {
    print("My name2 is \(name)")
} else {
    print("myName2 == nil")
}
// myName2 == nil

//myName2.isEmpty // 오류
// 옵셔널을 사용할 때는 강제 추출 또는 암시적 추출 옵셔널을 사용하기보다는 옵셔널 바인딩, nil 병합 연산자를 비롯해
// 뒤에서 배울 옵셔널 체이닝 등의 방법을 사용하는 편이 훨씬 안전합니다. 또한 이렇게 하는 편이 스위프트의 지향점에 부합합니다.
