//
//  Edge.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/6/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import Foundation

struct Edge {
    
    public let from: Vertex
    public let to: Vertex
    
    public let weight: Double?
    
    public var desc: String {
        get {
            return "(\(from.index),\(to.index))"
        }
    }
    
}

extension Edge: Equatable {
    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to && lhs.weight == rhs.weight
    }
}
