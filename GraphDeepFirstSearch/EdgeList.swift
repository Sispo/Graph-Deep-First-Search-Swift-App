//
//  EdgeList.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/7/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import Foundation

class EdgeList {
    
    let vertex: Vertex
    var edges: [Edge] = []
    
    init(vertex: Vertex) {
        self.vertex = vertex
    }
    
    func add(edge: Edge) {
        edges.append(edge)
    }
    
}
