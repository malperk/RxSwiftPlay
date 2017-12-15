//: Playground - noun: a place where people can play

import RxSwift
enum MyError: Error {
    case anError
}
public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening?")
    let subscriptionOne = subject
        .subscribe(onNext: { string in
            print(string)
        })
    subject.on(.next("1"))
    subject.onNext("2")
    let subscriptionTwo = subject
        .subscribe { event in
            print("2)", event.element ?? event)
    }
    subject.onNext("3")
    subscriptionOne.dispose()
    subject.onNext("4")
    subject.onCompleted()
    subject.onNext("5")
    subscriptionTwo.dispose()
    let disposeBag = DisposeBag()
    subject
        .subscribe {
            print("3)", $0.element ?? $0)
        }
        .disposed(by: disposeBag)
    subject.onNext("?")
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}
example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "Initial value")
    let disposeBag = DisposeBag()
    subject.subscribe {
        print(label: "1)", event: $0)
        }.disposed(by: disposeBag)
    
    subject.onNext("X")
    //subject.dispose()
    subject.subscribe {
        print(label: "2)", event: $0)
        }.disposed(by: disposeBag)
}

example(of: "ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    let disposeBag = DisposeBag()
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    
    subject.subscribe {
        print(label: "1)", event: $0)
    }
    .disposed(by: disposeBag)
    
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: disposeBag)
    subject.onNext("4")
    subject.onError(MyError.anError)
    subject.dispose()
    subject
        .subscribe {
            print(label: "3)", event: $0)
        }
        .disposed(by: disposeBag)
}























