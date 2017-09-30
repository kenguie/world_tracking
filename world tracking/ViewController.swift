//
//  ViewController.swift
//  world tracking
//
//  Created by Kenrick Guie on 9/23/17.
//  Copyright © 2017 Kenrick Guie. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Add(_ sender: Any) {
        let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.1))
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        cylinder.position = SCNVector3(0,0,-0.3)
        cylinder.eulerAngles = SCNVector3(Float(90.degreesToRadians),0,0)
        self.sceneView.scene.rootNode.addChildNode(cylinder)
        
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        pyramid.position = SCNVector3(0,0,-0.5)
        cylinder.addChildNode(pyramid)
        
//        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
//        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        let node = SCNNode()
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//        node.geometry?.firstMaterial?.specular.contents = UIColor.yellow
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        node.position = SCNVector3(0.2,0.3,-0.2)
//        boxNode.position = SCNVector3(0,-0.05,0)
//        doorNode.position = SCNVector3(0, -0.02, 0.053)
//        self.sceneView.scene.rootNode.addChildNode(node)
//        node.addChildNode(boxNode)
//        boxNode.addChildNode(doorNode)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options:
            [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

extension Int {
    var degreesToRadians: Double {return Double(self) * .pi/180}
}

