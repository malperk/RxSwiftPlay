//: Playground - noun: a place where people can play

import RxSwift
import RxCocoa
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
let sch = ConcurrentDispatchQueueScheduler(queue: concurrentQueue)
let obsrv = Observable<Int>.interval(1, scheduler: sch).do( onSubscribed: {
    print("sub")
})

func sample1() {
obsrv.subscribe {evnt in
    print("1",Thread.current)
    print("1",evnt)
}
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    obsrv.subscribe {evnt in
        print("2",Thread.current)
        print("2",evnt)
    }}
}
//sample1()



func sample2() { //REPLAY
    let replay = obsrv.replay(2)
    replay.subscribe {evnt in
        print("1",Date().description, Thread.current)
        print("1",evnt)
    }
    replay.connect()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        replay.subscribe {evnt in
            print("2",Date().description, Thread.current)
            print("2",evnt)
        }}
 
}
//sample2()



func sample3() {//REPLAYALL
    let replay = obsrv.replayAll()
    replay.subscribe {evnt in
        print("1",Thread.current)
        print("1",evnt)
    }
    replay.connect()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        replay.subscribe {evnt in
            print("2",Thread.current)
            print("2",evnt)
        }}
    
}
//sample3()

func sample4() {//SHARE
    let replay = obsrv.share(replay:5)
    replay.subscribe {evnt in
        print("1",evnt,Date().description, Thread.current)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        replay.subscribe {evnt in
            print("2",evnt,Date().description, Thread.current)
        }}
    
}
//sample4()

func sample5() {//MULTICAST
    let subject = PublishSubject<Int>()
    let replay = obsrv.multicast(subject)
    subject.subscribe {evnt in
        print("1",evnt,Date().description, Thread.current)
    }
    replay.connect()
    replay.subscribe {evnt in
        print("2",evnt,Date().description, Thread.current)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        replay.subscribe {evnt in
            print("3",evnt,Date().description, Thread.current)
        }}
    
}
//sample5()



