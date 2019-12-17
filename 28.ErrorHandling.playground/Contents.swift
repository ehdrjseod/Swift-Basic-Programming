// ========== 오류처리(Error Handling) ==========
// 대부분의 프로그래밍 언어는 프로그램에서 발생하는 오류에 대비하기 위해 오류를 처리하는 기능을 제공합니다.
// 스위프트도 오류를 적절할 수 있는 기능을 제공합니다.

// ========== 오류처리(Error Handling)란? ==========
// 오류처리(Error Handling)는 프로그램이 오류를 일으켰을 때 이것을 감지하고 회복시키는 일련의 과정입니다.

// ========== 오류(Error)의 표현 ==========
// 스위프트에서 오류(Error)는 Error라는 프로토콜을 준수하는 타입의 값을 통해 표현됩니다.
// Error 프로토콜은 사실상 요구사항이 없는 빈 프로토콜일 뿐이지만, 오류를 표현하기 위한 타입(주로 열거형)은 이 프로토콜을 채택합니다.
// 스위프트의 열거형은 오류의 종류를 나타내기에 아주 적합한 기능입니다. 연관 값을 통해 오류에 관한 부가 정보를 제공할 수도 있습니다.

// 자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
// 열거형을 통해 오류의 종류를 표현하는 것이 가장 일반적이며 편리한 방법입니다.
// 이렇게 오류의 종류를 미리 예상한 다음, 오류 때문에 다음에 행할 동작이 정상적으로 진행되지 않을 때라면 오류를 던져(Throw Error)주면 됩니다.
// 오류를 던져줄 때는 throw 구문을 사용합니다. 만약 자금이 부족하고 동전이 5개 더 필요한 상황이라면 throw VendingMachineError.insufficientFunds(coinsNeeded: 5)라고 오류를 던져줄 수 있습니다.

// ========== 오류(Error) 포착 및 처리 ==========
// 오류를 던질 수도 있지만 오류가 던져지는 것에 대비하여 던져진 오류를 처리하기 위한 코드도 작성해야 합니다.
// 예를 들어 던져진 오류가 무엇인지 판단하여 다시 문제를 해결한다든지, 다른 방법으로 문제 해결을 시도해 본다든지, 오류를 알리고 사용자에게 선택 권한을 넘겨주어
// 다음에 어떤 동작을 하게 할 것인지 결정하도록 유도하는 등의 코드를 작성해야 합니다.
/*
  * 함수에서 발생한 오류를 해당 함수를 호출한 코드에 알리는 방법
  * do-catch 구문을 이용하여 오류를 처리하는 방법
  * 옵셔널 값으로 오류를 처리하는 방법
  * 오류가 발생하지 않을 것이라고 확신하는 방법
*/

// 함수에서 발생한 오류 알리기
// 먼함수가 오류를 던지면 프로그램의 흐름이 바뀔 가능성이 매우 큽니다. 그러므로 어디서 오류를 던지고 받을 것인가 결정하는 것은 매우 중요합니다.
// try 키워드로 던져진 오류를 받을 수 있습니다. try 키워드는 try 또는 try?, try! 등으로 표현할 수 있습니다.
// 함수, 메서드, 이니셜라이저의 매개변수 뒤에 throws 키워드를 사용하면 해당 함수, 메서드, 이니셜라이저는 오류를 던질 수 있습니다.
// 일반적으로 func cannotThrowErrors() -> String 처럼 표현하던 것에 func canThrowErrors() throws -> String처럼
// throws 키워드를 명시해주면 오류를 던질 수 있습니다. 이런 함수는 호출했을 때, 동작 도중 오류가 발생하면 자신을 호출한 코드에 오류를 던져서 오류를 알릴 수 있습니다.
/*
 [TIP] throws는 함수나 메서드의 자체 타입에도 영향을 미칩니다. 즉, throws 함수나 메서드는 같은 이름의 throws가 명시되지 않는 함수나 메서드와 구분됩니다.
       또, throws를 포함한 함수, 메서드, 이니셜라이저는 일반 함수, 메서드, 이니셜라이저로 재정의할 수 없습니다.
       반대로 일반 함수, 메서드, 이니셜라이저는 throws 함수, 메서드, 이니셜라이저로 재정의 할 수 있습니다.
*/

// 자판기 동작 도중 발생한 오류 던지기
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = {
        "Candy Bar": Item(price: 12, count: 7)
        "Chips": Item(price: 10, count: 4)
        "Biscuit": Item(price: 7, count: 11)
    }
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = self.inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom": "Chips",
    "jinsung": "Biscuit",
    "heejin": "Chocolate"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 30

var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)     // Biscuit 제공
print(purchase.name)        // Biscuit

for (person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}
// Biscuit 제공
// Biscuit
// yagom Chips
// Chips 제공
// jinsung Biscuit
// heejin Chocolate

// 오류 발생!!

// do-catch 구문을 이용하여 오류처리
// 함수, 메서드, 이니셜라이저 등에서 오류를 던져주면 오류 발생을 전달받은 코드 블록은 do-catch 구문을 사용하여 오류를 처리해주어야 합니다.
// do 절 내부의 코드에서 오류를 던지면 catch 절에서 오류를 전달받아 적절이 처리해주면 됩니다.

/*
do {
    try 오류 발생 가능코드
    오류가 발생하지 않으면 실행할 코드
    
} catch 오류 패턴 1 {
    처리 코드
} catch 오류 패턴 2 where 추가 조건 {
    처리 코드
}
*/

// do-catch 구문을 사용하여 던져진 오류를 처리
func buyFavoriteSnack2(person: String, vendingMachine: VendingMachine) {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    tryingVend2(itemNamed: snackName, vendingMachine: vendingMachine)
}

struct PurchasedSnack2 {
    let name: String
    init(name: String, vendingMachine: VendingMachine) {
        tryingVend2(itemNamed: name, vendingMachine: vendingMachine)
        self.name = name
    }
}

func tryingVend2(itemNamed: String, vendingMachine: VendingMachine) {
    do {
        try vendingMachine.vend(itemNamed: itemNamed)
    } catch VendingMachineError.invalidSelection {
        print("유효하지 않은 선택")
    } catch VendingMachineError.outOfStock {
        print("품절")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("자금 부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
    } catch {
        print("그 외 오류 발생 : ", error)
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 20

var purchase: PurchasedSnack2 = PurchasedSnack2(name: "Biscuit", vendingMachine: machine)       // Biscuit 제공

print(purchase.name)        // Biscuit

purchase = PurchasedSnack2(name: "Ice Cream", vendingMachine: machine)      // 유효하지 않은 선택

print(purchase.name)        // Ice Cream

for (person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack2(person: person, vendingMachine: machine)
}
// yagom Chips
// Chips 제공
// jinsung Biscuit
// 자금 부족 - 동전 4개를 추가로 지급해주세요.
// heejin Chocolate
// 유효하지 않은 선택

// 옵셔널 값으로 오류처리
// try?를 사용하여 옵셔널 값으로 변환하여 오류를 처리할 수도 있습니다. try? 표현을 통해 동작하던 코드가 오류를 던지면 그 코드의 반환 값은 nil이 됩니다.

// 옵셔널 값으로 오류처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)        // nil

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)        // Optional(100)

// 옵셔널 값으로 오류를 처리하는 방법과 기존 옵셔널 반환 타입과결합
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {
        return data
    }
    if let data = try? fetchDataFromServer() {
        return data
    }
    return nil
}

// 오류가 발생하지 않을 것이라고 확신하는 방법
// 오류를 처리하는 마지막 방법으로는 오류가 발생하지 않을 것이라는 확신을 갖고 처리하는 방법입니다.
// 코드를 작성하는 프로그래머가 오류를 던질 수 있는 함수 등을 호출할 때 오류가 절대로 발생하지 않을 것이라고 확신할 수 있는 상황이라면
// 오류가 발생하지 않을 것이라는 전제하에 try! 표현을 사용할 수 있습니다.
// 이 표현은 다른 느낌표 표현(암시적 추출 옵셔널, 강제 타입캐스팅 등)과 마찬가지로 실제 오류가 발생하면 런타임 오류가 발생하여 프로그램이 강제로 종료됩니다.

// 오류가 발생하지 않음을 확신하여 오류처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
    }
}
