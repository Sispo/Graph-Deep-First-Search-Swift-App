//
//  Graph.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/6/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import Foundation

class Graph {
    
    var adjacencyList: [EdgeList] = []
    
    var verticles: [Vertex] {
        var vertices = [Vertex]()
        for edgeList in adjacencyList {
            vertices.append(edgeList.vertex)
        }
        return vertices
    }
    
    var edges: [Edge] {
        var allEdges = [Edge]()
        for edgeList in adjacencyList {
            
            for edge in edgeList.edges {
                if !allEdges.contains(edge) {
                    allEdges.append(edge)
                }
            }
        }
        return allEdges
    }
    
    func addEdge(from: Vertex, to: Vertex, weight: Double?) -> Edge {
        
        let edge = Edge(from: from, to: to, weight: weight)
        let edgeList = adjacencyList[from.index]
        edgeList.add(edge: edge)
        return edge
    }
    
    func addVertex() -> Vertex {
        
        let vertex = Vertex(index: adjacencyList.count)
        adjacencyList.append(EdgeList(vertex: vertex))
        return vertex
        
    }
    
}
