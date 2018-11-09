//
//  ChordNod.swift
//  DLab2_K
//
//  Created by Армен Алумян on 09/11/2018.
//  Copyright © 2018 Армен Алумян. All rights reserved.
//

import Foundation

final class ChordNode {
	var id: Int
	private(set) var fingerTable: FingerTable
	var predecessor: ChordNode?
	
	var successor: ChordNode? {
		get {
			return fingerTable[0].node
		}
		set {
			fingerTable[0].node = newValue
		}
	}
	
	init(m: Int, n: Int) {
		id = n;
		fingerTable = FingerTable(m: m, n: n)
		fingerTable.table.forEach { $0.node = self }
		self.predecessor = self;
	}

	func idInRange(id: Int, a: Int, b: Int) -> Bool {
		var id = id
		var b = b
		if a >= b {
			let dCount = Double(fingerTable.table.count)
			if a > id {
				id += Int(pow(2.0, dCount))
			}
			b += Int(pow(2.0, dCount))
		}
		return (id > a) && (id < b)
	}

	func idInRangeLeft(id: Int, a: Int, b: Int) -> Bool {
		return idInRange(id: id, a: a, b: b) || id == a
	}
	
	func idInRangeRight(id: Int, a: Int, b: Int) -> Bool {
		return idInRange(id: id, a: a, b: b) || id == b
	}
	
	func findSuccessor(id: Int) -> ChordNode {
		guard let suc = findPredecessor(id: id).successor else { fatalError("error") }
		return suc
	}
	
	func findPredecessor(id: Int) -> ChordNode {
		var node = self
		guard let b = node.successor?.id else { fatalError("node.successor?.id is nil") }
		while !idInRangeRight(id: id, a: node.id, b: b) {
			node = node.closestPrecedingFinger(id: id)
		}
		return node;
	}
	
	func closestPrecedingFinger(id: Int) -> ChordNode {
		let m = fingerTable.table.count
		var i = m - 1
		while i >= 0 {
			if let node = fingerTable[i].node, idInRange(id: node.id, a: self.id, b: id) {
				return node
			}
			i -= 1
		}
		return self
	}
	
	func join(node: ChordNode?) {
		guard let node = node else {
			fingerTable.table.forEach { $0.node = self }
			predecessor = self
			return
		}
		initFingerTable(node: node)
		updateOthers()
	}
	
	func initFingerTable(node: ChordNode) {
		fingerTable[0].node = node.findSuccessor(id: fingerTable[0].start)
		guard let pred = successor?.predecessor else { fatalError("error") }
		predecessor = pred
		successor?.predecessor = self
		let m = fingerTable.table.count
		for i in 0..<m-1 {
			let fingerIPlus1 = fingerTable[i + 1]
			let fingerI = fingerTable[i]
			guard let fiId = fingerI.node?.id else { fatalError("error")}
			if idInRangeRight(id: fingerIPlus1.start, a: id, b: fiId) {
				fingerIPlus1.node = fingerI.node
			} else {
				fingerIPlus1.node = node.findSuccessor(id: fingerIPlus1.start)
			}
		}
	}
	
	func updateOthers() {
		let m = fingerTable.table.count
		///???????? m
		for i in 0..<m {
			var id = self.id - Int( pow(2.0, Double(i)) )
			id = id < 0 ? (id + Int( pow(2.0, Double(m)) )) : id
			let p = findPredecessor(id: id)
			p.updateFingerTable(n: self, i: i)
		}

	}
	
	func updateFingerTable(n: ChordNode, i: Int) {
		let fingerI = fingerTable[i]
		guard let fiId = fingerI.node?.id else { fatalError("error") }
		if idInRangeLeft(id: n.id, a: id, b: fiId) {
			fingerI.node = n
			guard let p = predecessor else { fatalError("error") }
			p.updateFingerTable(n: n, i: i)
		}
	}
	
	func remove() {
		predecessor?.successor = successor
		successor?.predecessor = predecessor
		/*int m = self.getFingerTable().getTable().length;
		for (int i = 0; i < m; i++) {
		int id = (int) (self.getId() - Math.pow(2, i));
		id = id < 0 ? (int) (id + Math.pow(2, m)) : id;
		ChordNode p = self.findPredecessor(id);
		System.out.println(p.getId());
		p.updateFingerTable(getSuccessor(), i);
		}*/
	}

	func joinStable(node: ChordNode?) {
		guard let node = node else {
			fingerTable.table.forEach { $0.node = self }
			predecessor = self
			return
		}
		predecessor = nil
		successor = node.findSuccessor(id: id)
	}
	
	func stabilize() {
		guard let x = successor?.predecessor else { fatalError("error") }
		guard let sucId = successor?.id else { fatalError("error") }
		if idInRange(id: x.id, a: id, b: sucId) {
			successor = x
		}
		successor?.notify(node: self)
	}
	
	func notify(node: ChordNode) {
		if let pred = predecessor, idInRange(id: node.id, a: pred.id, b: id) {
			predecessor = node
		} else if predecessor == nil {
			predecessor = node
		}
	}
	
	func fixFingers() {
		let r = Int.random(in: 0..<fingerTable.table.count)
		fingerTable[r].node = findSuccessor(id: fingerTable[r].start)
	}
}

extension ChordNode: CustomStringConvertible {
	var description: String {
		var predId: String = "nil"
		if let id = predecessor?.id {
			predId = String(id)
		}
		return "ChordNode{ id: \(id); predecessor: \(predId); FingerTable: \(fingerTable.description) }"
	}
}
