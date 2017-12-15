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

example(of: "ignoreElements") {
    // 1
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    // 2
    strikes
        //.debug("1", trimOutput: false)
        .ignoreElements()
        .subscribe { _ in
            print("You're out!")
        }
        .disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    //strikes.onError(MyError.anError)
    strikes.onCompleted()
}

example(of: "elementAt") {
    let strikes = PublishSubject<String>()
    let disposeBag = DisposeBag()
    strikes
        .elementAt(2)
        .subscribe(onNext: { _ in
            print("You're out!")
        })
        .disposed(by: disposeBag)
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
}

example(of: "filter") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6)
        .filter { integer in
            integer % 2 == 0
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "skip") {
    let disposeBag = DisposeBag()
    Observable.of("A", "B", "C", "D", "E", "F")
        .skip(3)
        .subscribe(onNext: {
            print($0) })
        .disposed(by: disposeBag)
}

example(of: "skipWhile") {
    let disposeBag = DisposeBag()
    Observable.of(2, 2, 3, 4, 4)
        .skipWhile { integer in
            integer % 2 == 0
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "skipUntil") {
    let disposeBag = DisposeBag()
   // let subject = ReplaySubject<String>.create(bufferSize: 2)
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    subject
        .skipUntil(trigger)
        .subscribe(onNext: {
            print($0) })
        .disposed(by: disposeBag)
    subject.onNext("A")
    subject.onNext("B")
    trigger.onNext("X")
    subject.onNext("C")
//    subject.subscribe(onNext: {
//        print($0) })
//        .disposed(by: disposeBag)
}

example(of: "take") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3, 4, 5, 6)
        .debug()
        .take(3)
        .subscribe(onNext: {
            print($0) })
        .disposed(by: disposeBag)
}


example(of: "takeWhileWithIndex") {
    let disposeBag = DisposeBag()
    Observable.of(2, 2, 4, 4, 6, 6)
        .takeWhileWithIndex { integer, index in
            integer % 2 == 0 && index < 3
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "takeUntil") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    subject
        .takeUntil(trigger)
        .subscribe(onNext: {
            print($0) })
        .disposed(by: disposeBag)
    subject.onNext("1")
    subject.onNext("2")
    trigger.onNext("X")
    subject.onNext("3")
}

example(of: "distinctUntilChanged") {
    let disposeBag = DisposeBag()
    Observable.of("A", "A", "B", "B", "A")
        .distinctUntilChanged()
        .subscribe(onNext: {
            print($0) })
        .disposed(by: disposeBag)
}

example(of: "distinctUntilChanged(_:)") {
    let disposeBag = DisposeBag()
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        .distinctUntilChanged { a, b in
            guard let aWords = formatter.string(from:a)?.components(separatedBy: " "),let bWords = formatter.string(from: b)?.components(separatedBy: " ")
                    else {
                    return false
            }
            //print(aWords,bWords)
            var containsMatch = false
            for aWord in aWords {
                for bWord in bWords {
                    if aWord == bWord {
                        containsMatch = true
                        break
                    } }
            }
            return containsMatch
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}





























