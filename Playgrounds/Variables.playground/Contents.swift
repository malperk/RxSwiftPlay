//: Playground - noun: a place where people can play

import RxSwift
enum MyError: Error {
    case anError
}
public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

example(of: "Variable") {
    var variable = Variable("Initial value")
    let disposeBag = DisposeBag()
    variable.value = "New initial value"
    variable.asObservable()
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: disposeBag)
    variable.value = "1"
    variable.asObservable()
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)
    variable.value = "2"
    
//    variable.value.onError(MyError.anError)
//    variable.asObservable().onError(MyError.anError)
//    variable.value = MyError.anError
//    variable.value.onCompleted()
//    variable.asObservable().onCompleted()
    
}
