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
    
}

extension Edge: Equatable {
    public static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.from && lhs.weight == rhs.weight
    }
}
