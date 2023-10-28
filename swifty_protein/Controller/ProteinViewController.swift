//
//  ProteinViewController.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 06/06/2021.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {
    
    var atomList = [Atom]()
    var conectList = [Conect]()
    var proteinName = ""
    var AtomInfoTab = [AtomInfo]()
    
    @IBOutlet weak var activity_indicator: UIActivityIndicatorView!
    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var InfoView: UIView!
    @IBOutlet weak var PeriodicSymbolView: UIView!
    @IBOutlet weak var PeriodicSymbolLabel: UILabel!
    @IBOutlet weak var PeriodicAtomicNumber: UILabel!
    @IBOutlet weak var AtomNameLabel: UILabel!
    @IBOutlet weak var AtomScientistLabel: UILabel!
    @IBOutlet weak var AtomDateAndPlaceLabel: UILabel!
    @IBOutlet weak var AtomFusionLabel: UILabel!
    @IBOutlet weak var AtomBoilingLabel: UILabel!
    @IBOutlet weak var AtomLocalization: UILabel!
    
 
    @IBAction func shared_action(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)

           // Draw view in that context
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

           // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac,animated: true)
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        activity_indicator.isHidden = false
        activity_indicator.startAnimating()
        self.title = proteinName
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "violet") ?? UIColor.red,]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        scnView.scene = IdealProteinScene(atomList: atomList, ConectList: conectList)
        scnView.backgroundColor = UIColor.white
        scnView.autoenablesDefaultLighting = true
        scnView.allowsCameraControl = true
        setInfoView()
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        scnView.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
   
    func setInfoView(){
        InfoView.layer.isHidden = true
        PeriodicSymbolView.layer.cornerRadius = 15
        PeriodicSymbolView.layer.borderWidth = 3
        PeriodicSymbolView.layer.masksToBounds = true
    }
   
    
    @objc func handleTap(rec: UITapGestureRecognizer){
        if rec.state == .ended {
                    let location: CGPoint = rec.location(in: scnView)
                    let hits = self.scnView.hitTest(location, options: nil)
                    if !hits.isEmpty{
                        let tappedNode = hits.first?.node
                        if ((tappedNode?.geometry as? SCNSphere) != nil){
                            let atom = AtomInfoTab.filter{$0.Symbol?.lowercased() == tappedNode?.name?.lowercased()}
                            PeriodicSymbolLabel.text = atom[0].Symbol
                            PeriodicAtomicNumber.text = String(atom[0].Atomic_Number!)
                            AtomNameLabel.text = atom[0].Name
                            AtomDateAndPlaceLabel.text = atom[0].Year!
                            AtomScientistLabel.text = atom[0].Scientist
                            AtomLocalization.text = atom[0].Country!
                            AtomFusionLabel.text = atom[0].Fusion
                            AtomBoilingLabel.text = atom[0].Ebullition
                            InfoView.isHidden = false
                        }
                       
                    }
               }
    }

}
extension ProteinViewController:SCNSceneRendererDelegate{
   
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.activity_indicator.isHidden = true
            self.activity_indicator.stopAnimating()
        }
       
        
    }
}

