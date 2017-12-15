//: Playground - noun: a place where people can play

import RxSwift


let numbers = Observable<Int>.create { observer in
    let start = getStartNumber()
    observer.onNext(start)
    observer.onNext(start+1)
    observer.onNext(start+2)
    observer.onCompleted()
    return Disposables.create()
}.share()

var start = 0
func getStartNumber() -> Int {
    start += 1
    return start
}

let tr = numbers
    .subscribe(onNext: { el in
        print("element [\(el)]")
    }, onCompleted: {
        print("-------------")
    }
)

numbers
    .subscribe(onNext: { el in
        print("element1 [\(el)]")
    }, onCompleted: {
        print("-------------")
    }
)

numbers
    .subscribe(onNext: { el in
        print("element2 [\(el)]")
    }, onCompleted: {
        print("-------------")
    }
)
//////////////////////////

let subject = PublishSubject<String>()
subject.onNext("Is anyone listening?")
let subscriptionOne = subject
    .take(2)
    .subscribe({evnt in
        print(evnt)
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

struct ter{
    var re = 23
    var tf = "dad"
    }


let subject2 = PublishSubject<ter>()

subject2.map { $0.re}.subscribe { evt in
    print (evt)
}

subject2.onNext(ter.init())





