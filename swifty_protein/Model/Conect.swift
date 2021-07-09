//
//  Conect.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 04/06/2021.
//

import Foundation

struct Conect{
    let id:Int
    var connectTab = [Int]()
    
    mutating func addTab(params:String, at start:Int, offset:Int){
        let startIndex = params.index(params.startIndex, offsetBy: start)
        let end = params.index(startIndex, offsetBy: offset)
        let link = Int(params[startIndex..<end].trimmingCharacters(in: .whitespacesAndNewlines))!
        connectTab.append(link)
    }
    
    init(with params:String){
        let start = params.index(params.startIndex, offsetBy: 6)
        let end = params.index(start, offsetBy: 5)
        let id = params[start..<end].trimmingCharacters(in: .whitespacesAndNewlines)
        self.id = Int(id)!
        
        switch params.count {
        case 16:
            addTab(params: params, at: 11, offset: 5)
        case 21:
            addTab(params: params, at: 11, offset: 5)
            addTab(params: params, at: 16, offset: 5)
        case 26:
            addTab(params: params, at: 11, offset: 5)
            addTab(params: params, at: 16, offset: 5)
            addTab(params: params, at: 21, offset: 5)
        case 31:
            addTab(params: params, at: 11, offset: 5)
            addTab(params: params, at: 16, offset: 5)
            addTab(params: params, at: 21, offset: 5)
            addTab(params: params, at: 26, offset: 5)
        default:
            return
        }
    }
}
