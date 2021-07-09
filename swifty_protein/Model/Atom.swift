//
//  Atom.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 04/06/2021.
//

import Foundation
import UIKit

struct Atom{
    let id:Int
    let x:Float
    let y:Float
    let z:Float
    let name:String
    let color:UIColor
    
    init(with parameters:String){
        var start = parameters.index(parameters.startIndex, offsetBy: 6)
        var end = parameters.index(start, offsetBy: 5)
        let id = parameters[start..<end].trimmingCharacters(in: .whitespacesAndNewlines)
        self.id = Int(id)!
        
        start = parameters.index(parameters.startIndex, offsetBy: 30)
        end = parameters.index(start, offsetBy: 8)
        self.x = Float(parameters[start..<end].trimmingCharacters(in: .whitespacesAndNewlines))!
        
        start = parameters.index(parameters.startIndex, offsetBy: 38)
        end = parameters.index(start, offsetBy: 8)
        self.y = Float(parameters[start..<end].trimmingCharacters(in: .whitespacesAndNewlines))!
        
        start = parameters.index(parameters.startIndex, offsetBy: 46)
        end = parameters.index(start, offsetBy: 8)
        self.z = Float(parameters[start..<end].trimmingCharacters(in: .whitespacesAndNewlines))!
        
        start = parameters.index(parameters.startIndex, offsetBy: 76)
        end = parameters.index(start, offsetBy: 2)
        self.name = String(parameters[start..<end].trimmingCharacters(in: .whitespacesAndNewlines))
        
        self.color = setMoleculeColor(molecule: self.name)
        
        func setMoleculeColor(molecule: String) -> UIColor{
            switch molecule {
            case "H":
               return UIColor.white
            case "O":
               return UIColor.red
            case "FE":
               return UIColor.orange
            case "N":
               return UIColor.blue
            case "C":
               return UIColor.black
            case "F":
               return UIColor.green
            case "HE":
               return UIColor(red: 216/255, green: 255/255, blue: 254/255, alpha: 1.0)
            case "LI":
               return UIColor(red: 204/255, green: 128/255, blue: 255/255, alpha: 1.0)
            case "NA":
               return UIColor(red: 172/255, green: 92/255, blue: 242/255, alpha: 1.0)
            case "MG":
               return UIColor(red: 139/255, green: 255/255, blue: 0/255, alpha: 1.0)
            case "S":
               return UIColor(red: 254/255, green: 255/255, blue: 48/255, alpha: 1.0)
            case "BR":
               return UIColor(red: 167/255, green: 41/255, blue: 41/255, alpha: 1.0)
            case "CL":
               return UIColor(red: 28/255, green: 240/255, blue: 31/255, alpha: 1.0)
            case "B":
               return UIColor(red: 255/255, green: 181/255, blue: 181/255, alpha: 1.0)
            case "P":
               return UIColor(red: 255/255, green: 128/255, blue: 1/255, alpha: 1.0)
            case "MO":
               return UIColor(red: 85/255, green: 181/255, blue: 181/255, alpha: 1.0)
            case "I":
               return UIColor(red: 147/255, green: 1/255, blue: 148/255, alpha: 1.0)
            case "AU":
               return UIColor(red: 255/255, green: 209/255, blue: 33/255, alpha: 1.0)
            case "V":
               return UIColor(red: 166/255, green: 166/255, blue: 171/255, alpha: 1.0)
            case "CO":
               return UIColor(red: 240/255, green: 144/255, blue: 160/255, alpha: 1.0)
            case "BA":
               return UIColor(red: 0/255, green: 201/255, blue: 0/255, alpha: 1.0)
            case "CU":
               return UIColor(red: 201/255, green: 128/255, blue: 51/255, alpha: 1.0)
            case "CA":
               return UIColor(red: 161/255, green: 54/255, blue: 212/255, alpha: 1.0)
            case "AS":
               return UIColor(red: 189/255, green: 128/255, blue: 227/255, alpha: 1.0)
            case "CD":
               return UIColor(red: 255/255, green: 216/255, blue: 143/255, alpha: 1.0)
            case "CS":
               return UIColor(red: 87/255, green: 23/255, blue: 143/255, alpha: 1.0)
            case "RU":
               return UIColor(red: 37/255, green: 143/255, blue: 143/255, alpha: 1.0)
            case "EU":
               return UIColor(red: 96/255, green: 255/255, blue: 199/255, alpha: 1.0)
            case "GA":
               return UIColor(red: 193/255, green: 143/255, blue: 143/255, alpha: 1.0)
            case "HG":
               return UIColor(red: 184/255, green: 184/255, blue: 208/255, alpha: 1.0)
            case "U":
               return UIColor(red: 0/255, green: 144/255, blue: 255/255, alpha: 1.0)
            case "K":
               return UIColor(red: 143/255, green: 64/255, blue: 212/255, alpha: 1.0)
            case "LA":
               return UIColor(red: 112/255, green: 212/255, blue: 255/255, alpha: 1.0)
            case "MN":
               return UIColor(red: 156/255, green: 122/255, blue: 199/255, alpha: 1.0)
            case "SE":
               return UIColor(red: 255/255, green: 160/255, blue: 0/255, alpha: 1.0)
            case "NI":
               return UIColor(red: 80/255, green: 207/255, blue: 79/255, alpha: 1.0)
            case "PB":
               return UIColor(red: 86/255, green: 89/255, blue: 96/255, alpha: 1.0)
            case "PD":
               return UIColor(red: 0/255, green: 105/255, blue: 132/255, alpha: 1.0)
            case "PT":
               return UIColor(red: 208/255, green: 208/255, blue: 224/255, alpha: 1.0)
            case "W":
               return UIColor(red: 32/255, green: 148/255, blue: 213/255, alpha: 1.0)
            case "RB":
               return UIColor(red: 112/255, green: 47/255, blue: 176/255, alpha: 1.0)
            case "RH":
               return UIColor(red: 10/255, green: 125/255, blue: 140/255, alpha: 1.0)
            case "SR":
               return UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
            case "TB":
               return UIColor(red: 49/255, green: 255/255, blue: 198/255, alpha: 1.0)
            case "TL":
               return UIColor(red: 166/255, green: 84/255, blue: 77/255, alpha: 1.0)
            case "XE":
               return UIColor(red: 66/255, green: 159/255, blue: 176/255, alpha: 1.0)
            case "YB":
               return UIColor(red: 1/255, green: 191/255, blue: 56/255, alpha: 1.0)
            case "ZN":
               return UIColor(red: 126/255, green: 128/255, blue: 175/255, alpha: 1.0)
            default:
               return UIColor.yellow
            }
        }

    }
    
    
}
