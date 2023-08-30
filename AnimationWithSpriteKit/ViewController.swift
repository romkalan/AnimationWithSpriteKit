//
//  ViewController.swift
//  AnimationWithSpriteKit
//
//  Created by Roman Lantsov on 27.08.2023.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    private lazy var animationView = SKView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard animationView.scene == nil else { return }
        
        let scene = makeScene()
        animationView.frame.size = scene.size
        addEmoji(to: scene)
        animationView.presentScene(scene)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationView.center.x = view.bounds.midX
        animationView.center.y = view.bounds.midY
    }


}

extension ViewController {
    func makeScene() -> SKScene {
        let minimumDimension = min(view.frame.width, view.frame.height)
        let size = CGSize(width: minimumDimension, height: minimumDimension)
        
        let scene = SKScene(size: size)
        scene.backgroundColor = .white
        return scene
    }
    
    func addEmoji(to scene: SKScene) {
        let emojies: [Character] = ["🌽", "🌭", "🧀", "🍤"]
        let distance = floor(scene.size.width / 4)
        
        for (index, emoji) in emojies.enumerated() {
            let node = SKLabelNode()
            node.renderEmoji(emoji)
            node.position.y = floor(scene.size.width / 2)
            node.position.x = distance * CGFloat(index) + 50
            scene.addChild(node)
            animateNode(scene.children)
        }
    }
    
    func animateNode(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            let delayAction = SKAction.wait(forDuration: TimeInterval(index) * 0.2)
            
            let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
            let scaleDownAction = SKAction.scale(to: 1, duration: 0.3)
            let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: 1.5)
            
            let scaleActionSequence = SKAction.sequence([scaleUpAction, scaleDownAction])
            let groupAction = SKAction.group([scaleActionSequence, rotateAction])
            
            let waitAction = SKAction.wait(forDuration: 2)
            
            let groupSequenceAction = SKAction.sequence([groupAction, waitAction])
            
            let repeatAction = SKAction.repeatForever(groupSequenceAction)
            let actionSequence = SKAction.sequence([delayAction, repeatAction])
            
            node.run(actionSequence)
        }
    }
}

extension SKLabelNode {
    func renderEmoji(_ emoji: Character) {
        fontSize = 50
        text = String(emoji)
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
    }
}

