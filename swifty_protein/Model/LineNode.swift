//
//  LineNode.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 07/06/2021.
//

import Foundation
import SceneKit

class LineNode: SCNNode
{
    init( parent: SCNNode,     // because this node has not yet been assigned to a parent.
              v1: SCNVector3,  // where line starts
              v2: SCNVector3,  // where line ends
          radius: CGFloat,     // line thicknes
      radSegmentCount: Int,    // number of sides of the line
        material: [SCNMaterial] )  // any material.
    {
        super.init()
        let  height = v1.distance(vector :v2)

        position = v1

        let ndV2 = SCNNode()

        ndV2.position = v2
        parent.addChildNode(ndV2)

        let ndZAlign = SCNNode()
        ndZAlign.eulerAngles.x = Float(Double.pi/2)

        let cylgeo = SCNCylinder(radius: radius, height: CGFloat(height))
        cylgeo.radialSegmentCount = radSegmentCount
        cylgeo.materials = material

        let ndCylinder = SCNNode(geometry: cylgeo )
        ndCylinder.position.y = -height/2
        ndZAlign.addChildNode(ndCylinder)

        addChildNode(ndZAlign)

        constraints = [SCNLookAtConstraint(target: ndV2)]
    }

    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 }

extension SCNVector3{
func distance(vector: SCNVector3) -> Float {
    let a = simd_float3(self)
    let b = simd_float3(vector)
    return simd_distance(a, b)
   }
}
