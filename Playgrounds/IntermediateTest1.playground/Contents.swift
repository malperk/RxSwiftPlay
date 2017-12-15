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

enum MyError: Error {
    case anError
    case anotherError
}

enum Result <T, Error: Swift.Error> {
    case success(T)
    case error(Error)
}

struct Human:Codable {
    let name:String
    let age:Int
}

typealias Completion = (_ result: Result<Human, MyError>) -> Void


func testAsync(block:@escaping Completion){
    print("testAsync")
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        let flag = true
        if flag{
        block(Result.success(Human(name: "Alper", age: 12)))
        }else{
            block(Result.error(MyError.anError))
        }
    }
}

func rxTest() -> Single<Human> {
    return Single.create(subscribe: {evnt -> Disposable in
        testAsync(block: {resp in
            switch resp {
            case .success(let item):
                evnt(.success(item))
            case .error(let error):
                evnt(.error(error))
            }
        })
        return Disposables.create()
    })
}
class ff:Codable{
    
}

extension PrimitiveSequence where Trait == SingleTrait{
    func toJSON() {
        print("done")
    }
}



let sing = PublishSubject<ff>().asSingle()

//sing.toJSON()


//example(of: "Forever") {
//    let single = rxTest().asObservable().share(replay: 1, scope: .forever)
//
//    single.subscribe {evnt in
//        print(evnt)
//    }
//
//    single.subscribe {evnt in
//        print(evnt)
//    }
//
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        single.subscribe {evnt in
//            print(evnt)
//        }
//    }
//}



example(of: "SingleFlatMap") {
    let single = rxTest()
    //single.toJSON()
}

