// ========== 상속(Inheritance) ==========
// 클래스는 메서드나 프로퍼티 등을 다른 클래스로부터 상속받을 수 있습니다.
// 어떤 클래스로부터 상속 받으면 상속받은 클래스는 그 어떤 클래스의 자식클래스(Subclass/Child-class)라고 표현합니다.
// 자식클래스에게 자신의 특성을 물려준 클래스를 부모클리스(Superclass/Parents-class)라고 표현합니다.
// 상속은 스위프트의 다른 타입과 클래스를 구별 짓는 클래스만의 특징입니다.

// 스위프트에서 클래스는 부모클래스로부터 물려받은 메서드를 호출할 수 있고 프로퍼티에 접글할 수 있으며 서브스크립트도 사용할 수 있습니다.
// 또, 부모클래스로부터 물려받은 메서드, 프로퍼티, 서브스크립트 등을 자신만의 내용으로 재정의할 수도 있습니다.
// 스위프트는 부모클래스의 요소를 자식클래스에서 재정의할 때 자식클래스가 부모클래스의 요소들을 재정의한다는 것을 명확히 확인해주어야 합니다.

// 상속받은 프로퍼티에 프로퍼티의 값이 변경되었을 때 알려주는 프로퍼티 감시자도 구현할 수 있습니다.
// 연산 프로퍼티를 정의해준 클래스에서는 연산 프로퍼티에 프로퍼티 감시자를 구현할 수 없지만, 부모클래스에서 연산 프로퍼티로 정의한 프로퍼티든 저장 프로퍼티로 정의한 프로퍼티든 자식클래스에서는 프로퍼티 감시자를 구현할 수 있습니다.
// 다른 클래스로부터 상속을 받지 않은 클래스를 기반클래스(Base class)라고 부릅니다.

// 기반클래스 Person
class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
}

var yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)       // 이름 : yagom. 나이 : 99
yagom.speak()                   // 가나다라마바사

// ========== 클래스 상속 ==========
// 상속은 기반클래스를 다른 클래스에서 물려받는 것을 말합니다. 부모클래스의 메서드, 프로퍼티 등을 재정의하거나, 기반클래스의 기능이나 프로퍼티를 물려받고 자신의 기능을 추가할 수 있습니다.
// 클래스 이름 뒤에 콜론을 붙이고 다른 클래스 이름을 써주면 뒤에 오는 클래스의 기능을 앞의 클래스가 상속받을 것임을 뜻합니다.
/*
class 클래스 이름 : 부모클래스 이름 {
    프로퍼티와 메서드들
}
*/

// Person 클래스를 상속받은 Student 클래스
class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
}

yagom = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)       // 이름 : yagom. 나이 : 99
yagom.speak()                   // 가나다라마바사

let jay: Student = Student()
jay.name = "jay"
jay.age = 10
jay.grade = "A"
print(jay.introduction)         // 이름 : jay. 나이 : 10
jay.speak()                     // 가나다라마바사
jay.study()                     // Study hard...
// Student 클래스는 Person 클래스를 상속받았기 때문에 부모 클래스가 물려준 프로퍼티와 메서드를 사용할 수 있으며 자신의 정의한 프로퍼티와 메서드도 사용할 수 있습니다.
// Person 클래스를 상속받은 Student 클래스는 다시 다른 클래스가 상속할 수 있습니다. 즉, 어떤 클래스의 자식클래스가 다른 클래스의 부모클래스가 될 수 있습니다.

// Student 클래스를 상속받은 UniversityStudent 클래스
class UniversityStudent: Student {
    var major: String = ""
}

let jenny: UniversityStudent = UniversityStudent()
jenny.major = "Art"
jenny.speak()       // 가나다라마바사
jenny.study()       // Study hard...
// Person 클래스를 상속받은 Student 클래스는 Person의 인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로퍼티, 서브스크립트 등 모든 특성을 포함하며
// Student를 상속받은 UniversityStudent 클래스는 Person과 Student가 갖는 모든 특성을 포함합니다.
// 다른 클래스를 상속받으면 똑같은 기능을 구현하기 위하여 코드를 다시 작성할 필요가 없으므로 코드를 재사용하기 용이하고 더불어 기능을 확장할 때 기존 클래스를 변경하지 않고도 새로운 추가 기능을 구현한 클래스를 정의할 수 있습니다.

// ========== 재정의(Override) ==========
// 자식클래스는 부모클래스로부터 물려받은 특성(인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로퍼티, 서브스크립트 등)을 그대로 사용하지 않고 자신만의 기능으로 변경하여 사용할 수 있습니다. 이를 재정의(Override)라고 합니다.
// 상속받은 특성들을 재정의하려면 새로운 정의 앞에 override라는 키워드를 사용합니다. override 키워드는 스위프트 컴파일러가 조상클래스(부모를 포함한 그 상위 부모클래스)에 해당 특성이 있는지 확인한 후 재정의하게 됩니다.
// 만약 조상클래스에 재정의할 해당 특성이 없는데 override 키워드를 사용하면 오류가 발생합니다.
// 만약 자식클래스에서 부모클래스의 특성의 재정의했을 때, 부모클래스의 특성을 자식클래스에서 사용하고 싶다면 super 프로퍼티를 사용하면 됩니다.
// 즉, 자식클래스에서 특성을 재정의 했지만 필요에 따라 부모클래스의 특성을 활용하고 싶을 때 super를 사용합니다.
// super 키워드를 타입 메서드 내에서 사용한다면, 부모클래스의 타입 메서드와 타입 프로퍼티에 접근할 수 있으며 인스턴스 메서드 내에서 사용한다면, 부모클래스의 인스턴스 메서드와 인스턴스 프로퍼티, 서브스크립트에 접근할 수 있습니다.

// 메서드 재정의
// 부모클래스로부터 상속받은 인스턴스 메서드나 타입 메서드를 자식클래스에서 용도에 맞도록 재정의 할 수 있습니다.

// 메서드 재정의
class Person2 {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
    
    class func introduceClass() -> String {
        return "인류의 소원은 평화입니다."
    }
}

class Student2: Person2 {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
    
    override func speak() {
        print("저는 학생입니다.")
    }
}

class UniversityStudent2: Student2 {
    var major: String = ""
    
    class func introduceClass() {
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+입니다."
    }
    
    override func speak() {
        super.speak()
        print("대학생이죠.")
    }
}

let yagom2: Person2 = Person2()
yagom2.speak()      // 가나다라마바사

let jay2: Student2 = Student2()
jay2.speak()        // 저는 학생입니다.

let jenny2: UniversityStudent2 = UniversityStudent2()
jenny2.speak()      // 저는 학생입니다. 대학생이죠.

print(Person2.introduceClass())                         // 인류의 소원은 평화입니다.
print(Student2.introduceClass())                        // 인류의 소원은 평화입니다.
print(UniversityStudent2.introduceClass() as String)    // 대학생의 소원은 A+입니다.
UniversityStudent2.introduceClass() as Void             // 인류의 소원은 평화입니다.

// UniversityStudent2 클래스의 introduceClass() 메서드에 override키워드가 붙은 메서드와 그렇지 않은 메서드 두 가지가 있는 이유는 바로 반환 타입이 다르기 때문입니다.
// 스위프트는 메서드의 반환 타입이나 매개변수가 다르면 서로 다른 메서드로 취급합니다. 또, 부모클래스의 메서드에 접근하기 위해서는 UniversityStudent2 클래스의 speak()와 introduceClass() 메서드에서처럼 super 프로퍼티를 사용하면 됩니다.

// 프로퍼티 재정의
// 메서드와 마찬가지로 부모클래스로부터 상속받은 인스턴스 프로퍼티나 타입 프로퍼티를 자식 클래스에서 용도에 맞게 재정의할 수 있습니다. 프로퍼티를 재정의할 때는 저장 프로퍼티로 재정의할 수는 없습니다.
// 프로퍼티를 재정의한다는 것은 프로퍼티 자체가 아니라 프로퍼티의 접근자(Getter), 설정자(Setter), 프로퍼티 감시자(Property Observer) 등을 재정의하는 것을 의미합니다.
// 조상클래스에서 저장 프로퍼티로 정의한 프로퍼티는 물론이고 연산 프로퍼티로 정의한 프로퍼티도 접근자와 설정자를 재정의할 수 있습니다. 프로퍼티를 상속받은 자식클래스에서는 조상 클래스의 프로퍼티 종류(저장, 연산 등)는 알지 못하고 단지 이름과 타입만을 알기 때문입니다.
// 재정의하려는 프로퍼티는 조상클래스 프로퍼티의 이름과 타입이 일치해야 합니다. 만약 조상클래스에 없는 프로퍼티를 재정의하려고 한다면 메서드와 마찬가지로 컴파일 오류가 발생합니다.
// 조상클래스에서 읽기 전용 프로퍼티였더라도 자식클래스에서 읽고 쓰기가 가능한 프로퍼티로 재정의해줄 수도 있습니다. 그러나, 읽기 쓰기 모두 가능했던 프로퍼티를 읽기 전용으로 재정의해줄 수는 없습니다.
// 읽기 쓰기가 모두 가능한 프로퍼티를 재정의할 때 설정자만 따로 재정의할 수는 없습니다. 즉, 접근자와 설정자를 모두 재정의해야 합니다.
// 만약 접근자에 따로 기능 변경이 필요 없다면 super.someProperty와 같은 식으로 부모클래스의 접근자를 사용하여 값을 받아와 반환해주면 됩니다.

// 프로퍼티 재정의
class Person3 {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
}

class Student3: Person3 {
    var grade: String = "F"
    
    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)"
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
    }
}

let yagom3: Person3 = Person3()
yagom3.name = "yagom"
yagom3.age = 55
//yagom3.koreanAge = 56         // 오류 발생
print(yagom3.introduction)      // 이름 : yagom. 나이 : 55
print(yagom3.koreanAge)         // 56

let jay3: Student3 = Student3()
jay3.name = "jay"
jay3.age = 14
jay3.koreanAge = 15
print(jay3.introduction)        // 이름 : jay. 나이 : 14 학점 : F
print(jay3.koreanAge)           // 15

// 프로퍼티 감시자 재정의
// 프로퍼티 감시자도 프로퍼티의 접근자와 설정자처럼 재정의할 수 있습니다. 또 조상클래스에 정의한 프로퍼티가 연산 프로퍼티인지 저장 프로퍼티인지는 상관없습니다.
// 다만 상수 저장 프로퍼티나 읽기 전용 연산 프로퍼티는 프로퍼티 감시자를 재정의할 수 없습니다.
// 왜냐하면 상수 저장 프로퍼티나 읽기 전용 연산 프로퍼티는 값을 설정할 수 없으므로 willSet이나 didSet 메서드를 사용한 프로퍼티 감시자를 원천적으로 사용할 수 없기 때문입니다.
// 또, 프로퍼티 감시자를 재정의하더라도 조상클래스에 정의한 프로퍼티 감시자도 동작합니다.
// 프로퍼티의 접근자와 프로퍼티 감시자는 동시에 재정의할 수 없습니다. 만약 둘 다 동작하길 원한다면 재정의하는 접근자에 프로퍼티 감시자의 역할을 구현해야 합니다.

// 프로퍼티 감시자 재정의
class Person4 {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person4 age : \(self.age)")
        }
    }
    var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get {
            return self.name
        }
        set {
            self.name = newValue
        }
    }
}

class Student4: Person4 {
    var grade: String = "F"
    override var age: Int {
        didSet {
            print("Student4 age : \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
        
        // didSet { }      // 오류 발생!!
    }
    
    override var fullName: String {
        didSet {
            print("Full Name : \(self.fullName)")
        }
    }
}

let yagom4: Person4 = Person4()
yagom4.name = "yagom"
yagom4.age = 55                 // Person age : 55
yagom4.fullName = "Jo yagom"
print(yagom4.koreanAge)         // 56

let jay4: Student4 = Student4()
jay4.name = "jay"
jay4.age = 14
// Person4 age : 14
// Student4 age : 14
jay4.koreanAge = 15
// Person4 age : 14
// Student age : 14
jay4.fullName = "Kim jay"       // Full Name : Kim jay
print(jay4.koreanAge)           // 15

// 서브스크립트 재정의
// 서브스크립트도 메서드와 마찬가지로 재정의가 가능합니다. 서브스크립트도 매개변수와 반환타입이 다르면 다른 서브스크립트로 취급하므로,
// 자식클래스에서 재정의하려는 서브스크립트라면 부모클래스 서브스크립트의 매개변수와 반환 타입이 같아야합니다.
class School {
    var students: [Student4] = [Student4]()
    
    subscript(number: Int) -> Student4 {
        print("School subscript")
        return students[number]
    }
}

class MiddleSchool: School {
    var middleStudents: [Student4] = [Student4]()
    
    // 부모클래스(School)에게 상속받은 서브스크립트 재정의
    override subscript(index: Int) -> Student4 {
        print("MiddleSchool subscript")
        return middleStudents[index]
    }
}

let university: School = School()
university.students.append(Student4())
university[0]       // School subscript

let middle: MiddleSchool = MiddleSchool()
middle.middleStudents.append(Student4())
middle[0]       // MiddleSchool subscript

// 재정의 방지
// 만약 부모클래스를 상속받는 자식클래스에서 몇몇 특성을 재정의할 수 없도록 제한하고 싶다면 재정의를 방지하고 싶은 특성 앞에 final 키워드를 명시하면 됩니다.
// 예를 들면 final var, final func, final class func, final subscript와 같이 표현하면 됩니다. 재정의를 방지한 특성을 자식클래스에서 재정의하려고 하면 컴파일 오류가 발생합니다.
// 만약 클래스를 상속하거나 재정의할 수 없도록 하고 싶다면 class 키워드 앞에 final 키워드를 명시해주면 됩니다. 그렇게 하면 더 이상 자식클래스를 가질 수 없습니다.
// 상속이 방지된 클래스를 다른 클래스가 상속받으려고 하면 컴파일 오류가 발생합니다.

// final 키워드 사용
class Person5 {
    final var name: String = ""
    
    final func speak() {
        print("가나다라마바사")
    }
}

/*
final class Student5: Person {
    // 오류! Person5의 name은 final을 사용하여 재정의를 할 수 없도록 했기 때문입니다.
    override var name: String {
        set {
            super.name = newValue
        }
        get {
            return "학생"
        }
    }
    
    // 오류! Person5의 speak()는 final을 사용하여 재정의를 할 수 없도록 했기 때문입니다.
    override func speak() {
        print("저는 학생입니다.")
    }
}

// 오류! Student5 클래스는 final을 사용하여 상속할 수 없도록 했기 때문입니다.
class UniversityStudent5: Student5 { }
*/

// ========== 클래스의 이니셜라이저 - 상속과 재정의 ==========
// 값 타입의 이니셜라이저는 이니셜라이저 위임을 위해 이니셜라이저끼리 구분할 필요가 없었지만 클래스에서는 지정 이니셜라이저와 편의 이니셜라이저로 역할을 구분합니다.
// 또, 값 타입의 이니셜라이저는 상속을 고려할 필요가 없었지만 클래스는 상속이 가능하므로 상속받았을 때 이니셜라이저를 어떻게 재정의하는지도 큰 관건입니다.
// 두 종류의 이니셜라이저가 존재하고 상속이라는 클래스의 특성 때문에 다양한 패턴의 이니셜라이저가 생길 수 있으며, 그에 따라 클래스를 디자인할 때 더 많은 고민이 필요합니다.

// 지정 이니셜라이저(Designated Initializer)와 편의 이니셜라이저(Convenience Initializer)
// 지정 이니셜라이저(Designated Initializer)는 클래스의 주요 이니셜라이저입니다. 지정 이니셜라이저는 필요에 따라 부모클래스의 이니셜라이저를 호출할 수 있으며, 이니셜라이저가 정의된 모든 프로퍼티를 초기화해야 하는 임무를 갖고 있습니다.
// 지정 이니셜라이저는 클래스의 이니셜라이저 중 기둥과 같은 역할을 하므로 클래스에 하나 이상 정의합니다. 물론 여러 개를 정의할 수는 있지만 편의 이니셜라이저에 비하면 적은 수입니다.
// 모든 클래스는 하나 이상의 지정 이니셜라이저를 갖습니다. 만약 조상클래스에서 지정 이니셜라이저가 자손클래스의 지정 이니셜라이저 역할을 충분히 할 수 있다면, 자손클래스는 지정 이니셜라이저를 갖지 않을 수도 있습니다.
// 아마도 이런 경우는 조상클래스로부터 물려받은 프로퍼티를 제외하고 옵셔널 저장 프로퍼티 외에 다른 저장 프로퍼티가 없을 가능성이 큽니다.

// 편의 이니셜라이저(Convenience Initializer)는 초기화를 좀 더 손쉽게 도와주는 역할을 합니다. 편의 이니셜라이저는 지정 이니셜라이저를 자신 내부에서 호출합니다.
// 지정 이니셜라이저의 매개변수가 많아 외부에서 일일이 전달인자를 전달하기 어렵거나 특정 목적에 사용하기 위해서 편의 이니셜라이저를 설계할 수도 있습니다.
// 예를 들어 특정 목적으로 인스턴스를 설정할 때 일부 프로퍼티는 클래스 설계자가 의도한 대로 초깃값을 지정해줘야 합니다.
// 지정 이니셜라이저를 사용하면 인스턴스를 생성할 때마다 전달인자로 초깃값을 전달해야 하지만 편의 이니셜라이저를 사용하면 항상 같은 값으로 초기화가 가능합니다.
/*
init(매개변수들) {
    초기화 구문
}

convenience init(매개변수들) {
    초기화 구문
}
*/

// 클래스의 초기화 위임
/*
  1. 자식클래스의 지정 이니셜라이저는 부모클래스의 지정 이니셜라이저를 반드시 호출해야 합니다.
  2. 편의 이니셜라이저는 자신을 정의한 클래스의 다른 이니셜라이저를 반드시 호출해야 합니다.
  3. 편의 이니셜라이저는 궁극적으로는 지정 이니셜라이저를 반드시 호출해야 합니다.
 */

// 2단계 초기화(two-phase)
// 스위프트의 클래스 초기화는 2단계(two-phase)를 거칩니다.
// 1단계는 클래스에 정의한 각각의 저장 프로퍼티에 초깃값이 할당됩니다. 모든 저장 프로퍼티의 초기 상태가 결정되면 2단계로 돌입해 저장 프로퍼티들을 사용자 정의할 기회를 얻습니다. 그 후 비로소 새로운 인스턴스를 사용할 준비가 끝납니다.
// 2단계는 프로퍼티를 초기화하기 전에 프로퍼티 값에 접근하는 것을 막아 초기화를 안전하게 할 수 있도록 해줍니다. 또, 다른 이니셜라이저가 프로퍼티의 값을 실수로 변경하는 것을 방지할 수도 있습니다.
// 스위프트 컴파일러는 2단계 초기화를 오류 없이 처리하기 위해 다음과 같은 네 가지 안전확인(Safty-checks)을 실행합니다.
/*
  1. 자식클래스의 지정 이니셜라이저가 부모클래스의 이니셜라이저를 호출하기 전에 자신의 프로퍼티를 모두 초기화했는지 확인합니다.
  2. 자식클래스의 지정 이니셜라이저는 상속받은 프로퍼티에 값을 할당하기 전에 반드시 부모클래스의 이니셜라이저를 호출해야 합니다.
  3. 편의 이니셜라이저는 자신의 클래스에 정의한 프로퍼티를 포함하여 그 어떤 프로퍼티라도 값을 할당하기 전에 다른 이니셜라이저를 호출해야 합니다.
  4. 초기화 1단계를 마치기 전까지는 이니셜라이저는 인스턴스 메서드를 호출할 수 없습니다. 또, 인스턴스 프로퍼티의 값을 읽어들일 수도 없습니다. self 프로퍼티를 자신의 인스턴스를 나타내는 값으로 활용할 수도 없습니다.
*/
// 클래스의 인스턴스는 초기화 1단계를 마치기 전까지는 아직 유효하지 않습니다. 프로퍼티는 읽기만 가능하며, 메서드는 호출될 수 있을 뿐입니다.
// 클래스의 인스턴스가 초기화 1단계를 마쳤을 때 비로소 유효한 인스턴스가 되는 것입니다.

// 1단계
/*
  1. 클래스가 지정 또는 편의 이니셜라이저를 호출합니다.
  2. 그 클래스의 새로운 인스턴스를 위한 메모리가 할당됩니다. 메모리는 아직 초기화되지 않은 상태입니다.
  3. 지정 이니셜라이저는 클래스에 정의된 모든 저장 프로퍼티에 값이 있는지 확인합니다. 현재 클래스 부분까지의 저장 프로퍼티를 위한 메모리는 이제 초기화되었습니다.
  4. 지정 이니셜라이저는 부모클래스의 이니셜라이저가 같은 동작을 행할 수 있도록 초기화를 양도합니다.
  5. 부모클래스는 상속 체인을 따라 최상위 클래스에 도달할 때까지 이 작업을 반복합니다.
 */
// 최상위 클래스에 도달했을 때, 최상위 클래스까지의 모든 저장 프로퍼티에 값이 있다고 확인하면 해당 인스턴스의 메모리는 모두 초기화된 것입니다.

// 2단계
/*
  1. 최상위 클래스로부터 최하위 클래스까지 상속 체인을 따라 내려오면서 지정 이니셜라이저들이 인스턴스를 제 각각 사용자 정의하게 됩니다.
     이 단계에서는 self를 통해 프로퍼티 값을 수정할 수 있고, 인스턴스 메서드를 호출하는 등의 작업을 진행할 수 있습니다.
  2. 마지막으로 각각의 편의 이니셜라이저를 통해 self를 통한 사용자 정의 작업을 진행할 수 있습니다.
 */

// Person6 클래스를 상속받은 Student 클래스
class Person6 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Student6: Person6 {
    var major: String
    
    init(name: String, age: Int, major: String) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7, major: "")
    }
}
// Student6 클래스의 지정 이니셜라이저(init(name:age:major))는 부모클래스의 지정 이니셜라이저를 호출하기 전에 자신의 self 프로퍼티를 이용해 major 프로퍼티의 값을 할당합니다.
// 그렇게 하면 안전확인 중 1번의 조건에 만족합니다. 그리고 super.init(name: name, age: age)를 통해 부모클래스의 이니셜라이저를 호출했으며 그 외에 상속받은 프로퍼티가 없으므로
// 부모의 이니셜라이저 호출 이후에 값을 할당해줄 프로퍼티가 없습니다. 따라서 2번의 조건을 갖추었습니다.
// 또, 편의 이니셜라이저인 convenience init(name:)은 따로 차후에 값을 할당할 프로퍼티가 없고, 다른 이니셜라이저를 호출했으므로 3번 조건에 부합합니다.
// 마지막으로 이니셜라이저 어디에서도 인스턴스 메서드를 호출하거나 인스턴스 프로퍼티의 값을 읽어오지 않았으므로 4번 조건도 충족합니다.
// 안전확인 후 super.init(name: name, age: age)를 통해 1단계와 2단계의 초기화까지 마치게 됩니다.

// 이니셜라이저 상속 및 재정의
// 기본적으로 스위프트의 이니셜라이저는 부모클래스의 이니셜라이저를 상속받지 않습니다.
// 부모클래스로부터 물려받은 이니셜라이저는 자식클래스에 최적화되어 있지 않아서, 부모클래스의 이니셜라이저를 사용했을 때 자식클래스의 새로운 인스턴스가 완전하고 정확하게 초기화되지 않는 상황을 방지하고자 함입니다.
// 안전하고 적절하다고 판단되는 특정한 상황에서는 부모클래스의 이니셜라이저가 상속되기도 합니다.
// 보통 부모클래스의 이니셜라이저와 똑같은 이니셜라이저를 자식클래스에서 사용하고 싶다면 자식클래스에서 부모의 이니셜라이저와 똑같은 이니셜라이저를 구현해주면 됩니다.
// 부모클래스와 동일한 지정 이니셜라이저를 자식클래스에서 구현해주려면 재정의하면 됩니다. 그러려면 override 수식어를 붙여야 합니다.
// 클래스에 주어지는 기본 이니셜라이저를 재정의할 때도 마찬가지입니다. 자식클래스의 편의 이니셜라이저가 부모클래스의 지정 이니셜라이저를 재정의하는 경우에도 override 수식어를 붙여줍니다.
// 반대로 부모클래스의 편의 이니셜라이저와 동일한 이니셜라이저를 자식클래스에 구현할 때는 override 수식어를 붙이지 않습니다. 자식클래스에서 부모클래스의 편의 이니셜라이저는 절대로 호출할 수 없기 때문입니다. 즉, 재정의할 필요가 없습니다.

// 클래스 이니셜라이저의 재정의
class Person7 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class Student7: Person7 {
    var major: String
    
    override init(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7)
    }
}
// Person7 클래스를 상속받은 Student7 클래스에서 부모클래스의 편의 이니셜라이저와 동일한 편의 이니셜라이저를 정의할 때 override 수식어를 붙이지 않은 것을 볼 수 있습니다.
// 반대로 지정 이니셜라이저는 재정의를 위해 override 수식어를 사용한 것을 볼 수 있습니다.
// 기본 이니셜라이저 외에 지정 이니셜라이저를 자식클래스에서 동일한 이름으로 정의하려면 재정의를 위한 override수식어를 명시해주어야 합니다.
// 부모클래스의 실패 가능한 이니셜라이저를 자식클래스에서 재정의하고 싶을 때는 실패 가능한 이니셜라이저로 재정의해도 되고 필요에 따라서 실패하지 않는 이니셜라이저로 재정의해줄수도 있습니다.

// 실패 가능한 이니셜라이저의 재정의
class Person8 {
    var name: String
    var age: Int
    
    init() {
        self.name = "Unknown"
        self.age = 0
    }
    
    init?(name: String, age: Int) {
        
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.age = age
    }
    
    init?(age: Int) {
        
        if age < 0 {
            return nil
        }
        self.name = "Unknown"
        self.age = age
    }
}

class Student8: Person8 {
    var major: String
    
    override init?(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    override init(age: Int) {
        self.major = "Swift"
        super.init()
    }
}

// 이니셜라이저 자동 상속
// 이니셜라이저 상속 및 재정의에서 기본적으로 스위프트의 이니셜라이저는 부모클래스의 이니셜라이저를 상속받지 않습니다.
// 그러나 특정 조건에 부합한다면 부모클래스의 이니셜라이저가 자동으로 상속됩니다. 사실, 대부분의 경우 자식클래스에서 이니셜라이저를 재정의해줄 필요가 없습니다.
// 자식클래스에서 프로퍼티 기본값을 모두 제공한다고 가정할 때, 다음 두 가지 규칙에 따라 이니셜라이저가 자동으로 상속됩니다.
/*
 규칙1) 자식클래스에서 별도의 지정 이니셜라이저를 구현하지 않는다면, 부모클래스의 지정 이니셜라이저가 자동으로 상속됩니다.
 규칙2) 만약 규칙1)에 따라 자식클래스에서 부모클래스의 지정 이니셜라이저를 자동으로 상속받은 경우 또는 부모클래스의 지정 이니셜라이저를 모두 재정의하여
       부모클래스의 지정 이니셜라이저를 모두 재정의하여 부모클래스와 동일한 지정 이니셜라이저를 모두 사용할 수 있는 상황이라면 부모클래스의 편의 이니셜라이저가 모두 자동으로 상속됩니다.
*/

// 이니셜라이저 자동 상속
class Person9 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student9: Person9 {
    var major: String = "Swift"
}

// 부모클래스의 지정 이니셜라이저 자동 상속
let yagom9: Person9 = Person9(name: "yagom9")
let hana9: Student9 = Student9(name: "hana9")
print(yagom9.name)      // yagom9
print(hana9.name)       // hana9

// 부모클래스의 편의 이니셜라이저 자동 상속
let wizplan9: Person9 = Person9()
let jinSung9: Student9 = Student9()
print(wizplan9.name)        // Unknown
print(jinSung9.name)        // Unknown
// Student9의 major 프로퍼티에 기본값이 있으며, 따로 지정 이니셜라이저를 구현해주지 않았으므로 부모클래스인 Person9 클래스의 지정 이니셜라이저가 자동으로 상속됩니다.
// 이는 규칙1)에 부합합니다. 또, 부모클래스의 지정 이니셜라이저를 모두 자동으로 상속받았으므로 편의 이니셜라이저도 자동으로 상속되었습니다.

// 편의 이니셜라이저 자동 상속
class Person10 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student10: Person10 {
    var major: String
    
    override init(name: String) {
        self.major = "Unknown"
        super.init(name: name)
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}
// Student10 클래스의 major 프로퍼티에 기본값이 없더라도 이니셜라이저에서 적절히 초기화했고, 부모클래스의 지정 이니셜라이저를 모두 재정의하여
// 부모클래스의 지정 이니셜라이저와 동일한 이니셜라이저를 모두 사용할 수 있는 상황이므로 규칙1)에 부합합니다. 따라서 부모클래스의 편의 이니셜라이저가 자동으로 상속되었습니다.
// 자동 상속 규칙은 자식클래스에 편의 이니셜라이저를 추가한다고 하더라도 유효합니다. 또, 부모클래스의 지정 이니셜라이저를 자식클래스의 편의 이니셜라이저로 구현하더라도 규칙2)를 충족합니다.

// 부모클래스의 편의 이니셜라이저 자동 상속
let wizplan10: Person10 = Person10()
let jinSung10: Student10 = Student10()
print(wizplan10.name)           // Unknown
print(jinSung10.name)           // Unknown

// 편의 이니셜라이저 자동 상속2
class Person11 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student11: Person11 {
    var major: String
    
    convenience init(major: String) {
        self.init()
        self.major = major
    }
    
    override convenience init(name: String) {
        self.init(name: name, major: "Unknown")
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

// 부모클래스의 편의 이니셜라이저 자동 상속
let wizplan11: Person11 = Person11()
let jinSung11: Student11 = Student11(major: "Swift")
print(wizplan11.name)       // Unknown
print(jinSung11.name)       // Unknown
print(jinSung11.major)      // Unknown
// Student11 클래스에서 부모클래스의 지정 이니셜라이저인 init(name:)을 편의 이니셜라이저로 재정의했지만 부모의 지정 이니셜라이저를 모두 사용할 수 있는 상황인 규칙2)에 부합하므로 부모클래스의 편의 이니셜라이저를 사용할 수 있습니다.
// 또, 자신만의 편의 이니셜라이저인 convenience init(major:)를 구현해주었지만 편의 이니셜라이저 자동 상속에는 아무런 영향을 미치지 않았습니다.

// 편의 이니셜라이저 자동 상속3
class UniversityStudent3: Student11 {
    var grade: String = "A+"
    var description: String {
        return "\(self.name) \(self.major) \(self.grade)"
    }
    
    convenience init(name: String, major: String, grade: String) {
        self.init(name: name, major: major)
        self.grade = grade
    }
}

let nova3: UniversityStudent3 = UniversityStudent3()
print(nova3.description)     // Unknown

let raon3: UniversityStudent3 = UniversityStudent3(name: "raon")
print(raon3.description)     // raon Unknown A+

let joker3: UniversityStudent3 = UniversityStudent3(name: "joker", major: "Programming")
print(joker3.description)    // joker Programming A+

let chope3: UniversityStudent3 = UniversityStudent3(name: "chope", major: "Computer", grade: "C")
print(chope3.description)    // chope Computer C
// Student11 클래스를 상속받은 UniversityStudent3 클래스는 grade 프로퍼티에 기본값이 있으며, 별도의 지정 이니셜라이저를 구현해주지 않았으므로 규칙1)에 부합합니다.
// 따라서 부모클래스의 이니셜라이저를 모두 자동 상속받습니다. 결과적으로 UniversityStudent3 클래스는 상속받은 이니셜라이저와 자신의 편의 이니셜라이저들을 모두 사용할 수 있습니다.

// 요구 이니셜라이저
// required 수식어를 클래스의 이니셜라이저 앞에 명시해주면 이 클래스를 상속받은 자식클래스에서 반드시 해당 이니셜라이저를 구현해주어야 합니다.
// 상속받을 때 반드시 재정의해야 하는 이니셜라이저 앞에 required 수식어를 붙여줍니다. 다만 자식클래스에서 요구 이니셜라이저를 재정의할 때는 override 수식어 대신에 required 수식어를 사용합니다.

// 요구 이니셜라이저 정의
class Person12 {
    var name: String
    
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student12: Person12 {
    var major: String = "Unknown"
}

let miJeong: Student12 = Student12()
// Person12 클래스에 init() 요청 이니셜라이저를 구현해주었지만, Person12 클래스를 상속받은 Student12 클래스에는 요구 이니셜라이저를 구현하지 않았습니다.
// 이는 Student12 클래스의 major 프로퍼티에 기본값이 있으며 별다른 지정 이니셜라이저가 없기 때문에 이니셜라이저가 자동으로 상속된 것입니다.
// 만약 Student12 클래스에 새로운 지정 이니셜라이저를 구현한다면 부모클래스로부터 이니셜라이저가 자동으로 상속되지 않으므로 요구 이니셜라이저를 구현해주어야 합니다.

// 요구 이니셜라이저 재구현
class Person13 {
    var name: String
    
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student13: Person13 {
    var major: String = "Unknown"
    
    // 자신의 지정 이니셜라이저 구현
    init(major: String) {
        self.major = major
        super.init()
    }
    
    required init() {
        self.major = "Unknown"
        super.init()
    }
}

class UniversityStudent13: Student13 {
    var grade: String
    
    // 자신의 지정 이니셜라이저 구현
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    required init() {
        self.grade = "F"
        super.init()
    }
}

let jiSoo13: Student13 = Student13()
print(jiSoo13.name)        // Unknown
print(jiSoo13.major)        // Unknown

let yagom13: Student13 = Student13(major: "Swift")
print(yagom13.name)        // Unknown
print(yagom13.major)        // Swift

let juyHyun13: UniversityStudent13 = UniversityStudent13(grade: "A+")
print(juyHyun13.name)      // Unknown
print(juyHyun13.major)      // Unknown
print(juyHyun13.grade)      // A+
// Student13와 UniversityStudent13 클래스는 자신만의 지정 이니셜라이저를 구현했습니다. 그래서 부모클래스의 이니셜라이저를 자동 상속받지 못합니다.
// 그래서 Person13 클래스에 정의한 요구 이니셜라이저를 이니셜라이저 자동 상속 규칙에 부합하지 않는 자식클래스인 Student13에도 구현해주고, 그 자식클래스인 UniversityStudent13 클래스에도 구현해주어야 합니다.
// 이니셜라이저 자동 상속의 규칙에 부합하지 않는 한, 요구 이니셜라이저는 반드시 구현해주어야 합니다.
// 만약 부모클래스의 일반 이니셜라이저를 자신의 클래스부터 요구 이니셜라이저로 변경할 수도 있습니다. 그럴 때는 required override를 명시해주어 재정의됨과 동시에 요구 이니셜라이저가 될 것임을 명시해주어야 합니다.
// 또, 편의 이니셜라이저도 요구 이니셜라이저로 변경될 수 있습니다. 마찬가지로 required convienience를 명시해주어 편의 이니셜라이저가 앞으로 요구될 것임을 명시해주면 됩니다.

// 일반 이니셜라이저의 요구 이니셜라이저 변경
class Person14 {
    var name: String
    
    init() {
        self.name = "Unknown"
    }
}

class Student14: Person14 {
    var major: String = "Unknown"
    
    init(major: String) {
        self.major = major
        super.init()
    }
    
    // 부모클래스의 이니셜라이저를 재정의함과 동시에 요구 이니셜라이저로 변경됨을 알랍니다.
    required override init() {
        self.major = "Unknown"
        super.init()
    }
    
    // 이 요구 이니셜라이저는 앞으로 계속 요구합니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class UniversityStudent14: Student14 {
    var grade: String
    
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    // Student14 클래스에서 요구했으므로 구현해주어야 합니다.
    required init() {
        self.grade = "F"
        super.init()
    }
    
    // Student14 클래스에서 요구했으므로 구현해주어야 합니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

let yagom14: UniversityStudent14 = UniversityStudent14()
print(yagom14.grade)        // F

let juHyun14: UniversityStudent14 = UniversityStudent14(name: "JuHyun")
print(juHyun14.name)        // JuHyun
// Person14 클래스에는 별다른 요구 이니셜라이저가 없습니다. 다만 Student14 클래스에서 Person14의 init() 이니셜라이저를 재정의하면서 요구 이니셜라이저로 변경했습니다.
// 따라서 UniversitryStudent14 클래스에서는 init() 이니셜라이저를 요구 이니셜라이저로 필히 구현해주어야 합니다.
// 또, Student14 클래스의 편의 이니셜라이저 init(name:)이 요구 이니셜라이저로 지정되었기 때문에 UniversityStudent14 클래스에서 다시 구현해주어야 합니다.

