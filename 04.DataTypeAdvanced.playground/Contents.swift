import UIKit

// ========== 데이터 타입 고급 ==========
// 데이터 타입 안심 : 스위프트는 타입에 굉장이 민감하고 엄격
//                서로 다른 타입끼리의 데이터 교환은 꼭 타입캐스팅을 거쳐야 함.
//                스위프트에서 값 타입의 데이터 교환은 타입캐스팅이 아닌 새로운 인스턴스를 생성하여 할당

// 스위프트는 테이터 타입을 안심하고 사용할 수 잇는 언어(Type - safe)
// 타입 확인 : 스위프트가 컴파일 시 타입을 확인하는 것

// ========== 타입 추론 ==========
// 타입을 지정하지 않았으나 타입 추론을 통하여 name은 String 타입으로 선언
var name = "Kwanhee"

// 앞서 타입 추론에 의해 name은 String 타입의 변수로 지정되었기 때문에
// 정수를 할당하려고 시도하면 오류가 발생.
//name = 100

// ========== 타입 별칭 ==========
// 스위프트에서 기본으로 제공하는 데이터 타입이든, 사용자가 임의로 만든 데이터 타입이든
// 이미 존재하는 데이터 타입에 임의로 다른 이름(별칭)을 부여할 수 있습니다.

typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age:MyInt = 100             // MyInt는 Int의 또 다른 이름입니다.
var year:YourInt = 2080         // YourInt도 Int의 또 다른 이름입니다.

// MyInt도, YourInt도 Int이기 때문에 같은 타입으로 취급합니다.
year = age

let month:Int = 7               // 물론 기존의 Int도 사용 가능합니다.
let percentage:MyDouble = 99.9  // Int 외에 다른 자료형도 모두 별칭 사용이 가능

// ========== 튜플 기본 ==========
// 튜플 : 타입의 이름이 따로 지정되어 있지 않은, 프로그래머 마음대로 만드는 타입 (지정된 데이터 묶음)
// 튜플은 따로 이름이 없으므로 일정 타입의 나열만으로 튜플 타입을 생성
// 튜플에 포함될 데이터의 개수는 자유롭게 정할 수 있음

// String, Int, Double 타입을 갖는 튜플
var person:(String, Int, Double) = ("yagom", 100, 182.5)

// 인덱스를 통해서 값을 빼 올 수 있습니다.
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

person.1 = 99           // 인덱스를 통해 값을 할당할 수 있습니다.
person.2 = 178.5

print("이름: \(person.0), 나이: \(person.1), 신장:\(person.2)")

// ========== 튜플 별칭 지정 ==========
typealias PersonTuple = (name:String, age:Int, height:Double)

let yagom:PersonTuple = ("yagom", 100, 178.5)
let eric:PersonTuple = ("eric", 150, 183.5)

print("이름: \(yagom.name), 나이: \(yagom.age), 신장: \(yagom.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")

// ========== 배열 ==========
// 배열 : 같은 타입의 데이터를 일렬로 나열한 후 순서대로 저장하는 형태의 컬렉션 타입
// isEmpty : 비어 있는 배열인지 확인
// count : 배열에 몇 개의 요소가 존재하는지 확인
/*
 [NOTE] 스위프트의 Array
  스위프트의 Array는 C언어의 배열처럼 버퍼입니다. 단, C언어처럼 한 번 선언하면 크기가 고정되던 버퍼가 아니라,
  필요에 따라 자동으로 버퍼의 크기를 조절해주므로 요소의 삽입 및 삭제가 자유롭습니다.
  스위프트는 이런 리스트 타입을 Array, 즉 배열이라고 표현합니다. 기존 언어의 배열과는 조금 다른 특성도 있지만
  이 책에서도 Array를 배열이라고 표현
 */

// ========== 배열의 선언과 생성 ==========
// 대괄호를 사용하여 배열임을 표현합니다.
var names:Array<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 위 선언과 정확히 동일한 표현입니다. [String]은 Array<String>의 축약 표현입니다.
var names2:[String] = ["yagom", "chulsoo", "younghee", "yagom"]

//var emptyArray:[Any] = [Any]()          //Any 데이터를 요소로 갖는 빈 배열을 생성합니다.
//var emptyArray:[Any] = Array<Any>()     //위 선언과 정확히 같은 동작을 하는 코드입니다.

// 배열의 타입을 정확히 명시해줬다면 []만으로도 빈 배열을 생성할 수 있습니다.
var emptyArray:[Any] = []
print(emptyArray.isEmpty)       //true
print(names.count)              //4

// ========== 배열의 사용 ==========
print(names[2])                 //younghee
names[2] = "jenny"              //2
print(names[2])                 //jenny
//print(names[4])                 //인덱스의 범위를 벗어났기 때문에 오류가 발생합니다.

//names[4] = "elsa"               //인덱스의 범위를 벗어났기 때문에 오류가 발생합니다.
names.append("elsa")            //마지막에 elsa가 추가됩니다.
names.append(contentsOf: ["john", "max"])   //맨 마지막에 john과 max과 추가됩니다.
names.insert("happy", at: 2)                //인덱스 2에 삽입됩니다.

// 인덱스 5의 위치에 jinhee와 minsoo가 삽입됩니다.
names.insert(contentsOf: ["jinhee", "minsoo"], at: 5)

print(names[4])                              //yagom
print(names.firstIndex(of: "yagom"))         //0
print(names.firstIndex(of: "christal"))      //nil
print(names.first!)                          //yagom
print(names.last!)                           //max

let firstItem:String = names.removeFirst()
let lastItem:String = names.removeLast()
let indexZeroItem:String = names.remove(at: 0)

print(firstItem)                //yagom
print(lastItem)                 //max
print(indexZeroItem)            //chulsoo
print(names[1 ... 3])           //["jenny", "yagom", "jinhee"]

// ========== 딕셔너리 ==========
// 딕셔너리 : 요소들이 순서 없이 키와 값의 쌍으로 구성되는 컬렉션 타입
// 딕셔너리에 저장되는 값은 항상 키와 쌍을 이루게 됨, 키가 하나이거나 여러 개일 수도 있음.
// 하나의 딕셔너리 안의 키는 같은 이름을 중복해서 사용할 수 없습니다.
// isEmpty : 비어있는 딕셔너리인지 확인
// count : 딕셔너리의 요소 개수 확인

// ========== 딕셔너리의 선언과 생성 ==========
// typealias를 통해 조금 더 단순하게 표현해볼 수도 있습니다.
typealias StringIntDictionary = [String:Int]

// 키는 String, 값은 Int 타입인 빈 딕셔너리를 생성합니다.
var numberForName:Dictionary<String, Int> = Dictionary<String, Int>()

// 위 선언과 같은 표현입니다. [String:Int]는 Dictionary<String, Int>의 축약 표현입니다.
var numberForName2:[String:Int] = [String:Int]()

// 위 코드와 같은 동작을 합니다.
var numberForName3:StringIntDictionary = StringIntDictionary()

// 딕셔너리의 키와 값 타입을 정확히 명시해줬다면 [:]만으로도 빈 딕셔너리를 생성할 수 있습니다.
var numberForName4:[String:Int] = [:]

// 초깃값을 주어 생성해줄 수도 있습니다.
var numberForName5:[String:Int] = ["yagom":100, "chulsoo":200, "jenny":300]

print(numberForName5.isEmpty)        //false
print(numberForName5.count)          //3

// ========== 딕셔너리의 사용 ==========
print(numberForName5["chulsoo"])     //200
print(numberForName5["minji"])       //nil

numberForName5["chulsoo"] = 150
print(numberForName5["chulsoo"])     //150

numberForName5["max"] = 999          //max라는 키로 999라는 값을 추가해줍니다.
print(numberForName5["max"])           //999

print(numberForName5.removeValue(forKey: "yagom"))

// 위에서 yagom 키에 해당하는 값이 이미 삭제되었으므로 nil이 반환됩니다.
// 키에 해당하는 값이 없으면 기본값을 돌려주도록 할 수도 있습니다.
print(numberForName5.removeValue(forKey: "yagom"))      //nil

// yagom 키에 해당하는 값이 없으면 기본으로 0이 반환됩니다.
print(numberForName5["yagom", default: 0])      //0


// ========== 세트 ==========
// 세트: 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 형태의 컬렉션 타입
// 세트 내의 값은 모두 유일한 값, 즉 중복된 값이 존재하지 않습니다.
// 세트트 보통 순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우에 사용
// 세트의 요소로는 해시 가능한 값이 들어와야 함.

// ========== 세트의 선언과 생성 ==========
var namesSet:Set<String> = Set<String>()       //빈 세트 생성
var namesSet2:Set<String> = []                  //빈 세트 생성

// Array와 마찬가지로 대괄호를 사용합니다.
var namesSet3:Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 그렇기 때문에 타입 추론을 사용하게 되면 컴파일러는 Set가 아닌 Array로 타입을 지정합니다.
var numbers = [100, 200, 300]
print(type(of: numbers))        // Array<Int>

print(namesSet3.isEmpty)            // false
print(namesSet3.count)              // 3 - 중복된 값은 허용되지 않아 yagom은 1개만 남는다.

// ========== 세트의 사용 ==========
print(namesSet3.count)          // 3
namesSet3.insert("jenny")
print(namesSet3.count)          // 4

print(namesSet3.remove("chulsoo"))  // chulsoo
print(namesSet3.remove("john"))     // nil

// ========== 세트의 활용 - 집합연산 ==========
let englishClassStudents:Set<String> = ["john", "chulsoo", "yagom"]
let koreanClassStudents:Set<String> = ["jenny", "yagom", "chulsoo", "hana", "minsoo"]

// 교집합 {"yagom", "chulsoo"}
let intersectSet:Set<String> = englishClassStudents.intersection(koreanClassStudents)

// 여집합의 합(배타적 논리합) {"john", "jenny", "hana", "minsoo"}
let symmertricDiffSet:Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)

// 합집합 {"minsoo", "jenny", "john", "yagom", "chulsoo", "hana}
let unionSet:Set<String> = englishClassStudents.union(koreanClassStudents)

// 차집합 {"john"}
let subtractSet:Set<String> = englishClassStudents.subtracting(koreanClassStudents)

print(unionSet.sorted())        // ["chulsoo", "hana", "jenny", "john", "minsoo", "yagom"]

// ========== 세트의 활용 - 포함관계 연산 ==========
let 새:Set<String> = ["비둘기", "닭", "기러기"]
let 포유류:Set<String> = ["사자", "호랑이", "곰"]
let 동물:Set<String> = 새.union(포유류)       // 새와 포유류의 합집합

print(새.isDisjoint(with: 포유류))      // 서로 배타적인지 - true
print(새.isSubset(of: 동물))           // 새가 동물의 부분집합인가요? - true
print(동물.isSuperset(of: 포유류))      // 동물은 포유류의 전체집합인가요? - true
print(동물.isSuperset(of: 새))         // 동물은 새의 전체집합인가요? - true

/*
 [TIP] 컬렉션에서 임의의 요소 추출과 뒤섞기
 스위프트 4.2버전에서 컬렉션에서 임의의 요소를 추출하는 randomElement() 메서드와 컬렉션의 요소를
 임의로 뒤섞는 shuffle() 메서드가 추가되었습니다. 또, 자신의 요소는 그대로 둔 채 새로운 컬렉션에
 임의의 순서로 섞어서 반환하는 shuffled() 메소드도 추가되었습니다.
 */
var array:[Int] = [0, 1, 2, 3, 4]
var set:Set<Int> = [0, 1, 2, 3, 4]
var dictionary:[String:Int] = ["a":1, "b":2, "c":3]
var string:String = "string"

print(array.randomElement())        // 임의의 요소
print(array.shuffled())             // 뒤죽박죽된 배열 [4, 2, 3, 1, 0] - array 내부의 요소는 그대로 있습니다.
print(array)                        // [0, 1, 2, 3, 4]
array.shuffle()                     // array 자체를 뒤죽박죽으로 뒤섞기
print(array)                        // 뒤죽박죽된 배열 [0, 4, 3, 2, 1]

print(set.shuffled())               // 세트를 뒤섞으면 배열로 반환해줍니다.
//set.shuffle()                     // 오류 발생! 세트는 순서가 없기 때문에 스스로 뒤섞을 수 없습니다.
print(dictionary.shuffled())        // 딕셔너리를 섞으면 (키, 값)이 쌍을 이룬 튜플의 배열로 반환해줍니다.
print(string.shuffled())            // String도 컬렉션입니다!
