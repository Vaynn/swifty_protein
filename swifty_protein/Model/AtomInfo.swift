//
//  AtomInfo.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 10/06/2021.
//

import Foundation

struct AtomInfo{
    var Id:Int?
    var Name:String?
    var Atomic_Number:Int?
    var Symbol:String?
    var Masse:String?
    var Year:String?
    var Scientist:String?
    var Country:String?
    var Fusion:String?
    var Ebullition:String?
}

func getAtomInfoTab() -> [AtomInfo]{
    var AITab = [AtomInfo]()
    if let filepath = Bundle.main.path(forResource: "atoms", ofType: "csv") {
        do {
            let contents = try String(contentsOfFile: filepath)
            let contentTab = contents.split(whereSeparator: \.isNewline)
            
            for content in contentTab {
                let split = content.split(separator: ";")
                let temp = AtomInfo(Id: Int(split[0]), Name: String(split[1]), Atomic_Number: Int(split[2]) ?? 0, Symbol: String(split[3]), Masse: String(split[4]), Year: String(split[5]), Scientist: String(split[6]), Country: String(split[7]), Fusion: String(split[8]), Ebullition: String(split[9]))
                AITab.append(temp)
            }
            return AITab
        } catch {
           print(error)
            // contents could not be loaded
        }
    } else {
        // example.txt not found!
    }
    return AITab
}
