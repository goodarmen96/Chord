//
//  Finger.swift
//  DLab2_K
//
//  Created by Армен Алумян on 09/11/2018.
//  Copyright © 2018 Армен Алумян. All rights reserved.
//

import Foundation

final class Finger {
	var start: Int
	var interval: [Int]
	var node: ChordNode?
	
	init(start: Int, interval: [Int], node: ChordNode?) {
		self.start = start
		self.interval = interval
		self.node = node
	}
	
	static func generateStart(m: Int, n: Int, i: Int) -> Int {
		let dI = Double(i)
		let dN = Double(n)
		let dM = Double(m)
		
		return Int(dN + pow(2.0, dI)) % Int(pow(2.0, dM))
	}
}

extension Finger: CustomStringConvertible {
	var description: String {
		var id = "nil"
		if let intId = node?.id {
			id = String(intId)
		}
		return "F{\(start)|[\(interval[0]),\(interval[1]))|\(id)}"
	}
}
