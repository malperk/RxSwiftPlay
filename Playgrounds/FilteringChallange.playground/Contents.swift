//: Playground - noun: a place where people can play

import RxSwift
public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}
example(of: "Challenge 1") {
    
    let disposeBag = DisposeBag()
    
    let contacts = [
        "603-555-1212": "Florent",
        "212-555-1212": "Junior",
        "408-555-1212": "Marin",
        "617-555-1212": "Scott"
    ]
    let convert: (String) -> UInt? = { value in
        if let number = UInt(value),
            number < 10 {
            return number
        }
        let format: ([UInt]) -> String = {
            var phone = $0.map(String.init).joined()
            phone.insert("-", at: phone.index(
                phone.startIndex,
                offsetBy: 3)
            )
            phone.insert("-", at: phone.index(
                phone.startIndex,
                                              offsetBy: 7)
            )
            return phone
        }
        
        let dial: (String) -> String = {
            if let contact = contacts[$0] {
                return "Dialing \(contact) (\($0))..."
            } else {
                return "Contact not found"
            }
        }
        let convert: [String: UInt] = [
            "abc": 2, "def": 3, "ghi": 4,
            "jkl": 5, "mno": 6, "pqrs": 7,
            "tuv": 8, "wxyz": 9
        ]
        var converted: UInt? = nil
        convert.keys.forEach {
            if $0.contains(value.lowercased()) {
                converted = convert[$0]
            }
        }
        return converted
    }
    
    func phoneNumber(from inputs: [Int]) -> String {
        var phone = inputs.map(String.init).joined()
        
        phone.insert("-", at: phone.index(
            phone.startIndex,
            offsetBy: 3)
        )
        
        phone.insert("-", at: phone.index(
            phone.startIndex,
            offsetBy: 7)
        )
        
        return phone
    }
    
    let input = PublishSubject<Int>()
    
    input
        .skipWhile{$0 == 0}
        .filter{$0<10}
        .take(10)
        .toArray()
        .subscribe(onNext: { element in
        print(phoneNumber(from: element))
    })
    
    input.onNext(0)
    input.onNext(603)
    
    input.onNext(2)
    input.onNext(1)
    
    // Confirm that 7 results in "Contact not found", and then change to 2 and confirm that Junior is found
    input.onNext(2)
    
    "5551212".characters.forEach {
        if let number = (Int("\($0)")) {
            input.onNext(number)
        }
    }
    
    input.onNext(9)
}
