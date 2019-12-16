// ========== ARC(Automatic Reference Counting) ==========
// 매번 전달할 때마다 값을 복사해 전달하는 값 타입과는 달리 참조 타입은 하나의 인스턴스가 참조를 통해 여러 곳에서 접근하기 때문에 언제 메모리에서 해제되는지가 중요한 문제입니다.
// 인스턴스가 적절한 시점에 메모리에서 해제되지 않으면 한정적인 메모리 자원을 낭비하게 되며, 이는 성능의 저하로 이어지게 됩니다.
// 스위프트는 프로그램의 메모리 사용을 관리하기 위하여 메모리 관리 기법인 ARC를 사용합니다.
/*
  [NOTE] ARC와 값 타입
  ARC가 관리해주는 참조 횟수 계산(Reference Counting)은 참조 타입인 클래스의 인스턴스에만 적용됩니다.
  구조체나 열거형은 값 타입이므로 참조 횟수 계산과 무관합니다. 즉, 구조체나 열거형은 다른 곳에서 참조하지 않기 때문에 ARC로 관리할 필요가 없습니다.
*/

// ========== ARC란? ==========
// ARC 기능은 이름에서 알 수 있듯이 자동으로 메모리를 관리해주는 방식입니다. 아무래도 프로그래머가 메모리 관리에 신경을 덜 쓸 수 있기에 편리합니다.
// ARC는 더이상 필요하지 않은 클래스의 인스턴스를 메모리에서 해제하는 방식으로 동작합니다.

// ARC(Automatic Reference Counting)와 가비지 컬렉션(Garbage Collection)의 차이
/*
  ARC(Automatic Reference Counting)
   * 참조 카운팅 시점 : 컴파일 시
   * 장점 : 1) 컴파일 당시 이미 인스턴스의 해제 시점이 정해져 있어서 인스턴스가 언제 메모리에서 해제될지 예측할 수 있습니다.
           2) 컴파일 당시 이미 인스턴스의 해제 시점이 정해져 있어서 메모리 관리를 위한 시스템 자원을 추가할 필요가 없습니다.
   * 단점 : 1) ARC의 작동 규칙을 모르고 사용하면 인스턴스가 메모리에서 영원히 해제되지 않을 가능성이 있습니다.
 
  가비지 컬렉션(Garbage Collection)
   * 참조 카운팅 시점 : 프로그램 동작 중
   * 장점 : 1) 상호 참조 상황 등의 복잡한 상황에서도 인스턴스를 해제할 수 있는 가능성이 더 높습니다.
           2) 특별히 규칙에 신경 쓸 필요가 없습니다.
   * 단점 : 1) 프로그램 동작 외에 메모리 감시를 위한 추가 자원이 필요하므로 한정적인 자원 환경에서는 성능 저하가 발생할 수 있습니다.
           2) 명확한 규칙이 없기 때문에 인스턴스가 정확히 언제 메모리에서 해제될지 예측하기 어렵습니다.
*/

// 우리가 ARC를 이용해 자동으로 메모리 관리를 받기 위해서는 몇 가지 규칙을 알아야 합니다.
// 왜냐하면 가비지 컬렉션과 달리 ARC는 컴파일과 동시에 인스턴스를 메모리에서 해제하는 시점을 결정하기 때문입니다.
// 우리가 원하는 방향으로 메모리 관리가 이루어지려면 ARC에 명확한 힌트를 주어야 합니다.
// 클래스의 인스턴스를 생성할 때마다 ARC는 그 인스턴스에 대한 정보를 저장하기 위한 메모리 공간을 따로 또 할당합니다.
// 그 메모리 공간에는 인스턴스의 타입 정보와 함께 그 인스턴스와 관련된 저장 프로퍼티의 값 등을 저장합니다.
// 그 후에 인스턴스가 더 이상 필요 없는 상태가 되면 인스턴스가 차지하던 메모리 공간을 다른 용도로 활용할 수 있도록 ARC가 메모리에서 인스턴스를 없앱니다.
// 인스턴스가 지속해서 필요한 상황에서 ARC는 인스턴스가 메모리에서 해제되지 않도록 인스턴스 참조 여부를 계속 추적합니다.
// 다른 인스턴스의 프로퍼티나 변수, 상수 등 어느 한 곳에서 인스턴스를 참조한다면 ARC가 해당 인스턴스를 해제하지 않고 유지해야 하는 명분이 됩니다.
// 인스턴스를 메모리에 유지시키려면 이런 명분을 ARC에 제공해야 한다는 것을 명심해야 합니다.

// ========== 강한참조(Strong Reference) ==========
// 인스턴스가 계속해서 메모리에 남아있어야 하는 명분을 만들어 주는 것이 바로 강한참조(Strong Reference) 입니다.
// 인스턴스는 참조 횟수가 0이 되는 순간 메모리에서 해제되는데, 인스턴스를 다른 인스턴스의 프로퍼티나 변수, 상수 등에 할당할 때 강한참조를 사용하면 참조 횟수가 1 증가합니다.
// 또, 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당해주면 원래 자신에게 할당되어 있던 인스턴스의 참조 횟수가 1 감소합니다.
// 참조의 기본은 강한참조이므로 클래스 타입의 프로퍼티, 변수, 상수 등을 선언할 때 별도의 식별자를 명시하지 않으면 강한참조를 합니다.

// 강한참조의 참조 횟수 확인
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "yagom")
// yagom is being initialized
// 인스턴스의 참조 횟수 : 1

reference2 = reference1     // 인스턴스의 참조 횟수 : 2
reference3 = reference1     // 인스턴스의 참조 횟수 : 3

reference3 = nil            // 인스턴스의 참조 횟수 : 2
reference2 = nil            // 인스턴스의 참조 횟수 : 1
reference1 = nil            // 인스턴스의 참조 횟수 : 0
// yagom is being deinitialized

// 강한참조 지역변수(상수)의 참조 횟수 확인
func foo() {
    let yagom: Person = Person(name: "yagom foo")       // yagom foo is being initialized
    // 인스턴스의 참조 횟수 : 1
    
    // 함수 종료 시점
    // 인스턴스의 참조 횟수 : 0
    // yagom foo is being deinitialized
}

foo()

// 강한참조 지역변수(상수)의 참조 횟수 확인과 전역변수
var globalReference: Person?

func foo2() {
    let yagom: Person = Person(name: "yagom foo2")       // yagom foo2 is being initialized
    // 인스턴스의 참조 횟수 : 1
    
    globalReference = yagom     // 인스턴스의 참조 횟수 : 2
    
    // 함수 종료 시점
    // 인스턴스의 참조 횟수 : 1
}

foo2()

// 강한참조 순환 문제(Strong Reference Cycle)
// 복합적으로 강한참조가 일어나는 상황에서 강한참조의 규칙을 모르고 사용하게 되면 문제가 발생할 수 있습니다.
// 인스턴스끼리 서로가 서로를 강한참조할 때를 대표적인 예로 들 수 있습니다. 이를 강한참조 순환(Strong Reference Cycle)이라고 합니다.


// 강한참조 순환 문제
class Person2 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room2: Room2?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Room2 {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    var host: Person2?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom: Person2? = Person2(name: "yagom")        // Person2 인스턴스의 참조 횟수 : 1
var room: Room2? = Room2(number: "505")             // Room2 인스턴스의 참조 횟수 : 1

room?.host = yagom     // Person2 인스턴스의 참조 횟수 : 2
yagom?.room2 = room      // Room2 인스턴스의 참조 횟수 : 2

yagom = nil             // Person2 인스턴스의 참조 횟수 : 1
room = nil              // Room2 인스턴스의 참조 횟수 : 1

// Person 인스턴스를 참조할 방법 상실 - 메모리에 잔존
// Room2 인스턴스를 참조할 방법 상실 - 메모리에 잔존

// 강한참조 순환 문제를 수동으로 해결
var yagom2: Person2? = Person2(name: "yagom2")      // Person2 인스턴스의 참조 횟수 : 1
var room2: Room2? = Room2(number: "505")            // Room2 인스턴스의 참조 횟수 : 1

room2?.host = yagom2            // Person 인스턴스의 참조 횟수 : 2
yagom2?.room2 = room            // Room2 인스턴스의 참조 횟수 : 2

yagom2?.room2 = nil             // Room 인스턴스의 참조 횟수 : 1
yagom2 = nil                    // Person2 인스턴스의 참조 횟수 : 1

room2?.host = nil               // Person2 인스턴스의 참조 횟수 : 0
// yagom2 is being deinitialized

room2 = nil                     // Room2 인스턴스의 참조 횟수 : 0
// Room2 505 is being deinitialized

// ========== 약한참조(Weak Reference) ==========
// 약한참조(Weak Reference)는 강한참조와 달리 자신이 참조하는 인스턴스의 참조 횟수를 증가시키지 않습니다.
// 참조 타입의 프로퍼티나 변수의 선언 앞에 weak 키워드를 써주면 그 프로퍼티나 변수는 자신이 참조하는 인스턴스를 약한참조합니다.
// 약한 참조를 사용한다면 자신이 참조하는 인스턴스가 메모리에서 해제될 수도 있다는 것을 예상해볼 수 있어야 합니다.
// 자신이 참조 횟수를 증가시키지 않았기 때문에 그 인스턴스를 강한 참조하던 프로퍼티나 변수에서 참조 횟수를 감소시켜 0으로 만들면 자신이 참조하던 인스턴스가 메모리에서 해제되기 때문입니다.
/*
  [NOTE] 약한참조와 상수, 옵셔널
   약한참조는 상수에서 쓰일 수 없습니다. 만약 자신이 참조하던 인스턴스가 메모리에서 해제된다면 nil이 할당될 수 있어야 하기 때문입니다.
   그래서 약한참조를 할 때는 자신이 값을 변경할 수 있는 변수로 선언해야 합니다. 더불어 nil이 할당될 수 있어야 하므로 약한참조는 항상 옵셔널이어야 합니다.
   즉, 옵셔널 변수만 약한참조를 할 수 있습니다.
*/

// 강한참조 순환 문제를 약한참조로 해결
class Person3 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room: Room3?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Room3 {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    weak var host: Person?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom3: Person3? = Person3(name: "yagom3")      // Person2 인스턴스의 참조 횟수 : 1
var room3: Room3? = Room3(number: "505")            // Room3 인스턴스의 참조 횟수 : 1

room3?.host = yagom3        // Person3 인스턴스의 참조 횟수 : 1
yagom3?.room = room3        // Room3 인스턴스의 참조 횟수 : 2

yagom3 = nil                // Person3 인스턴스의 참조 횟수 : 0, Room3 인스턴스의 참조 횟수 : 1
// yagom3 is being deinitialized
print(room3?.host)          // nil

room3 = nil                 // Room 인스턴스의 참조 횟수 : 0
// Room 505 is being deinitialized

// ========== 미소유참조(Unowned Reference) ==========
