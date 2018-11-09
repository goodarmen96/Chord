//
//  FingerTable.swift
//  DLab2_K
//
//  Created by Армен Алумян on 09/11/2018.
//  Copyright © 2018 Армен Алумян. All rights reserved.
//

final class FingerTable {
	var table: [Finger]
	
	init(m: Int, n: Int) {
		var table: [Finger] = []
		for i in 0..<m {
			let start = Finger.generateStart(m: m, n: n, i: i)
			let interval = [start, Finger.generateStart(m: m, n: n, i: i+1)]
			table.append(.init(start: start, interval: interval, node: nil))
		}
		self.table = table
	}
	
	subscript(_ i: Int) -> Finger {
		return table[i]
	}
}

extension FingerTable: CustomStringConvertible {
	var description: String {
		var str = "FT{ "
		table.forEach { str += ($0.description + " ") }
		str += "}"
		return str
	}
}
