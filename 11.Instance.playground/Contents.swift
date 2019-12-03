// ========== 인스턴스 생성 및 소멸 ==========
// 구조체와 클래스를 생성할 때는 지금까지 기본 이니셜라이저를 사용해 인스턴스를 생성했습니다.
// 초기화(Initialization)는 클래스나 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정입니다.
// 초기화가 완료된 인스턴스는 사용 후 소멸 시점이 오면 소멸합니다.

// ========== 인스턴스 생성 ==========
// 초기화 과정은 새로운 인스턴스를 사용할 준비를 하기 위하여 저장 프로퍼티의 초깃값을 설정하는 등의 일을 합니다.
// 이니셜라이저(Initializaer)를 정의하면 초기화 과정을 직접 구현할 수 있습니다. 그렇게 구현된 이니셜라이저는 새로운 인스턴스를 생성할 수 있는 특별한 메서드가 됩니다.
// 스위프트의 이니셜라이저는 반환 값이 없습니다. 이니셜라이저의 역할은 그저 인스턴스의 첫 사용을 위해 사용을 위해 초기화하는 것뿐입니다.
// 이니셜라이저는 해당 타입의 새로운 인스턴스를 생성하기 위해 호출합니다. 이니셜라이저는 func 키워드를 사용하지 않고 오로지 init 키워드를 사용하여 이니셜라이저 메서드임을 표현합니다.
// init 메서드는 클래스, 구조체, 열거형 등의 구현부 또는 해당 타입의 익스텐션 구현부에 위치합니다. 다만 클래스의 지정 이니셜라이저는 익스텐션에서 구현해줄 수 없습니다.

// 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저
class SomeClass {
    init() {
        // 초기화할 때 필요한 코드
    }
}

struct SomeStruct {
    init() {
        // 초기화할 때 필요한 코드
    }
}

enum SomeEnum {
    case someCase
    
    init() {
        // 열거형은 초기화할 때 반드시 case중 하나가 되어야 합니다.
        self = .someCase
        // 초기화할 때 필요한 코드
    }
}

// 프로퍼티 기본값
// 구조체와 클래스의 인스턴스는 처음 생성할 때 옵셔널 저장 프로퍼티를 제외한 모든 저장 프로퍼티에 적잘한 초깃값(Initial Value)를 할당해야 합니다.
// 이니셜라이저가 실행될 때 저장 프로퍼티에 적절한 초깃값을 할당할 수 있습니다. 초기화 후에 값이 확정되지 않은 저장 프로퍼티는 존재할 수 없습니다.
// 프로퍼티를 정의할 때 프로퍼티 기본값(Default Value)을 할당하면 이니셜라이저에서 따로 초깃값을 할당하지 않더라도 프로퍼티 기본값으로 저장 프로퍼티의 값이 초기화됩니다.
// [NOTE] 초기화와 프로퍼티 감시자 : 이니셜라이저를 통해 초깃값을 할당하거나, 프로퍼티 기본값을 통해 처음의 저장 프로퍼티가 초기화될 때는 프로퍼티 감시자 메서드가 호출되지 않았습니다.

// Area 구조체와 이니셜라이저
struct Area {
    var squareMeter: Double
    
    init() {
        squareMeter = 0.0       // squareMeter의 초깃값 할당
    }
}

let room: Area = Area()
print(room.squareMeter)     // 0.0

// 프로퍼티 기본값 지정
struct Area2 {
    var squareMeter: Double = 0.0   // 프로퍼티 기본값 할당
}

let room2: Area2 = Area2()
print(room2.squareMeter)     // 0.0

// 초기화과정은 이니셜라이저의 매개변수, 옵셔널 프로퍼티, 상수 프로퍼티의 값 할당 등 프로그래머의 의도대로 구현할 수 있는 수많은 패턴의 이니셜라이저가 있음.

// 이니셜라이저 매개변수
// 함수나 매서드를 정의할 때와 마찬가지로 이니셜라이저도 매개변수를 가질 수 있습니다.
// 즉, 인스턴스를 초기화하는 과정에 필요한 값을 전달받을 수 있습니다.

// 이니셜라이저 매개변수
struct Area3 {
    var squareMeter: Double
    
    init(fromPy py: Double) {                       // 첫 번째 이니셜라이저
        squareMeter = py * 3.3058
    }
    
    init(fromSquareMeter squareMeter: Double) {     // 두 번째 이니셜라이저
        self.squareMeter = squareMeter
    }
    
    init(value: Double) {                           // 세 번째 이니셜라이저
        squareMeter = value
    }
    
    init(_ value: Double) {                         // 네 번째 이니셜라이저
        squareMeter = value
    }
}

let roomOne: Area3 = Area3(fromPy: 15.0)
print(roomOne.squareMeter)      // 49.587

let roomTwo: Area3 = Area3(fromSquareMeter: 33.06)
print(roomTwo.squareMeter)      // 33.06

let roomThree: Area3 = Area3(value: 30.0)
let roomFour: Area3 = Area3(55.0)

//Area3()     // 오류 발생!!

// 옵셔널 프로퍼티 타입
// 초기화 과정에서 값을 초기화하지 않아도 되는, 즉 인스턴스가 사용되는 동안에 값을 꼭 갖지 않아도 되는 저장 프로퍼티가 있다면 해당 프로퍼티를 옵셔널로 선언할 수 있습니다.
// 또는 초기화 과정에서 값을 지정해주기 어려운 경우 저장 프로퍼티를 옵셔널로 선언할 수도 있습니다.
// 옵셔널로 선언한 저장 프로퍼티는 초기화 과정에서 값을 할당해주지 않는다면 자동으로 nil이 할당됩니다.

// Person 클래스
class Person {
    var name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")
print(yagom.name)       // "yagom"
print(yagom.age)        // nil

yagom.age = 99
print(yagom.age)        // 99

yagom.name = "Eric"
print(yagom.name)       // "Eric"

// 상수 프로퍼티
// 상수로 선언된 저장 프로퍼티는 인스턴스를 초기화하는 과정에서만 값을 할당할 수 있으며, 처음 할당된 이후로는 값을 변경할 수 없습니다.
// [NOTE] 상수 프로퍼티와 상속 : 클래스 인스턴스의 상수 프로퍼티는 프로퍼티가 정의된 클래스에서만 초기화할 수 있습니다. 해당클래스를 상속받은 자식클래스의 이니셜라이저에서는 부모클래스의 상수 프로퍼티 값을 초기화할 수 없습니다.

// 상수 프로퍼티의 초기화
class Person2 {
    let name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let yagom2: Person2 = Person2(name: "yagom")
//yagom.name = "Eric"     // 오류 발생!!!

// 기본 이니셜라이저와 멤버와이즈 이니셜라이저
// 사용자 정의 이니셜라이저를 정의해주지 않으면 클래스나 구조체는 모든 프로퍼티에 기본값이 지정되어 있다는 전제하에 기본 이니셜라이저를 사용합니다.
// 기본 이니셜라이저는 저장 프로퍼티의 기본값이 모두 지정되어 있고, 동시에 사용자 정의 이니셜라이저가 정의되어 있지 않은 상태에서 제공됩니다.
// 저장 프로퍼티를 선언할 때 기본값을 지정해주지 않으면 이니셜라이저에서 초깃값을 설정해야 합니다. 그러나, 프로퍼티하나 때문에 매번 이니셜라이저를 추가하거나 변경하는 일은 귀찮은 일이다.
// 때문에 구조체는 사용자 정의 이니셜라이저를 구현하지 않으면 프로퍼티의 이름으로 매개변수를 갖는 이니셜라이저인 멤버와이즈 이니셜라이저를 기본으로 제공.
// 단, 클래스는 멤버와이즈 이니셜라이저를 지원하지 않음.

// Point 구조체와 Size 구조체의 선언과 멤버와이즈 이니셜라이저의 사용
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

let point: Point = Point(x: 0, y: 0)
let size: Size = Size(width: 50.0, height: 50.0)

// 구조체의 저장 프로퍼티에 기본값이 있는 경우
// 필요한 매개변수만 사용하여 초기화할 수도 있습니다.
let somePoint: Point = Point()
let someSize: Size = Size(width: 50)
let anotherPoint: Point = Point(y : 100)

// 초기화 위임
// 값 타입인 구조체와 열거형은 코드의 중복을 피하기 위하여 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 초기화 위임을 간단하게 구현할 수 있음.
// 클래스는 상속을 지원하여 간단한 초기화 위임도 할 수 없음.
// 값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 self.init을 사용합니다. 당연히 self.init은 이니셜라이저 안에서만 사용할 수 있는데 self.init을 사용한다는 것 자체가 사용자 정의 이니셜라이저를 정의하고 있다는 뜻입니다.
// 그런데 사용자 정의 이니셜라이저를 정의하면 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 없다고 했습니다. 따라서, 초기화 위임을 하려면 최소 두 개 이상의 사용자 정의 이니셜라이저를 정의해야 합니다.
/*
 [NOTE] 기본 이니셜라이저를 지키고 싶다면
  사용자 정의 이니셜라이저를 정의할 때도 기본 이니셜라이저나 멤버와이즈 이니셜라이저를 사용하고 싶다면 익스텐션을 사용하여 사용자 정의 이니셜라이저를 구현하면 됩니다.
 */

// Student 열거형과 초기화 위임
enum Student {
    case elementary, middle, high
    case none
    
    // 사용자 정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 사용할 수 있습니다.
    init() {
        self = .none
    }
    
    init(koreanAge: Int) {      // 첫 번째 사용자 정의 이니셜라이저
        switch koreanAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {   // 두 번째 사용자 정의 이니셜라이저
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger)      // middle

younger = Student(bornAt: 1998, currentYear: 2016)
print(younger)      // high

// 실패 가능한 이니셜라이저(Failable initializer)
// 이니셜라이저를 통해 인스턴스를 초기화할 수 없는 여러 가지 예외 상황이 있습니다. 대표적으로 이니셜라이저의 전달인자로 잘못된 값이나 적절치 못한 값이 전달되었을 때,
// 이니셜라이저는 인스턴스 초기화에 실패할 수 있습니다. 그 외에도 여러 이유로 인스턴스 초기화에 실패할 수 있습니다.
// 이니셜라이저를 정의할 때 이런 실패 가능성을 염두에 두기도 하는데, 이렇게 실패 가능성을 내포한 이니셜라이저를 실패 가능한 이니셜라이저라고 부릅니다.
// 실패 가능한 이니셜라이저는 클래스, 구조체, 열거형 등에 모두 정의할 수 있습니다. 실패 가능한 이니셜라이저는 실패했을 때 nil을 반환해주므로 반환 타입이 옵셔널로 지정됩니다.
// 따라서 실패 가능한 이니셜라이저는 init 대신에 init? 키워드를 사용합니다.
/*
 [NOTE] 이니셜라이저의 매개변수
  실패하지 않는 이니셜라이저와 실패 가능한 이니셜라이저를 같은 이름과 같은 매개변수 타입을 갖도록 정의할 수 없습니다.
  실패 가능한 이니셜라이저는 실제로 특정 값을 반환하지 않습니다. 초기화를 실패했을 때는 return nil을, 반대로 초기화에 성공했을 때는 return을 적어 초기화의 성공과 실패를 표현할 뿐,
  실제 값을 반환하지는 않습니다.
 */

// 실패 가능한 이니셜라이저
class Person3 {
    let name: String
    var age: Int?
    
    init?(name: String) {
        
        if name.isEmpty {
            return nil
        }
        
        self.name = name
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

let yagom3: Person3? = Person3(name: "yagom", age: 99)

if let person: Person3 = yagom3 {
    print(person.name)
} else {
    print("Person3 wasn't initialized")
}
// yagom

let chope: Person3? = Person3(name: "chope", age: -10)

if let person: Person3 = chope {
    print(person.name)
} else {
    print("Person3 wasn't initialized")
}
// Person wasn't initialized

let eric: Person3? = Person3(name: "", age: 30)

if let person: Person3 = eric {
    print(person.name)
} else {
    print("Person3 wasn't initialized")
}
// Person wasn't initialized

// 열거형의 실패 가능한 이니셜라이저

enum Student2: String {
    case elementary = "초등학생", middle = "중학생", high = "고등학생"
    
    init?(koreanAge: Int) {
        switch koreanAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                return nil
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger2: Student2? = Student2(koreanAge: 20)
print(younger2)      // nil

younger2 = Student2(bornAt: 2020, currentYear: 2016)
print(younger2)      // nil

younger2 = Student2(rawValue: "대학생")
print(younger2)      // nil

younger2 = Student2(rawValue: "고등학생")
print(younger2)      // high

// 함수를 사용한프로퍼티 기본값 설정
// 만약 사용자 정의 연산을 통해 저장 프로퍼티 기본값을 설정하고자 한다면 클로저나 함수를 사용하여 프로퍼티 기본값을 제공할 수 있습니다.
// 인스턴스를 초기화할 때 함수나 클로저가 호출되면서 연산 결괏값을 프로퍼티 기본값으로 제공해줍니다. 그렇기 때문에 클로저나 함수의 반환 타입은 프로퍼티의 타입과 일치해야 합니다.
// 만약 프로퍼티 기본값을 설정해주기 위해서 클로저를 사용한다면 클로저가 실행되는 시점은 초기화할 때 인스턴스의 다른 프로퍼티 값이 설정되기 전이라는 것도 꼭 명심해야 합니다.
// 즉, 클로저 내부에서는 인스턴스의 다른 프로퍼티를 사용하여 연산할 수는 없다는 것입니다. 다른 프로퍼티에 기본값이 있다고 해도 안 됩니다.
// 또한, 클로저 내부에서 self 프로퍼티도 사용할 수 없으며, 인스턴스 메서드를 호출할 수도 없습니다.

// 클로저를 통한 프로퍼티 기본값 설정
/*
class SomeClass {
    let someProperty: SomeType = {
        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 SomeType과 같은 타입이어야 합니다.
        return someValue
    }()
}
*/
// 클로저 뒤에 소괄호가 붙은 이유는 클로저를 실행하기 위해서입니다. 클로저 뒤에 소괄호가 붙어 클로저를 실행한 결괏값은 프로퍼티의 기본값이 됩니다.
// 만약 소괄호가 없다면 프로퍼티의 기본값은 클로저 그 자체가 됩니다.

// 클로저를 통한 student 프로퍼티 기본값 설정
struct Student3 {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var students: [Student3] = {
        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 [Student] 타입이어야 합니다.
        var arr: [Student3] = [Student3]()
        
        for num in 1...15 {
            var student: Student3 = Student3(name: nil, number: num)
            arr.append(student)
        }
        
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count)       // 15

/*
 [TIP] iOS에서의 활용
  스위프트 언어와는 크게 관계가 없지만 iOS의 UI등을 구성할 때, UI 컴포넌트를 클래스의 프로퍼티로 구현하고,
  UI 컴포넌트의 생성과 동시에 컴포넌트의 프로퍼티를 기본적으로 설정할 때 유용하게 사용할 수 있습니다.
 */

// ========== 인스턴스 소멸 ==========
// 클래스 인스턴스는 디이니셜라이저(Deinitializer)를 구현할 수 있습니다. 디이니셜라이저는 이니셜라이저와 반대 역할을 합니다.
// 즉, 메모리에서 해체되기 직전 클래스 인스턴스와 관련하여 원하는 정리 작업을 구현할 수 있습니다. 디이니셜라이저는 클래스의 인스턴스가 메모리에서 소멸되기 바로 직전에 호출됩니다.
// deinit 키워드를 사용하여 디이니셜라이저를 구현하면 자동으로 호출됩니다. ** 디이니셜라이저는 클래스의 인스턴스에만 구현할 수 있습니다.
// 스위프트는 인스턴스가 더 이상 필요하지 않으면 자동으로 메모리에서 소멸시킵니다. 인스턴스 대부분은 소멸시킬 때 디이니셜라이저를 사용해 별도의 메모리 관리 작업을 할 필요는 없습니다.
// 그렇지만 예를 들어 인스턴스 내부에서 파일을 불러와 열어보는 등의 외부 자원을 사용했다면 인스턴스를 소멸하기 직전에 파일을 다시 저장하고 닫아주는 등의 부가 작업을 해야 합니다.
// 또는 인스턴스를 메모리에서 소멸하기 직전에 인스턴스에 저장되어 있던 데이터를 디스크에 파일로 저장해줘야 하는 경우도 있을 수 있습니다. 그런 경우에 디이니셜라이저는 굉장히 유용하게 사용할 수 있습니다.
// 클래스에는 디이니셜라이저를 단 하나만 구현할 수 있습니다. 디이니셜라이저는 이니셜라이저와는 다르게 매개변수를 갖지 않으며, 소괄호도 적어주지 않습니다. 또, 자동으로 호출되기 때문에 별도의 코드로 호출할 수도 없습니다.
// 디이니셜라이저는 인스턴스를 소멸하기 직전에 호출되므로 인스턴스의 모든 프로퍼티에 접근할 수 있으며 프로퍼티의 값을 변경할 수도 있습니다.

// 디이니셜라이저의 구현
class SomeClass2 {
    deinit {
        print("Instance will be deallocated immediately")
    }
}

var instance: SomeClass2? = SomeClass2()
instance = nil      // Instance will be deallocated immediately

// FileManager 클래스의 디이니셜라이저 활용
class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File: \(self.fileName)")
    }
    
    func writeFile() {
        print("Write File: \(self.fileName)")
    }
    
    func closeFile() {
        print("Close File: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile()      // Open File: abc.txt
    manager.modifyFile()    // Modify File: abc.txt
}

fileManager = nil
// Deinit instance
// Write File: abc.txt
// Close File: abc.txt

// FileManager의 인스턴스가 파일을 불러와 사용하며, 인스턴스의 사용이 끝난 후에는 파일의 변경사항을 저장하고 다시 닫아줘야
// 메모리에서 파일이 해제되기 때문에 인스턴스가 메모리에서 해제되기 직전에 파일도 닫아주는 작업을 합니다.
// 디이니셜라이저를 잘 활용하면 메모리 관리 측면 외에도 프로그래머가 설계한 로직에 따라 인스턴스가 메모리에서 해제되기 직전에 적절한 작업을 하도록 할 수 있습니다.

