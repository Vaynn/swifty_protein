//
//  IdealProteinScene.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 06/06/2021.
//

import UIKit
import SceneKit

class IdealProteinScene: SCNScene {
    
    struct doubletConnect{
        var doublet:[Int]
    }
    
    init(atomList:[Atom], ConectList:[Conect]) {
        super.init()
        atomList.map({
            let sphere = SCNSphere(radius:0.18)
            let sphereNode = SCNNode(geometry: sphere)
            sphereNode.position = SCNVector3Make($0.x, $0.y, $0.z)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = $0.color
            sphereNode.name = $0.name
            self.rootNode.addChildNode(sphereNode)
            
        })
        var usedConnectid = [doubletConnect]()
        for conect in ConectList{
            let atom = atomList.filter({$0.id == conect.id})
            let begin = SCNVector3Make(atom[0].x, atom[0].y, atom[0].z)
            conect.connectTab.map({
                print("lili")
                print($0)
                let id = $0
                if (usedConnectid.filter({$0.doublet.contains(id) && $0.doublet.contains(atom[0].id)}).count == 0 ){
                    let linkedAtom = atomList.filter({$0.id == id})
                    usedConnectid.append(doubletConnect(doublet : [atom[0].id, id]))
                    
                    print(linkedAtom[0])
                    let end = SCNVector3Make(linkedAtom[0].x, linkedAtom[0].y, linkedAtom[0].z)
                    let mat = SCNMaterial()
                            mat.diffuse.contents  = UIColor.white
                            mat.specular.contents = UIColor.white
                    let ndLine = LineNode(
                            parent: self.rootNode, // ** needed
                            v1: begin,    // line (cylinder) starts here
                            v2: end,    // line ends here
                            radius: 0.1,   // line thickness
                            radSegmentCount: 6,     // hexagon tube
                            material: [mat] )  // any material
                    self.rootNode.addChildNode(ndLine)
                }
            })
        }
        print(usedConnectid)
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3Make(0, 0, 22)
        self.rootNode.addChildNode(cameraNode)
        print(atomList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
