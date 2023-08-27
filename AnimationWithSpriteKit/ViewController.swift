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
}

