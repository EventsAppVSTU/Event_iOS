//
//  AlertCenter.swift
//  AppFoundation
//
//  Created by Metalluxx on 26.04.2021.
//  Copyright © 2021 metalluxx. All rights reserved.
//

public final class Container {
	private(set) var storage: [Key: Any] = [:]

    public init() {}

    public func resolve<T>(
        _ dependency: T.Type = T.self,
        name: String? = nil
    ) throws -> T {
		let key = Key(name: name, identifier: ObjectIdentifier(dependency))
		guard let resolver = storage[key] as? Resolver<T> else {
			throw Container.Error.registration("Не найдена регистрация для зависимости: \(dependency)!")
		}

		switch resolver.scope {
		case .unique:
			return try resolver.factory(self)

		case .shared:
			guard let instance = resolver.instance else {
				let instance = try resolver.factory(self)
				defer { resolver.instance = instance }
				return instance
			}

			return instance

		case .graph:
			guard let instance = resolver.weakInstance as? T else {
				let instance = try resolver.factory(self)
				defer { resolver.weakInstance = instance as AnyObject }
				return instance
			}

			return instance
		}
	}

    public func resolveMarker<T, M>(
        _ dependency: T.Type = T.self,
        marker: M
    ) throws -> T where M: RawRepresentable, M.RawValue == String {
        try resolve(T.self, name: marker.rawValue)
    }

    public func register<T>(
        _ dependency: T.Type,
        scope: Container.Scope = .unique,
        name: String? = nil,
        _ factory: @escaping (Container) throws -> T
    ) rethrows {
		let service = Resolver(scope: scope, factory: factory)
		let key = Key(name: name, identifier: ObjectIdentifier(dependency))
		storage[key] = service
	}

    public func registerMarker<T, M>(
        _ dependency: T.Type,
        scope: Container.Scope = .unique,
        marker: M,
        _ factory: @escaping (Container) throws -> T
    ) rethrows where M : RawRepresentable, M.RawValue == String {
        try register(dependency, scope: scope, name: marker.rawValue, factory)
    }
}

public extension Container {
    enum Error: Swift.Error {
		case registration(String)
	}
}

public extension Container {
	enum Scope {
		case unique
		case shared
		case graph
	}

	struct Key: Hashable {
		let name: String?
		let identifier: ObjectIdentifier
	}
}

extension Container {
    final class Resolver<T> {
        var instance: T?
        weak var weakInstance: AnyObject?
        let factory: (Container) throws -> T
        let scope: Container.Scope

        init(
            scope: Container.Scope,
            factory: @escaping (Container) throws -> T
        ) {
            self.scope = scope
            self.factory = factory
        }
    }
}
