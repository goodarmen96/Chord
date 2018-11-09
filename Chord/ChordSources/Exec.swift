//
//  Exec.swift
//  DLab2_K
//
//  Created by Армен Алумян on 09/11/2018.
//  Copyright © 2018 Армен Алумян. All rights reserved.
//

import Foundation

func exec() {
	let m = 5

	/*
	let count = 100
	var indexesSet: Set<Int> = []
	for _ in 0..<count*16 {
		let rand = Int.random(in: 0..<Int( pow(2.0, Double(m)) ))
		indexesSet.insert(rand)
	}
	let indexes = Array(indexesSet.prefix(count)).sorted()

	var nodes: [ChordNode] = [];
	
	var head: ChordNode?

	indexes.forEach { print($0) }
	
	indexes.forEach {
		let node = ChordNode(m: m, n: $0)
		
		node.joinStable(node: head)
		nodes.append(node)
		if head == nil {
			head = nodes.first
		}
	}
	
	for _ in 0..<count {
		nodes.forEach() {
			$0.stabilize()
		}
	}
	
	for _ in 0..<count {
		nodes.forEach() {
			$0.fixFingers()
		}
	}
	
	nodes.forEach() { print($0) }
	*/
	
	//    /*
	let head = ChordNode(m: m, n: 0)
	head.join(node: nil)
	let second = ChordNode(m: m, n: 1)
	second.joinStable(node: head)
	//second.join(node: head)
	let tail = ChordNode(m: m, n: 3)
	tail.joinStable(node: head)
	//tail.join(node: head)
	let extra = ChordNode(m: m, n: 6)
	extra.joinStable(node: head)
	//extra.join(node: head)
	let extra1 = ChordNode(m: m, n: 7)
	extra1.joinStable(node: head)
	//extra1.join(node: head)
	for _ in 0..<10 {
		head.stabilize()
		second.stabilize()
		tail.stabilize()
		extra.stabilize()
		
		extra1.stabilize()
		
		head.fixFingers()
		second.fixFingers()
		tail.fixFingers()
		extra.fixFingers()
		
		extra1.fixFingers()
	}
	
	print(head)
	print(second)
	print(tail)
	print(extra)
	print(extra1)
	
	second.remove()
	print()
	print(head)
	print(tail)
	print(extra)
	print(extra1)
	
	for _ in 0..<100 {
		head.stabilize()
		tail.stabilize()
		extra.stabilize()
		
		extra1.stabilize()
		
		head.fixFingers()
		tail.fixFingers()
		extra.fixFingers()
		
		extra1.fixFingers()
	}

	print()
	print(head)
	print(tail)
	print(extra)
	print(extra1)
	//    */
	
	print("exit")
}
