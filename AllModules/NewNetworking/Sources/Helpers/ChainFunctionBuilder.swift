//
//  ChainFunctionBuilder.swift
//  NewNetworking
//
//  Created by Araik Garibian on 12/22/20.
//

@resultBuilder public struct ChainFunctionBuilder {
	static public func  buildBlock(_ chains: HTTPLoading...) -> HTTPLoading {
		guard let lastChain = chains.last, let firstChain = chains.first else {
			return Loader.Base()
		}

		if chains.count == 1 {
			return lastChain
		}

		var tempChain: HTTPLoading?

		for currentChain in chains {
			guard let previousChain = tempChain else {
				tempChain = currentChain
				continue
			}

			previousChain.nextLoader = currentChain
			tempChain = currentChain
		}

		return firstChain
	}
}

public func makeChains(@ChainFunctionBuilder closure: () -> HTTPLoading) -> HTTPLoading {
	return closure()
}
