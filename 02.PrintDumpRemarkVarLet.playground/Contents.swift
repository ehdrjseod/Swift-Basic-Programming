import UIKit


//print()와 dump() 함수
//print() : 디버깅 콘솔에 간략한 정보를 출력 - 출력하려는 인스턴스의 description 프로퍼티에 해당하는 내용을 출룍
//dump() : 자세한 정보 출력 - 출력하려는 인스턴스의 자세한 내부 콘텐츠까지 출력

struct BasicInformation {
    
    let name: String
    var age: Int
}

var yagomInfo:BasicInformation = BasicInformation(name: "yagom", age: 99)

class Person {
    
    var height:Float = 0.0
    var weight:Float = 0.0
}

let yagom:Person = Person()
    
yagom.height = 182.5
yagom.weight = 78.5

print(yagomInfo)    //BasicInformation(name: "yagom", age: 99)
dump(yagomInfo)

/*

 BasicInformation(name: "yagom", age: 99)
 ▿ __lldb_expr_19.BasicInformation
   - name: "yagom"
   - age: 99
 
*/

print(yagom)    //Person
dump(yagom)

/*
 __lldb_expr_19.Person
 ▿ __lldb_expr_19.Person #0
   - height: 182.5
   - weight: 78.5
 */


// 문자열 보간법
let name2:String = "yagom"
print("My name is \(name2)")

//한줄 주석

/*
 여러줄 주석 가능
 */

/* 여러 줄 주석 안쪽에
 /* 추가로 여러 줄 주석을 포함할 수 있으며
 //그 안에 한 줄 주석을 추가하여도 무방
 */
 이 부분도 주석처리 가능
 */

/// 오류타입의 열거형입니다.
/// - noName : 이름을 전달받지 못했을 때 발생하는 오류
/// - incorrectAge(age: Int) : 나이가 0세 미만, 150세 초과인 경우 잘못된 나이로 인식하여 오류로 처리
/// - unknown: 알 수 없는 오류

enum HelloError:Error {
    
    case noName
    case incorrectAge(age: Int)
    case unkown
}

/**
  
  여기에 작성되는 텍스트는 Description 부분에 표기됩니다.
 
   텍스트 간에 한 줄을 비워놓으면 줄 바꿈이 됩니다.
 
  '-', '+', '*'를 사용하여 원형 글머리 기호를 사용할 수 있습니다.
 
   - 이렇게 말이죠
   + 이렇게도 되고요
   * 이렇게도 됩니다.
 
   아니면 번호로 글머리 기호를 매겨줄 수도 있습니다.
    
    1. 1번
    2. 2번
    6. 3번
 
    ---
      문단 바꿈
 
       바를 세 개 이상 사용하면 긴 줄로 문단을 나눠줍니다.
    ---
 
    언더바 또는 별표를 사용하여 텍스트를 강조할 수 있습니다.
 
    텍스트를 기울이고 싶으면 *A pair of marks*를 사용하고
 
    텍스트를 굵게 표기하고 싶으면 **Two pair of marks** 를 사용하면 됩니다.
 
    관련 링크도 넣어줄 수 있습니다.
    
    [Swift Blog](https://swift.org/blog)
 
    ---
    등호를 사용하면 바로 위 텍스트를 큰 제목으로 표시해줍니다. 텍스트 앞에 #을 하나 붙여줘도 동일한 효과를 냅니다.
 
    #큰 제목 표시
    ===
        바를 사용하면 바로 위 텍스트를 중간 크기 제목으로 표시해줍니다. 텍스트 앞에 #을 두 개 붙여줘도 동일한 효과를 냅니다.
 
    ##사용 예
    ---
 
    다른 텍스트보다 네 칸 이상 들여쓰기 하면 코드 블록을 만들어 줍니다. 또한 강세표를 세 개 이상 한 쌍으로 묶어도 코드 블록을 만들어 줍니다.
 
    //코멘트도 넣어줄 수 있다.
    let myName:String = "yagom"
    try helloSwift(myName, yourAge: 100)
 
        ''''
        let myName: String = "yagom"
        try helloSwift(myName, yourAge: 100)
        ''''
 
    Precondition, Postcondition, Requires, invariant, Complexity, Important, Warning,
    Author, Authors, Copyright, Date, SeeAlso, Since, Version, Attention, Bug,
    Experiment, Note, Remark, ToDo 등의 키워드를 통해 적절한 정보를 제공해보세요.
    - note: 강조하고픈 메모를 노트로 남겨둘 수 있습니다.
    - author: 작성자를 남길 수 있습니다.
    - warning: 주의해야 할 점을 남길 수도 있습니다.
 
    ---
    > 매개변수와 반환 값 등도 적절히 표기해줄 수 있습니다.
    - parameters:
        - yourName: 당신의 이름
        - yourAge: 당신의 나이. 0 미만 또는 150을 초과하면 오류 발생
    - Throws: 오류가 발생하면 HelloError의 한 케이스를 throw
    - returns: Hello string
 */
func helloSwift(yourName: String?, yourAge age: Int = 0) throws -> String {
    
    guard let name:String = yourName else {
        
        throw HelloError.noName
    }
    
    if age > 150 {
        
        throw HelloError.incorrectAge(age: age)
    }
    
    return "Hello Swift!! My name is \(name)." + (age > 0 ? " I'm \(age) years old." : "")
}

//변수
// var [변수명] : [데이터 타입] = [값]
var name3:String = "yagom"
var age:Int = 100
var job = "iOS Programmer"  //타입 추론이 사용되었습니다.
var height = 181.5          //실수 타입에 타입 추론으로 어떤 타입이 지정되는지 확인해보세요.

print("\(type(of:height))")
age = 99                    //변수는 값을 변경해줄 수 있습니다.
job = "Writer"              //값을 변경할 때는 기존과 같은 타입의 값을 할당해주어야 합니다.
print("저의 이름은 \(name3)이고, 나이는 \(age)세이며, 직업은 \(job)입니다. 비밀이지만, 키는 \(height)센티미터 입니다.")

//상수
let name4:String = "yagom"  //챃후 변경하지 않는 값은 상수로 선언합니다.
var age2: Int = 100
var job2 = "iOS Programmer"  //타입 추론이 사용되었습니다.
let height2 = 181.5          //실수 타입은 타입 추론으로 어떤 타입이 지정되는지 확인해보세요.
age2 = 99                    //변수는 값을 변경할 수 있습니다.
job2 = "Writer"              //값을 변경할 때는 기존과 동일한 타입의 값을 할당해야 합니다.
name2 = "야곰"                //상수로 선언된 값은 변경할 수 없습니다. 오류가 발생합니다.
print("저의 이름은 \(name4)이고, 나이는 \(age2)세이며, 직업은 \(job2)입니다. 비밀이지만, 키는 \(height2)센티미터 입니다.")

