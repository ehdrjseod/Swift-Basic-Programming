import UIKit

// ========== 프로퍼티와 메서드 ==========
// 프로퍼티 : 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻함.
// 메서드 : 특정 타입에 관련된 함수를 뜻함.

// ========== 프로퍼티 ==========
// 프로퍼티는 크게 저장 프로퍼티(Stored Properties), 연산 프로퍼티(Computed Properties), 타입 프로퍼티(Type Properties)로 나눌 수 있습니다.
// 저장 프로퍼티(Stored properties) : 인스턴스의 변수 또는 상수를 의미합니다, 구조체와 클래스에서만 사용할 수 있습니다.
// 연산 프로퍼티(Computed Properties) : 클래스, 구조체, 열거형에 쓰일 수 있습니다.
// 타입 프로퍼티(Type Properties) : 특정 타입에 사용되는 프로퍼티
// 프로퍼티 감시자(Property Observers) : 프로퍼티의 값이 변하는 것을 감시함. -> 프로퍼티의 값이 변할 때, 값의 변화에 따른 특정 작업을 실행함.

// 저장 프로퍼티(Stored properties)
// 클래스 또는 구조체의 인스턴스와 연관된 값을 저장하는 가장 단순한 개념의 프로퍼티입니다.
// 저장 프로퍼티는 var 키워드를 사용하면 변수 저장 프로퍼티, let 키워드를 사용하면 상수 저장 프로퍼티가 됩니다.
// 저장 프로퍼티를 정의할 때 프로퍼티 기본값과 초깃값을 지정해줄 수 있습니다.
/*
 [NOTE] 구조체와 클래스의 저장 프로퍼티
  구조체의 저장 프로퍼티가 옵셔널이 아니더라도, 구조체는 저장 프로퍼티를 모두 포함하는 이니셜라이저를 자동으로 생성합니다.
  하지만 클래스의 저장 프로퍼티는 옵셔널이 아니라면 프로퍼티 기본값을 지정해주거나 사용자 정의 이니셜라이저를 통해 반드시 초기화해주어야 합니다.
  또, 클래스 인스턴스의 상수 프로퍼티는 인스턴스가 초기화(이니셜라이즈)될 때 한번만 값을 할당할 수 있으며, 자식클래스에서 이 초기화를 변경(재정의)할 수 없습니다.
 */

// 저장 프로퍼티의 선언 및 인스턴스 생성
// 좌표
struct CoordinatePoint {
    var x:Int   // 저장 프로퍼티
    var y:Int   // 저장 프로퍼티
}

// 구조체에는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있습니다.
let yagomPoint:CoordinatePoint = CoordinatePoint(x: 10, y: 5)

// 사람의 위치 정보
class Position {
    var point: CoordinatePoint
    
    // 저장 프로퍼티(변수) - 위치(point)는 변경될 수 있음을 뜻합니다.
    let name: String        // 저장 프로퍼티 (상수)
    
    // 프로퍼티 기본값을 지정해주지 않는다면 이니셜라이저를 따로 정의해주어야 합니다.
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}
// 사용자 정의 이니셜라이저를 호출해야만 합니다.
// 그렇지 않으면 프로퍼티 초깃값을 할당할 수 없기 때문에 인스턴스 생성이 불가능합니다.
let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)

// 저장 프로퍼티의 초깃값 지정
// 좌표
struct CoordinatePoint2 {
    var x: Int = 0      // 저장 프로퍼티
    var y: Int = 0      // 저장 프로퍼티
}

// 프로퍼티의 초깃값을 할당했다면 굳이 전달인자로 초깃값을 넘길 필요가 없습니다.
let yagomPoint2:CoordinatePoint2 = CoordinatePoint2()

// 물론 기존에 초깃값을 할당할 수 있는 이니셜라이저도 사용 가능합니다.
let wizplanPoint: CoordinatePoint2 = CoordinatePoint2(x: 10, y: 5)

print("yagom's point : \(yagomPoint2.x) , \(yagomPoint2.y)")
// yagom's point : 0, 0

print("wizplan's point : \(wizplanPoint.x), \(wizplanPoint.y)")
// wizplan's point : 10, 5
// 사람의 위치 정보
class Position2 {
    var point: CoordinatePoint2 = CoordinatePoint2()    // 저장 프로퍼티
    var name: String = "Unknown"                        // 저장 프로퍼티
}

// 초깃값을 지정해줬다면 사용자 정의 이니셜라이저를 사용하지 않아도 됩니다.
let yagomPosition2: Position2 = Position2()

yagomPosition2.point = yagomPoint2
yagomPosition2.name = "yagom"

// 옵셔널 저장 프로퍼티
// 좌표
struct CoordinatePoint3 {
    // 위치는 x, y 값이 모두 있어야 하므로 옵셔널이면 안 됩니다.
    var x: Int
    var y: Int
}

// 사람의 위치 정보
class Position3 {
    // 현재사람의 위치를 모를 수도 있습니다. - 옵셔널
    var point: CoordinatePoint3?
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

// 이름은 필수지만 위치는 모를 수 있습니다.
let yagomPosition3: Position3 = Position3(name: "yagom")

// 위치를 알게되면 그 때 위치 값을 할당해줍니다.
yagomPosition3.point = CoordinatePoint3(x: 20, y: 10)

// 지연 저장 프로퍼티(Lazy Stored Properties)
// 인스턴스를 생성할 때 프로퍼티에 값이 필요 없다면 프로퍼티를 옵셔널로 선언해줄 수 있습니다.
// 그런데 그것과는 조금 다른용도로 필요할 때 값이 할당되는 지연 저장 프로퍼티(Lazy Stored Properties)가 있습니다.
// 지연 저장 프로퍼티는 호출이 있어야 값을 초기화하며, 이때 lazy 키워드를 사용합니다.
// 상수는 인스턴스가 완전히 생성되기 전에 초기화해야 하므로 필요할 때 값을 할당하는 지연 프로퍼티와는 맞지 않습니다.
// 따라서 지연 저장 프로퍼티는 var 키워드를 사용하여 변수로 정의합니다.
// 지연 저장 프로퍼티는 주로 복잡한 클래스나 구조체를 구현할 때 많이 사용됩니다.
// 클래스 인스턴스의 저장 프로퍼티로 다른 클래스 인스턴스나 구조체 인스턴스를 할당해야 할 때가 있습니다.
// 이럴 때 인스턴스를 초기화하면서 저장 프로퍼티로 쓰이는 인스턴스들이 한 번에 생성되어야 한다면? 또, 굳이 모든 저장 프로퍼티를 사용할 필요가 없다면? 이 질문의 답이 지연 저장 프로퍼티 사용입니다.
// 지연 저장 프로퍼티를 잘 사용하면 불필요한 성능저하나 공간 낭비를 줄일 수 있습니다.

// 지연 저장 프로퍼티
struct CoordinatePoint4 {
    var x: Int = 0
    var y: Int = 0
}

class Position4 {
    lazy var point: CoordinatePoint4 = CoordinatePoint4()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let yagomPosition4: Position4 = Position4(name: "yagom")

// 이 코드를 통해 point 프로퍼티로 처음 접근할 때
// point 프로퍼티의 CoordinatePoint가 생성됩니다.
print(yagomPosition4.point)     // x: 0, y: 0

/*
 [NOTE] 다중 스레드와 지연 저장 프로퍼티
  다중 스레드 환경에서 지연 저장 프로퍼티에 동시다발적으로 접근할 때는 한 번만 초기화된다는 보장이 없습니다.
  생성되지 않은 지연 저장 프로퍼티에 많은 스레드가 비슷한 시점에 접근한다면, 여러 번 초기활 될 수 있습니다.
 */

// 연산 프로퍼티(Computed Properties)
// 연산 프로퍼티는 실제 값을 저장하는 프로퍼티가 아니라, 특정 상태에 따른 값을 연산하는 프로퍼티입니다.
// 인스턴스 내/외부의 값을 연산하여 적절한 값을 돌려주는 접근자(getter)의 역할이나 은닉화된 내부의 프로퍼티 값을 간접적으로 설정하는 설정자(setter)의 역할을 할 수도 있습니다.
// 클래스, 구조체, 열거형에 연산 프로퍼티를 정의할 수 있습니다.
// 인스턴스 외부에서 메서드를 통해 인스턴스 내부 값에 접근하려면 메서드를 두 개(접근자, 설정자) 구현해야 합니다. 또한 이를 감수하고 메서드를 구현한다 해도
// 두 메서드가 분산 구현되어 코드의 가독성이 나빠질 위험이 있습니다. 타인의 코드를 보는 프로그래머의 입장에서는 프로퍼티가 메서드 형식보다 훨씬 더 간편하고 직관적이기도 합니다.
// 다만 연산 프로퍼티는 접근자인 get 메서드만 구현해둔 것처럼 읽기 전용 상태로 구현하기 쉽지만, 쓰기 전용 상태로 구현할 수 없다는 단점이 있습니다.
// 메서드로는 설정자 메서드만 구현하여 쓰기 전용 상태로 구현할 수 있지만, 연산 프로퍼티는 그것이 불가능합니다.

// 메서드로 구현된 접근자와 설정자
struct CoordinatePoint5 {
    var x: Int      // 저장 프로퍼티
    var y: Int      // 저장 프로퍼티
    
    // 대칭점을 구하는 메서드 - 접근자
    // Self는 타입 자기 자신을 뜻합니다.
    // Self 대신 CoordinatePoint를 사용해도 됩니다.
    func oppositePoint() -> Self {
        return CoordinatePoint5(x: -x, y: -y)
    }
    
    // 대칭점을 설정하는 메서드 - 설정자
    // mutating 키워드에 관한 내용은 10.2.1절에서 다룸
    mutating func setOppositePoint(_ opposite: CoordinatePoint5) {
        x = -opposite.x
        y = -opposite.y
    }
}

var yagomPosition5: CoordinatePoint5 = CoordinatePoint5(x: 10, y: 20)

// 현재 좌표
print(yagomPosition5)        // 10, 20

// 대칭 좌표
print(yagomPosition5.oppositePoint())       // -10, -20

// 대칭 좌표를 (15, 10)으로 설정하면
yagomPosition5.setOppositePoint(CoordinatePoint5(x: 15, y: 10))

// 현재 좌표는 -15, -10으로 설정됩니다.
print(yagomPosition5)       // -15, -10

// 연산 프로퍼티의 정의와 사용
struct CoordinatePoint6 {
    var x: Int  // 저장 프로퍼티
    var y: Int  // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint6 {       // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint6(x: -x, y: -y)
        }
        
        // 설정자
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var yagomPosition6: CoordinatePoint6 = CoordinatePoint6(x: 10, y: 20)

// 현재 좌표
print(yagomPosition6)       // 10, 20

// 대칭 좌표
print(yagomPosition6.oppositePoint)     // -10, -20

// 대칭 좌표를 (15, 10)으로 설정하면
yagomPosition6.oppositePoint = CoordinatePoint6(x: 15, y: 10)

// 현재 좌표는 -15, -10으로 설정됩니다.
print(yagomPosition6)       // -15, -10

// 매개변수 이름을 생략한 설정자
struct CoordinatePoint7 {
    var x: Int      // 저장 프로퍼티
    var y: Int      // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint7 {       // 연산 프로퍼티
        
        // 접근자
        get {
            // 이곳에서 return 키워드를 생략할 수 있습니다.
            return CoordinatePoint7(x: -x, y: -y)
        }
        
        // 설정자
        set {
            x = -newValue.x
            y = -newValue.y
        }
    }
}

// 읽기 전용 연산 프로퍼티
struct CoordinatePoint8 {
    var x: Int      // 저장 프로퍼티
    var y: Int      // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint8 {   // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint8(x: -x, y: -y)
        }
    }
}

var yagomPosition8: CoordinatePoint8 = CoordinatePoint8(x: 10, y: 20)

// 현재 좌표
print(yagomPosition8)                   // 10, 20

// 대칭 좌표
print(yagomPosition8.oppositePoint)     // -10, -20

// 설정자를 구현하지 않았으므로 오류!!
//yagomPosition8.oppositePoint = CoordinatePoint8(x: 15, y: 10)


// 프로퍼티 감시자(Property Observers)
// 프로퍼티 감시자(Property Observers)를 사용하면 프로퍼티의 값이 변경됨에 따라 적절한 작업을 취할 수 있습니다.
// 프로퍼티 감시자는 프로퍼티의 값이 새로 할당될 때마다 호출합니다. 이때 변경되는 값이 현재의 값과 같더라도 호출합니다.
// 프로퍼티 감시자는 지연 저장 프로퍼티에 사용할 수 없으며 오로지 일반 저장 프로퍼티에만 적용할 수 있습니다.
// 또한 프로퍼티 재정의 해 상속받은 저장 프로퍼티 또는 연산 프로퍼티에도 적용할 수 있습니다.
// 물론 상속받지 않은 연산 프로퍼티에는 프로퍼티 감시자를 사용할 필요가 없으며 할 수도 없습니다.
// 연산 프로퍼티의 접근자와 설정자를 통해 프로퍼티 감시자를 구현할 수 있기 때문입니다.
// 연산 프로퍼티는 상속 받았을 때만 프로퍼티 재정의를 통해 프로퍼티 감시자를 사용합니다.
// willSet : 프로퍼티의 값이 변경되기 직전에 호출 / 전달되는 전달인자는 프로퍼티가 변경될 값 / 매개변수의 이름을 따로 지정하지 않으면 newValue로 지정
// didSet : 프로퍼티의 값이 변경된 직후에 호출 / 전달되는 전달인자는 프로퍼티가 변경되기 전의 값 / 매개변수의 이름을 따로 지정하지 않으면 oldValue로 지정

// 프로퍼티 감시자
class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
}

let myAccount: Account = Account()
// 잔액이 0원에서 1000원으로 변경될 예정입니다.

myAccount.credit = 1000
// 잔액이 0원에서 1000원으로 변경되었습니다.

// 클래스를 상속받았다면 기존의 연산 프로퍼티를 재정의하여 프로퍼티 감시자를 구현할 수도 있습니다.
// 연산 프로퍼티를 재정의해도 기존의 연산 프로퍼티 기능(접근자와 설정자, get과 set 메서드)은 동작합니다.

// 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현
class Account2 {
    var credit: Int = 0 {   // 저장 프로퍼티
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double {       // 연산 프로퍼티
        get {
            return Double(credit)       // 1000.0
        }
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

class ForeignAccount: Account2 {
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
        }
    }
}

let myAccount2: ForeignAccount = ForeignAccount()
// 잔액이 0원에서 1000원으로 변경될 예정입니다.

myAccount2.credit = 1000
// 잔액이 0원에서 1000원으로 변경되었습니다.

// 잔액이 1.0달러에서 2.0달러로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경되었습니다.

myAccount2.dollarValue = 2      // 잔액을 2.0달러로 변경 중입니다.
// 잔액이 1.0달러에서 2.0달러로 변경되었습니다.

/*
 [NOTE] 입출력 매개변수와 프로퍼티 감시자
  만약 프로퍼티 감시자가 있는 프로퍼티를 함수의 입출력 매개변수의 전달인자로 전달한다면 항상 willSet과 didSet 감시자를 호출합니다.
  함수 내부에서 값이 변경되든 되지 않든 간에 함수가 종료되는 시점에 값을 다시 쓰기 때문입니다.
 */

// 전역변수와 지역변수
// 연산 프로퍼티와 프로퍼티 감시자는 전역변수와 지역변수 모두에 사용할 수 있습니다.
// 따라서 프로퍼티에 한정하지 않고, 전역에서 쓰일 수 있는 변수와 상수에도 두 기능을 사용할 수 있습니다.
// 함수나 메서드, 클로저, 클래스, 구조체, 열거형 등 범위 안에 포함되지 않았던 변수나 상수, 즉 우리가 프로퍼티를 다루기 전에 계속해서 사용했던 변수와 상수는 모두 전역변수 또는 전역 상수에 해당됩니다.
// 이제까지 변수라고 통칭했던 전역변수 또는 지역변수는 저장변수라고 할 수 있습니다.
// 저장변수는 마치 저장 프로퍼티처럼 값을 저장하는 역할을 합니다. 그런데 전역변수나 지역변수를 연산변수로 구현할 수도 있으며, 프로퍼티 감시자를 구현할 수도 있습니다.
// 전역변수 또는 전역상수는 지연 저장 프로퍼티처럼 처음 접근할 때 최초로 연산이 이루어집니다. laze 키워드를 사용하여 연산을 늦출 필요가 없습니다.
// 반대로 지역변수 및 지역상수는 절대로 지연 연산되지 않습니다.

// 저장변수의 감시자와 연산변수
var wonInPocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double {
    get {
        return Double(wonInPocket)  // 1000.0
    }
    
    set {
        wonInPocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

// 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
// 주머니의 돈이 2000원에서 3500원으로 변경되었습니다.
dollarInPocket = 3.5    // 주머니의 달러를 3.5달러로 변경 중입니다.

// 타입 프로퍼티 : 각각의 인스턴스가 아닌 타입 자체에 속하는 프로퍼티
// 타입 프로퍼티는 타입 자체에 영향을 미치는 프로퍼티입니다. 인스턴스의 생성 여부와 상관없이 타입 프로퍼티의 값은 하나이며,
// 그 타입의 모든 인스턴스가 공통으로 사용하는 값(C언어의 static constant와 유사), 모든 인스턴스에서 공용으로 접근하고 값을 변경할 수 있는 변수(C언어의 static 변수와 유사) 등을 정의할 때 유용합니다.
// 저장 타입 프로퍼티 -> 변수 또는 상수로 선언, 반드시 초깃값을 설정해야 하며 지연 연산 / 연산 타입 프로퍼티 -> 변수로만 선언

// 타입 프로퍼티와 인스턴스 프로퍼티
class AClass {
    // 저장 타입 프로퍼티
    static var typeProperty: Int = 0
    
    // 저장 인스턴스 프로퍼티
    var instanceProperty: Int = 0 {
        didSet {
            // Self.typeProperty는
            // AClass.typeProperty와 같은 표현입니다.
            Self.typeProperty = instanceProperty + 100
        }
    }
    
    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        
        get {
            return typeProperty
        }
        set {
            typeProperty = newValue
        }
    }
}

AClass.typeProperty = 123

let classInstance: AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty)      // 200
print(AClass.typeComputedProperty)      // 200

// 타입 프로퍼티의 사용
class Account3 {
    
    static let dollarExchangeRate: Double = 1000.0  // 타입 상수
    
    var credit: Int = 0     // 저장 인스턴스 프로퍼티
    
    var dollarValue: Double {   // 연산 인스턴스 프로퍼티
        get {
            // Self.dollarExchangeRate 는
            // Account.dollarExchangeRate와 같은 표현입니다.
            return Double(credit) / Self.dollarExchangeRate
        }
        
        set {
            // Self.dollarExchangeRate는
            // Account.dollarExchangeRate와 같은 표현입니다.
            credit = Int(newValue * Account3.dollarExchangeRate)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

// 키 경로(key Path)
func someFunction(paramA: Any, paramB: Any) {
    print("someFunction called...")
}

var functionReference = someFunction(paramA:paramB:)

functionReference("A", "B")     // someFunction called....
//functionReference = anotherFunction(paramA:paramB:)

// 프로퍼티도 이처럼 값을 바로 꺼내오는 것이 아니라 어떤 프로퍼티의 위치만 참조하도록 할 수 있습니다.
// 키 경로를 사용하여 간접적으로 특정 타입의 어떤 프로퍼티 값을 가리켜야 할지 미리 지정해두고 사용할 수 있습니다.
// 키 경로 타입은 AnyKeyPath라는 클래스로부터 파생됩니다. 제일 많이 확장된 키 경로 타입은 WritableKeyPath<Root, Value>와 ReferenceWritableKeyPath<Root, Value>타입입니다.
// WritableKeyPath<Root, Value> 타입은 값 타입에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용되며, ReferenceWritableKeyPath<Root, Value> 타입은 참조타입, 즉 클래스 타입에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용
// \타입이름.경로.경로.경로 -> 여기서 경로는 프로퍼티 이름이라고 생각하면 됨.

// 키 경로 타입의 타입 확인
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

print(type(of: \Person.name))       // ReferenceWritableKeyPath<Person, String>
print(type(of: \Stuff.name))        // WritableKeyPath<Stuff, String>

// 키 경로 타입의 경로 연결
let keyPath = \Stuff.owner
let nameKeyPath = keyPath.appending(path: \.name)

// keyPath 서브스크립트와 키 경로 활용
let yagom = Person(name: "yagom")
let hana = Person(name: "hana")
let macbook = Stuff(name: "MacBook Pro", owner: yagom)
var iMac = Stuff(name: "iMac", owner: yagom)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerkeyPath = \Stuff.owner

// \Stuff.owner.name과 같은 표현이 됩니다.
let ownerNameKeyPath = ownerkeyPath.appending(path: \.name)

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져옵니다.
print(macbook[keyPath: stuffNameKeyPath])       // MacBook Pro
print(iMac[keyPath: stuffNameKeyPath])          // iMac
print(iPhone[keyPath: stuffNameKeyPath])        // iPhone

print(macbook[keyPath: ownerNameKeyPath])       // yagom
print(iMac[keyPath: ownerNameKeyPath])          // yagom
print(iPhone[keyPath: ownerNameKeyPath])        // hana

// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경합니다.
iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerkeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath])          // iMac Pro
print(iMac[keyPath: ownerNameKeyPath])          // hana

// 상수로 지정한 값 타입과 읽기 전용 프로퍼티는 키 경로 서브스크립트로도 값을 바꿔줄 수 없습니다.
// macbook[keyPath: stuffNameKeyPath] = "macbook pro touch bar"        // 오류 발생!
// yagom[keyPath: \Person.name] = "bear"       // 오류 발생!

// 접근수준과 키 경로
// 키 경로는 타입 외부로 공개된 인스턴스 프로퍼티 혹은 서브스크립트에 한하여 표현할 수 있습니다.
// 자신을 나타내는 키 경로인 \.self를 사용하면 인스턴스 그 자체를 표현하는 키 경로가 됩니다. 또, 컴파일러가 타입을 유추할 수 있는 경우에는 키 경로에서 타입 이름을 생략할 수도 있습니다.

// ========== 메서드 ==========
// 메서드 : 특정 타입에 관련된 함수
// 클래스, 구조체, 열거형 등은 실행하는 기능을 캡슐화한 인스턴스 메서드를 정의할 수 있습니다.
// 또한, 타입 자체와 관련된 기능을 실행하는 타입 메서드를 정의할 수도 있습니다. 타입 메서드는 기존의 프로그래밍 언어에서의 클래스 메서드와 유사한 개념입니다.
// 구조체와 열거형이 메서드를 가질 수 있다는 것은 기존 프로그래밍 언어와 스위프트간의 큰 차이점입니다.
// 스위프트에서는 프로그래머가 정의하는 타입(클래스, 구조체, 열거형 등)에 자유롭게 메서드를 정의할 수 있습니다.

// 인스턴스 메서드
// 인스턴스 메서드 : 특정 타입의 인스턴스에 속한 함수
// 인스턴스 내부의 프로퍼티 값을 변경하거나 특정 연산 결과를 반환하는 등 인스턴스와 관련된 기능을 실행
// 인스턴스 메서드는 함수와 달리 특정 타입 내부에 구현합니다. 따라서 인스턴스가 존재할 때만 사용할 수 있습니다.

// 클래스의 인스턴스 메서드
class LevelClass {
    // 현재 레벨을 저장하는 저장 프로퍼티
    var level: Int = 0 {
        // 프로퍼티 값이 변경되면 호출하는 프로퍼티 감시자
        didSet {
            print("Level \(level)")
        }
    }
    
    // 레벨이 올랐을 때 호출할 메서드
    func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    // 레벨이 감소했을 때 호출할 메서드
    func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    // 특정 레벨로 이동할 때 호출할 메서드
    func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    // 레벨을 초기화할 때 호출할 메서드
    func reset() {
        print("Reset!")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()
levelClassInstance.levelUp()        // Level Up!
// Level 1
levelClassInstance.levelDown()      // Level Down
// Level 0
levelClassInstance.levelDown()      // Level Down
// Level -1
// Reset!
// Level 0
levelClassInstance.jumpLevel(to: 3) // Jump to 3
// Level 3

// 자신의 프로퍼티 값을 수정할 때 클래스의 인스턴스 메서드는 크게 신경 쓸 필요가 없지만,
// 구조체나 열거형 등은 값 타입이므로 메서드 앞에 mutating 키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 변경한다는 것을 명시해야 합니다.
// mutating 키워드의 사용
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()           // Level Up!
// Level 1
levelStructInstance.levelDown()         // Level Down
// Level 0
levelStructInstance.levelDown()
// Level -1
// Reset!
// Level 0
levelStructInstance.jumpLevel(to: 3)    // Jump to 3
// Level 3

// self 프로퍼티
// 모든 인스턴스는 암시적으로 생성된 self 프로퍼티를 갖습니다. 자바의 this와 비슷하게 인스턴스 자기 자신을 가리키는 프로퍼티입니다.
// self 프로퍼티는 인스턴스를 더 명확히 지칭하고 싶을 때 사용합니다.

// self 프로퍼티의 사용
class LevelClass2 {
    var level: Int = 0
    
    func jumpLevel(to level: Int) {
        print("Jump to \(level)")
        self.level = level
    }
}

// 또, self 프로퍼티의 다른 용도는 값 타입 인스턴스 자체의 값을 치환할 수 있습니다.
// 클래스의 인스턴스는 참조 타입이라서 self 프로퍼티에 다른 참조를 할당할 수 없는데, 구조체나 열거형 등은 self 프로퍼티를 사용하여 자신 자체를 치환할 수도 있습니다.
// self 프로퍼티와 mutating 키워드
class LevelClass3 {
    var level: Int = 0
    
    func reset() {
        // 오류!! self 프로퍼티 참조 변경 불가!!
        //self = LevelClass3()
    }
}

struct LevelStruct3 {
    var level: Int = 0
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func reset() {
        print("Reset!")
        self = LevelStruct3()
    }
}

var levelStructInstance3: LevelStruct3 = LevelStruct3()
levelStructInstance3.levelUp()      // Level Up!
print(levelStructInstance3.level)   // 1

levelStructInstance3.reset()        // Reset!
print(levelStructInstance3.level)   // 0

enum OnOffSwitch {
    case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)       // on

// 타입 메서드
// 인스턴스 프로퍼티와 타입 프로퍼티가 있듯이 메서드에도 인스턴스 메서드와 타입 메서드가 있습니다.
// 타입 자체에 호출이 가능한 메서드를 타입 메서드(흔히 객체지향 프로그래밍에서 지칭하는 클래스 메서드와 유사)라고 부릅니다.
// 메서드 앞에 static 키워드를 사용하여 타입 메서드임을 나타내줍니다. 클래스의 타입 메서드는 static 키워드와 class 키워드를 사용할 수 있는데
// static으로 정의하면 상속 후 메서드 재정의가 불가능하고 class로 정의하면 상속 후 메서드 재정의가 가능합니다.

// 클래스의 타입 메서드
class AClass2 {
    
    static func staticTypeMethod() {
        print("AClass2 staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass2 classTypeMethod")
    }
}

class BClass2: AClass2 {
    
    /*
     // 오류 발생!! 재정의 불가!
     override static func staticTypeMethod() {
     
     }
     */
    
    override class func classTypeMethod() {
        print("BClass2 classTypeMethod")
    }
}

AClass2.staticTypeMethod()       // AClass2 staticTypeMethod
AClass2.classTypeMethod()        // AClass2 classTypeMethod
BClass2.classTypeMethod()        // BClass2 classTypeMethod

// 또, 타입 메서드는 인스턴스 메서드와는 달리 self 프로퍼티가 타입 그 자체를 가리킨다는 점이 다릅니다.
// 인스턴스 메서드에서는 self가 인스턴스를 가리킨다면 타입 메서드의 self는 타입을 가리킵니다.
// 그래서 타입 메서드 내부에서 타입 이름과 self는 같은 뜻이라고 볼 수 있습니다. 그래서 타입 메서드에서 self 프로퍼티를 사용하면 타입 프로퍼티 및 타입 메서드를 호출할 수 있습니다.

// 타입 프로퍼티와 타입 메서드의 사용
// 시스템 음량은 한 기기에서 유일한 값이어야 합니다.
struct SystemVolume {
    // 타입 프로퍼티를 사용하면 언제나 유일한 값이 됩니다.
    static var volume: Int = 5
    
    // 타입 프로퍼티를 제어하기 위해 타입 메서드를 사용합니다.
    static func mute() {
        self.volume = 0     // SystemVolume.volume = 0과 같은 표현입니다.
                            // Self.volume = 0과도 같은 표현입니다.
    }
}

// 내비게이션 역할은 여러 인스턴스가 수행할 수 있습니다.
class Navigation {
    
    // 내비게이션 인스턴스마다 음량을 따로 설정할 수 있습니다.
    var volume: Int = 5
    
    // 길 안내 음성 재생
    func guideWay() {
        // 내비게이션 외 다른 재생원 음소거
        SystemVolume.mute()
    }
    
    // 길 안내 음성 종료
    func finishGuideWay() {
        // 기존 재생원 음량 복구
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume)      // 0

myNavi.finishGuideWay()
print(SystemVolume.volume)      // 5
