//: Playground - noun: a place where people can play

import RxSwift
import RxCocoa
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
let sch = ConcurrentDispatchQueueScheduler(queue: concurrentQueue)
let obsrv = Observable<Int>.interval(1, scheduler: sch).do( onSubscribed: {
    print("sub")
})

func driver(){
obsrv.subscribe {evnt in
    print("1",evnt,Date().description, Thread.current)
}

let driver = obsrv.asDriver(onErrorJustReturn: -1)

driver.drive(onNext: {print("1",$0,Date().description, Thread.current)})
    
}
//driver()
func signal(){
    obsrv.subscribe {evnt in
        print("1",evnt,Date().description, Thread.current)
    }
    
    let signal = obsrv.asSignal(onErrorJustReturn: -1)
    signal.emit(onNext: {print("1",$0,Date().description, Thread.current)})
    
}
//signal()
