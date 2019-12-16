// ========== 타입 중첩(Nested Types) ==========
// 열거형은 특정 클래스나 구조체의 기능을 명확히 사용하기에 용의합니다. 그러나 굳이 클래스나 구조체 외부에서는 열거형을 사용할 필요가 없을 때도 있습니다.
// 즉, 클래스나 구조체 내부에서 자신의 역할을 충실히 할 수 있도록 역할을 구분짓는 열거형을 선언해주고 자신의 내부에서만 사용할 수 있기를 원할 수도 있습니다.
// 또는 특정 데이터 타입들을 하나의 클래스나 구조체에 구현하여 외부와의 혼선을 피하고 싶을 수도 있습니다.
// 스위프트에는 타입 내부에 타입을 정의하고 구현할 수 있습니다. 타입 내부에 새로운 타입을 선언해준 것을 중첩 타입(Nested Types)이라고 부릅니다.

// ========== 중첩 데이터 타입 ==========
// 함수를 중첩해 사용했듯이 클래스 내부에 새 클래스, 클래스 내부에 새 구조체, 구조체 내부에 새 열거형 등 타입을 중첩해서 타입 내부에 새 타입을 정의할 수 있습니다.

// 중첩 데이터 타입 구현
class Person {
    enum Job {
        case jobless, programmer, student
    }
    
    var job: Job = .jobless
}

class Student: Person {
    enum School {
        case elementary, middle, high
    }
    
    var school: School
    
    init(school: School) {
        self.school = school
        super.init()
        self.job = .student
    }
}

let personJob: Person.Job = .jobless
let studentJob: Student.Job = .student

let student: Student = Student(school: .middle)
print(student.job)          // student
print(student.school)       // middle
// Person 클래스 내부에 중첩 데이터 타입으로 Job이라는 열거형 타입이 정의되어 있습니다. 또, Student 클래스 내부에는 중첩 데이터 타입으로 School이라는 열거형 타입이 정의되어 있습니다.
// 데이터 타입을 중첩 구현하는 것은 보기에는 열거형을 외부에 정의했던 것과 크게 다르지 않아 보입니다. 다만 중첩 데이터 타입을 사용할 때는 자신을 둘러싼 타입(자신이 속해 있는 타입)의 이름을 자신보다 앞에 적어줘야합니다.

// 같은 이름의 중첩 데이터 타입 구현
struct Sports {
    enum GameType {
        case football, basketball
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var time: Int
        var player: Int
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
            case .basketball:
                return GameInfo(time: 40, player: 5)
            case .football:
                return GameInfo(time: 90, player: 11)
        }
    }
}

struct ESports {
    enum GameType {
        case online, offline
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var location: String
        var pakage: String
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
        case .online:
            return GameInfo(location: "www.liveonline.co.kr", pakage: "LOL")
        case .offline:
            return GameInfo(location: "제주", pakage: "SA")
        }
    }
}

var basketball: Sports = Sports(gameType: .basketball)
print(basketball.gameInfo)      // (time: 40, player: 5)

var sudden: ESports = ESports(gameType: .offline)
print(sudden.gameInfo)          // (location: "제주", pakage: "SA")

let someGameType: Sports.GameType = .football
let anotherGameType: ESports.GameType = .online
//let errorIfYouWantIt: Sports.GameType = .online     // 오류발생
