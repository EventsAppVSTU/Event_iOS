//
//  FuncExtensions.swift
//   
//
//  Created by Araik Garibian on 5/11/20.
//  Copyright © 2020 user. All rights reserved.
//

// swiftlint:disable identifier_name

import Foundation

@discardableResult
public func with<A: AnyObject>(_ value: A, _ configure: (A) -> Void) -> A {
    configure(value)
    return value
}

@discardableResult
public func with<A>(_ value: inout A, _ configure: (inout A) -> Void) -> A {
    configure(&value)
    return value
}

public func allSatisfy<S: Sequence>(_ value: S.Element) -> (S) -> Bool where S.Element: Equatable {
    return { $0.allSatisfy(isEqual(to: value)) }
}

public func isEqual<V: Equatable>(to value: V) -> (V) -> Bool {
    return { value == $0 }
}

public func isNotEqual<V: Equatable>(to value: V) -> (V) -> Bool {
    return { value != $0 }
}

public func set<T: AnyObject, V>(
    _ keyPath: ReferenceWritableKeyPath<T, V>
) -> (V) -> (T) -> Void {
    return { value in { $0[keyPath: keyPath] = value } }
}

public func set<T: AnyObject, V>(
    _ keyPath: ReferenceWritableKeyPath<T, V>,
    _ value: V
) -> (T) -> Void {
    return { $0[keyPath: keyPath] = value }
}

public func set<T: AnyObject, V>(_ keyPath: ReferenceWritableKeyPath<T, V>) -> (T) -> (V) -> Void {
    return { instance in
        let localInstance = instance

        return { [weak localInstance] value in
			localInstance?[keyPath: keyPath] = value
        }
    }
}

@inline(__always) public func unowned<T: AnyObject, A>(
	_ instance: T,
	_ method: @escaping (T, A) -> Void
) -> (A) -> Void {
	return { [unowned instance] arg in
		method(instance, arg)
	}
}

@inline(__always) public func unowned<T: AnyObject>(_ instance: T, _ method: @escaping (T) -> Void) -> () -> Void {
	return { [unowned instance] in
		method(instance)
	}
}

@inline(__always) public func unowned<T: AnyObject, R>(_ instance: T, _ method: @escaping (T) -> R) -> () -> R {
	return { [unowned instance] in
		method(instance)
	}
}

@inline(__always) public func unowned<T: AnyObject, A, R>(_ instance: T, _ method: @escaping (T, A) -> R) -> (A) -> R {
	return { [unowned instance] arg in
		method(instance, arg)
	}
}

public func unowned<T: AnyObject, A, V>(_ instance: T, _ method: @escaping (T) -> (A) -> V) -> (A) -> V {
    return { [unowned instance] arg in
        method(instance)(arg)
    }
}

public func unowned<T: AnyObject, A>(_ instance: T, _ method: @escaping (T) -> (A) -> Void) -> (A) -> Void {
    return { [unowned instance] arg in
        method(instance)(arg)
    }
}

public func unowned<T: AnyObject, V>(_ instance: T, _ method: @escaping (T) -> () -> V) -> () -> V {
    return { [unowned instance] in
        method(instance)()
    }
}

public func unowned<T: AnyObject>(_ instance: T, _ method: @escaping (T) -> () -> Void) -> () -> Void {
    return { [unowned instance] in
        method(instance)()
    }
}

public func just<A, R>(_ value: R) -> (A) -> R {
    return { _ in value }
}

public func it<A>(_ arg: A) -> A {
    arg
}

public func isEqual<P: Equatable, T>(_ keyPath: KeyPath<T, P>, to value: P) -> (T) -> Bool {
    return { $0[keyPath: keyPath] == value }
}

public func sideEffect<A, R>(_ closure: @escaping (A) -> R) -> (A) -> A {
    return { _ = closure($0); return $0 }
}

public func sideEffect<R>(_ closure: @escaping () -> R) -> () -> Void {
    return { _ = closure() }
}

public func sideEffect(_ closure: @escaping () -> Void) -> () -> Void {
    return { closure() }
}

public func sideEffect<A, R>(_ closure: @escaping () -> R) -> (A) -> A {
    return { _ = closure(); return $0 }
}

public func sideEffect<A>(_ closure: @escaping (A) -> Void) -> (A) -> A {
    return { _ = closure($0); return $0 }
}

public func two<R, A, B>(_ kp0: KeyPath<R, A>, _ kp1: KeyPath<R, B>) -> (R) -> (A, B) {
    return { ($0[keyPath: kp0], $0[keyPath: kp1]) }
}

// swiftlint:disable:next large_tuple
public func three<R, A, B, C>(_ kp0: KeyPath<R, A>, _ kp1: KeyPath<R, B>, _ kp2: KeyPath<R, C>) -> (R) -> (A, B, C) {
    return { ($0[keyPath: kp0], $0[keyPath: kp1], $0[keyPath: kp2]) }
}

public func cast<T, R>(to type: R.Type) -> (T) -> R? {
    return { $0 as? R }
}

public func when<V>(
    _ closure: @escaping (V) -> Bool,
    _ executeTrue: @escaping () -> Void,
    else executeFalse: (() -> Void)? = nil
) -> (V) -> Void {
    return { value in
        if closure(value) {
            executeTrue()
        } else {
            executeFalse?()
        }
    }
}

prefix operator ^

public prefix func ^ <T, V>(_ keyPath: KeyPath<T, V>) -> (T) -> V {
    return { $0[keyPath: keyPath] }
}

precedencegroup ForwardApplication {
    associativity: left
    higherThan: ForwardComposition
}

infix operator |> : ForwardApplication

@discardableResult public func |> <A, B>(_ o: A, g: @escaping (A) -> B) -> B {
    g(o)
}

precedencegroup KeyPathSetting {
    higherThan: ForwardApplication
}

infix operator .~ : KeyPathSetting

public func .~ <T: AnyObject, V>(_ keyPath: ReferenceWritableKeyPath<T, V>, _ value: V) -> (T) -> T {
    return { $0[keyPath: keyPath] = value; return $0 }
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator >>> : ForwardComposition

public func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

public func returnFirstObject<A, B>() -> (A, B) -> A {
	{ a, _ in return a }
}
