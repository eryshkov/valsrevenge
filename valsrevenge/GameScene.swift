//
//  GameScene.swift
//  valsrevenge
//
//  Created by Evgenii Ryshkov on 05.01.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    let margin: CGFloat = 20
    
    private var lastUpdateTime : TimeInterval = 0
    private var player: Player?

    override func didMove(to view: SKView) {
        player = childNode(withName: "player") as? Player
        player?.move(.stop)
        setupCamera()
        
        let grassMapNode = childNode(withName: "Grass Tile Map") as? SKTileMapNode
        grassMapNode?.setupEdgeLoop()
        
        let dungeonMapNode = childNode(withName: "Dungeon Tile Map") as? SKTileMapNode
        dungeonMapNode?.setupMapPhysics()
    }

    func setupCamera() {
        guard let player = player else { return }
        let distance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(distance, to: player)
        camera?.constraints = [playerConstraint]
    }

    override func sceneDidLoad() {

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        guard let touchedNode = nodeAtPoint as? SKSpriteNode else {
            return
        }

        if touchedNode.name?.starts(with: "controller_") == true {
            let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
            player?.move(Direction(rawValue: direction ?? Direction.stop.rawValue)!)
            return
        }

        if touchedNode.name == "button_attack" {
            player?.attack()
            return
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode {
            if touchedNode.name?.starts(with: "controller_") == true {
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? Direction.stop.rawValue)!)
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode {
            if touchedNode.name?.starts(with: "controller_") == true {
                player?.stop()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }

    func updateControllerLocation() {
        let controller = childNode(withName: "//controller")
        controller?.position = CGPoint(x: viewLeft + margin + insets.left, y: viewBottom + margin + insets.bottom)

        let attackButton = childNode(withName: "//attackButton")
        attackButton?.position = CGPoint(x: viewRight - margin - insets.right, y: viewBottom + margin + insets.bottom)
    }

    override func didFinishUpdate() {
        updateControllerLocation()
    }
}
