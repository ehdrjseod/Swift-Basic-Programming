import UIKit

// ========== 열거형 ==========
// 열거형: 열거형은 연관된 항목들을 묶어서 표현할 수 있는 타입입니다.
// 열거형은 배열이나 딕셔너리 같은 타입과 다르게 프로그래머가 정의해준 항목 값 외에는 추가/수정이 불가합니다.
// 그렇게 때문에 딱 정해진 값만 열거형 값에 속할 수 있습니다.
// 열거형은 다음과 같은 값에 속할 수 있습니다.
// - 제한된 선택지를 주고 싶을 때
// - 정해진 값 외에는 입력받고 싶지 않을 때
// - 예상된 입력 값이 한정되어 있을 때

// 스위프트 열거형은 각 열거형이 고유의 타입으로 인정되기 때문에 실수로 버그가 일어날 가능성을 원천 봉쇄할 수 있습니다.
// 열거형 각 항목이 원시 값(Raw Value)이라는 형태로 (정수, 실수, 문자 타입 등의) 실제 값을 가질 수도 있습니다.
// 또는 연관 값(Associated Values)을 사용하여 다른 언어에서 공용체라고 불리는 값의 묶음도 구현할 수 있습니다.

// ========== 기본 열거형 ==========
enum School {
    
    case primary        // 유치원
    case elementary     // 초등
    case middle         // 중등
    case high           // 고등
    case college        // 대학
    case university     // 대학교
    case graduate       // 대학원
}

/*
enum School {   // 한줄로도 표현 가능
    
    case primary, elementary, middle, high, college, university, graduate
}
*/

var highestEducationLevel:School = School.university

// 위 코드와 정확히 같은 표현입니다.
//var highestEducationLevel:School = .university

// 같은 타입인 School 내부의 항목으로만 highestEducationLevel의 값을 변경해줄 수 있습니다.
highestEducationLevel = .graduate

// ========== 원시 값(Raw Value) ==========
// ========== 열거형의 원시 값 지정과 사용 ==========
enum School2:String {
    
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let highestEducationLevel2:School2 = School2.university
print("저의 최종학력은 \(highestEducationLevel2.rawValue) 졸업입니다.")  //저의 최종학력은 대학교 졸업입니다.

enum WeekDays:Character {
    
    case mon = "월", tue = "화", wed = "수", thu = "목", fri = "금", sat = "토", sun = "일"
}

let today:WeekDays = WeekDays.fri
print("오늘은 \(today.rawValue)요일입니다.")      // 오늘은 금요일입니다.

enum School3:String {
    
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college
    case university
    case graduate
}

let highestEducationLevel3:School3 = School3.university
print("저의 최종학력은 \(highestEducationLevel3.rawValue) 졸업입니다.")  //저의 최종학력은 university 졸업입니다.

print(School3.elementary.rawValue)      // 초등학교

enum Numbers:Int {
    
    case zero
    case one
    case two
    case ten = 10
}

print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue), \(Numbers.ten.rawValue)")

// 원시 값을 통한 열거형 초기화
let primary = School3(rawValue: "유치원")      // primary
let graduate = School3(rawValue: "석박사")     // nil

let one = Numbers(rawValue: 1)              // one
let three = Numbers(rawValue: 3)            // nil

// ========== 연관 값 ==========
// 연관 값을 갖는 열거형
enum MainDish {
    
    case pasta(taste:String)
    case pizza(dough:String, topping:String)
    case chicken(withSauce:Bool)
    case rice
}

var dinner:MainDish = MainDish.pasta(taste: "크림")       // 크림파스타
dinner = .pizza(dough: "치즈크러스트", topping: "불고기")     // 불고기 치즈크러스트 피자
dinner = .chicken(withSauce: true)                      // 양념통닭
dinner = .rice                                          // 밥

// 여러 열거형의 응용
enum PastaTaste {
    
    case cream, tomato
}

enum PizzaDough {
    
    case cheeseCrust, thin, original
}

enum PizzaTopping {
    
    case pepperoni, cheese, bacon
}

enum MainDish2 {
    
    case pasta(taste: PastaTaste)
    case pizza(dough:PizzaDough, topping:PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
}

var dinner2:MainDish2 = MainDish2.pasta(taste: PastaTaste.tomato)
dinner2 = MainDish2.pizza(dough: PizzaDough.cheeseCrust, topping: PizzaTopping.bacon)

// ========== 항목 순회 ==========
// CaseIterable 프로토콜을 활용한 열거형의 항목 순회
// allCases를 직접 사용 가능
enum School4: CaseIterable {
    
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}

let allCases: [School4] = School4.allCases
print(allCases)
print([School4.primary, School4.elementary, School4.middle, School4.high, School4.college, School4.university, School4.graduate])

// available 속성을 갖는 열거형의 항목 순회
// allCases를 직접 구현해주어야 함!
enum School5: String, CaseIterable {
    
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    @available(iOS, obsoleted: 12.0)
    case graduate = "대학원"
    
    static var allCases: [School5] {
        
        let all: [School5] = [.primary,
                              .elementary,
                              .middle,
                              .high,
                              .college,
                              .university]
        
        #if os(iOS)
            return all
        #else
            return all + [.graduate]
        #endif
    }
}

let allCases2: [School5] = School5.allCases
print(allCases2)

// 연관 값을 갖는 열거형의 항목 순회
enum PastaTaste2: CaseIterable {
    
    case cream, tomato
}

enum PizzaDough2: CaseIterable {
    
    case cheeseCrust, thin, original
}

enum PizzaTopping2: CaseIterable {
    
    case pepperoni, cheese, bacon
}

enum MainDish3: CaseIterable {
    
    case pasta(taste: PastaTaste2)
    case pizza(dough:PizzaDough2, topping:PizzaTopping2)
    case chicken(withSauce: Bool)
    case rice
    
    static var allCases: [MainDish3] {
        
        return PastaTaste2.allCases.map(MainDish3.pasta) +
            PizzaDough2.allCases.reduce([]) { (result, dough) -> [MainDish3] in
                
                result + PizzaTopping2.allCases.map { (topping) -> MainDish3 in
                    
                    MainDish3.pizza(dough: dough, topping: topping)
                }
            }
            + [true, false].map(MainDish3.chicken)
            + [MainDish3.rice]
    }
}

print(MainDish3.allCases.count)     // 14
print(MainDish3.allCases)           // 모든 경우의 연관 값을 갖는 케이스 컬렉션


// ========== 순환 열거형 ==========
// 특정 항목에 순환 열거형 항목 명시
enum ArithmeticExpression {
    
    case number(Int)
    indirect case addtion(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// 열거형 전체에 순환 열거형 명시
indirect enum ArithmeticExpression2 {
    
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression2.number(5)
let four = ArithmeticExpression2.number(4)
let sum = ArithmeticExpression2.addition(five, four)
let final = ArithmeticExpression2.multiplication(sum, ArithmeticExpression2.number(2))

func evaluate(_ expression: ArithmeticExpression2) -> Int {
    
    switch expression {
    case .number(let value):
        return value
        
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
        
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
        
    }
}

let result:Int = evaluate(final)
print("(5 + 4) * 2 = \(result)")        // (5 + 4) * 2 = 18
