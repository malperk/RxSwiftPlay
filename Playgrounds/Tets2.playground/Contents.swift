//: Playground - noun: a place where people can play
import RxSwift
import RxCocoa
import UIKit

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
//
//example(of: "Driver") {
////    let safeSequence = xs
////        .observeOn(MainScheduler.instance)       // observe events on main scheduler
////        .catchErrorJustReturn(onErrorJustReturn) // can't error out
////        .shareReplayLatestWhileConnected()       // side effects sharing
//    let subject = PublishSubject<String>()
//    
//    let tr = subject.observeOn(MainScheduler.instance)
//        .catchErrorJustReturn("Alper")
//        //.share()
//        //.share(replay: 1)
//    
//    
//    
//    tr.subscribe { event in
//        print("2)", event.element ?? event)
//    }
//    tr.subscribe { event in
//        print("3)", event.element ?? event)
//    }
//    subject.onNext("1")
//    subject.onNext("1q")
//    //subject.onError(MyError.anError)
//    //subject.onCompleted()
//    
//    tr.subscribe { event in
//        print("4)", event.element ?? event)
//    }
//    
//    
//}

example(of: "Driver2") {
    let tf = Observable<String>.create({ observer in
        observer.onError(MyError.anError)
        observer.onNext("1")
        return Disposables.create()
    }).asDriver(onErrorJustReturn:"")
    
    let ui1 = UITextField()
    
    print(ui1.text)
    tf.drive(ui1.rx.text)
    print(ui1.text)
    
}

//example(of: "Driver3") {
//    let tf = Observable<String>.create({ observer in
//        observer.onError(MyError.anError)
//        observer.onNext("1")
//        return Disposables.create()
//    })
//
//    let ui1 = UITextField()
//
//    print(ui1.text)
//    tf.bind(to: ui1.rx.text)
//    print(ui1.text)
//
//}

var start = 0
func getStartNumber() -> Int {
    start += 1
    return start
}


let numbers = Observable<Int>.create { observer in
    print("subscribe")
    let start = getStartNumber()
    observer.onNext(start)
    observer.onNext(start+1)
    observer.onNext(start+2)
    observer.onCompleted()
    return Disposables.create()
}.replayAll()
let tr = numbers
tr
    .subscribe(onNext: { el in
        print("element [\(el)]")
    }, onCompleted: {
        print("-------------")
    })

tr
    .subscribe(onNext: { el in
        print("element [\(el)]")
    }, onCompleted: {
        print("-------------")
    })
