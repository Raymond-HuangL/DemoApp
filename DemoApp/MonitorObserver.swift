//
//  MonitorObserver.swift
//  DemoApp
//
//  Created by 黄磊 on 2022/9/26.
//

import Foundation

class MonitorObserver: StoreMonitorOberver, PresentMonitorOberver {
    
    public static var shared: MonitorObserver = .init()
    
    public func receiveStoreEvent<State>(_ event: StoreEvent<State>) where State : StorableState {
        switch event {
        case .createStore(let store):
            print("Create store of \(store.stateId)")
        case .beforeReduceActionOn(let store, let reduceFrom, let action):
            print("Store of \(store.stateId) will \(reduceFrom) with \(action)")
        case .afterReduceActionOn(let store, let reduceFrom, let action, let newState):
            print("Store of \(store.stateId) did \(reduceFrom) with \(action) to \(newState)")
        case .reduceNotRegisterForActionOn(let store, let reduceFrom, let action):
            print("Reduce not register of \(action) while \(reduceFrom) on store of \(store.stateId)")
        case .willDirectUpdateStateOn(let store, let newState):
            print("State of \(store.stateId) will update to \(newState)")
        case .willDirectUpdateStateValueOn(let store, let keyPath, let newState):
            print("State of \(store.stateId) will update \(keyPath) from \(store.state[keyPath: keyPath]) to \(newState)")
        case .didUpdateStateOn(let store, _):
            print("State of \(store.stateId) did update to \(store.state)")
        case .reduceInOtherReduce(let store, let curAction, let otherAction):
            print("Store of \(store.stateId) reduce action \(curAction) while other action \(otherAction) is reducing. So padding it")
        case .cyclicObserve(let from, let to):
            print("Cyclic observe from store of \(from.stateId) to store of \(to.stateId)")
        case .destroyStore(let store):
            print("Destroy store of \(store.stateId)")
        case .fatalError(let string):
            print(string)
        }
    }
    
    func receivePresentEvent(_ event: PresentEvent) {
        switch event {
        case .presentFailed(let anyViewRoute, let targetRouteNotFound):
            print("Present \(anyViewRoute) failed, reason is \(targetRouteNotFound)")
        case .presentFailedNotRegister(let anyViewRoute):
            print("Present \(anyViewRoute) failed, reason is route not register")
        case .presentFailedCannotMakeInitData(let anyViewRoute):
            print("Present \(anyViewRoute) failed, reason is can not make init data")
        case .presentFailedCannotMakeView(let anyViewRoute):
            print("Present \(anyViewRoute) failed, reason is can not make view")
        case .dismissFailed(let targetRouteNotFound):
            print("Dismiss failed, reason is \(targetRouteNotFound)")
        case .freezeFailed(let targetRouteNotFound):
            print("Freeze failed, reason is \(targetRouteNotFound)")
        case .unfreezeFailed(let targetRouteNotFound):
            print("Unfreeze failed, reason is \(targetRouteNotFound)")
        case .fatalError(let string):
            print(string)
        }
    }
}
