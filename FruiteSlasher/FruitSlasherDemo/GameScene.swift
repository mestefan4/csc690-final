//
//  GameScene.swift
//  FruitNinjaDemo
//
//  Created by Michael on 25/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GamePhase {
    case ReadyToPlay
    case InPlaying
    case GameOver
}

class GameScene: SKScene {
    
    var Phase = GamePhase.ReadyToPlay
    
    var fruitCrush = 0
    var highScore = 0
    var fruiteMiss = 0
    
    var maxCount = 3
    
    // create instance of scene object
    var promptLabel = SKLabelNode()
    var fruitCrushLabel = SKLabelNode()
    var staticFruitLabel = SKLabelNode()
    var highScoreLabel = SKLabelNode()
    
    var fruiteThrowTimer = Timer()
    var xMarks = XClass()
    var expOver = SKShapeNode()
    
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
//    let maxAspectRatio: CGFloat
//    let playableArea: CGRect
    
    func drawPlayableArea() {
        
    }
    

    //Initialize game scene value
    override func didMove(to view: SKView) {
        
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        //Set Fruite Crush Score Label Frame
        fruitCrushLabel = childNode(withName: "score label") as! SKLabelNode
        staticFruitLabel = childNode(withName: "staticFruitLabel") as! SKLabelNode
        fruitCrushLabel.text = "\(fruitCrush)"
        
        
        staticFruitLabel.position = CGPoint(x: 20 + staticFruitLabel.frame.size.width / 2, y: size.height-65)
        fruitCrushLabel.position = CGPoint(x: staticFruitLabel.position.x + staticFruitLabel.frame.size.width + 5, y: size.height-60)
        
        //Set Fruite Crush Best Score Label Frame
        highScoreLabel = childNode(withName: "best label") as! SKLabelNode
        highScoreLabel.position = CGPoint(x: 20 + highScoreLabel.frame.size.width / 2, y: fruitCrushLabel.position.y - fruitCrushLabel.frame.size.height - 15)
        
        // Main Heading Set in Center.
        promptLabel = childNode(withName: "prompt label") as! SKLabelNode
        promptLabel.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
        
        
        // Set Three Cross Image In Right Corner.
        xMarks = XClass(num: maxCount)
        xMarks.position = CGPoint(x: size.width-60, y: size.height-60)
        addChild(xMarks)
        
        
        // Set Explode Fruit
        expOver = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        expOver.fillColor = .white
        addChild(expOver)
        expOver.alpha = 0
        
        // Load Data
        if UserDefaults.standard.object(forKey: "best") != nil {
            highScore = UserDefaults.standard.object(forKey: "best") as! Int
        }
        // Set HighScore Label
        highScoreLabel.text = "Best: \(highScore)"
       highScoreLabel.position = CGPoint(x: 20 + highScoreLabel.frame.size.width / 2, y: fruitCrushLabel.position.y - fruitCrushLabel.frame.size.height - 15)
       
    }
    
    //Start the Game If GamePhase is .Ready
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if Phase == .ReadyToPlay {
            Phase = .InPlaying
            playGame()
        }
    }
    
    //crush fruits and Increase score
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let loacation = t.location(in: self)
            
            let previous = t.previousLocation(in: self)
            for node in nodes(at: loacation){
                // Check the node is Fruit or not?
                if node.name == "fruit"{
                    // Sound Effect
                    playSoundEffect(soundFile: "fruits.mp3")

                    fruitCrush += 1
                    fruitCrushLabel.text = "\(fruitCrush)"
                    
                    // fruite remove
                    node.removeFromParent()
                    
                    // exploding Effect
                    touchEffect(position: node.position)
                    
                    
                }
                // Check the node is a bomb or not?
                if node.name == "bomb"{
                    // Bomb Sound
                    playSoundEffect(soundFile: "bomb.mp3")

                    
                    // Expose bomb and game Over
                    bombCrash()
                    
                    // Game Over
                    gameOver()
                    
                    // exploding Effect
                    touchEffect(position: node.position)
                    
                }
            }
            // draw line on moving finger
            let line = Line(pos: loacation, lastpos: previous, width: 8, color: .black)
            addChild(line)
            // remove Line
            line.run(SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0.2),
                SKAction.removeFromParent()
                ]))
        }
    }
    
    // Remove missed fruit and incerease counter of missed fruits
    override func didSimulatePhysics() {
        for fruit in children{
            if fruit.position.y < -100 {
                fruit.removeFromParent()
                if fruit.name == "fruit"{
                    
                    fruitNotCrush()

                }
            }
        }
        
    }
    
    // Start or restart the game
    func playGame() {
        
        fruitCrush = 0
        // Set Score In crush of Fruite
        fruitCrushLabel.text = "\(fruitCrush)"
        
        // Set Label Text Highscore of crush fruite
        highScoreLabel.text = "Best: \(highScore)"
        highScoreLabel.position = CGPoint(x: 20 + highScoreLabel.frame.size.width / 2, y: fruitCrushLabel.position.y - fruitCrushLabel.frame.size.height - 15)
        
        
        // main heading label not display
        promptLabel.isHidden = true
        fruiteMiss = 0
        
        
        // call for right corner three X Symbol Black color
        xMarks.restart()
        
        // Add Timer to call createFruits every 3 seconds
        fruiteThrowTimer = Timer.scheduledTimer(withTimeInterval:  3.0, repeats: true, block: { (timer) in
            self.makeFruits()
        })
    }
    // create random  number of count fruits every 3 seconds
    func makeFruits() {
        // create new fruite object in randomly
        let numberOfFruite = 1 + Int(arc4random_uniform(UInt32(4)))
        
        for _ in 0..<numberOfFruite{
            let fruite = MakeFruits()
            fruite.position.x = randomCGFloat(0, size.width)
            fruite.position.y = -100
            addChild(fruite)
            
            if fruite.position.x < size.width/2 {
                fruite.physicsBody?.velocity.dx = randomCGFloat(0, 200)
            }
            if fruite.position.x > size.width/2 {
                fruite.physicsBody?.velocity.dx = randomCGFloat(0, -200)
            }
            
            
            fruite.physicsBody?.velocity.dy = randomCGFloat(500, 800)
            fruite.physicsBody?.angularVelocity = randomCGFloat(-5, 5)
        }
    }
        
        
       

    // Increase missed fruits counter and game over when reached three times
    func fruitNotCrush() {
        // fruite Miss Than fruiteMiss Count Plus 1
        fruiteMiss += 1
        
        // X Symbol in right corner is red in 3 of 1
        xMarks.update(num: fruiteMiss)
        
        // check Fruitemiss and Maxcount both are same or not
        // if it's same than game is over
        if fruiteMiss == maxCount {
            gameOver()
        }
        
    }
    // crash the bomb
    func bombCrash() {
        
        for case let fruit as MakeFruits in children{
            fruit.removeFromParent()
            touchEffect(position: fruit.position)
            // explode
        }
        // expoverlay action in touch on bomb or fruite
        expOver.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0),SKAction.wait(forDuration: 0.2),SKAction.fadeAlpha(to: 0, duration: 0),SKAction.wait(forDuration: 0.2),SKAction.fadeAlpha(to: 0, duration: 0),SKAction.wait(forDuration: 0.2),SKAction.fadeAlpha(to: 0, duration: 0)]))
        
    }
    // Game Over and Reset current game
    func gameOver() {
        // check score is more than highscore
        if fruitCrush > highScore {
            // highscore assign valve score
            highScore = fruitCrush
            let b = highScore
            
            // save data
            UserDefaults.standard.set(b, forKey: "best")
            UserDefaults.standard.synchronize()
        }
        
        // Main heading label show in display
        promptLabel.isHidden = false
        
        // make text in main label "Game Over"
        promptLabel.text = "Game Over"
        promptLabel.run(SKAction.scale(by: 1, duration: 0.3))
        Phase = .GameOver
       
        // fruite Throw timer Close
        fruiteThrowTimer.invalidate()
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {_   in
            self.Phase = .ReadyToPlay
            })
    }
    
    
    // Apply particles effect on fruit crush
    func touchEffect(position:CGPoint) {
        let emmiter = SKEmitterNode(fileNamed: "Explode.sks")
        emmiter?.position = position
        addChild(emmiter!)
    }
    
    // Play sound on bomb and fruits
    func playSoundEffect(soundFile: String) {
        let audioNode = SKAudioNode(fileNamed: soundFile)
        audioNode.autoplayLooped = false
        addChild(audioNode)
        audioNode.run(SKAction.play())
        audioNode.run(SKAction.sequence([
        SKAction.wait(forDuration: 1.0), SKAction.removeFromParent()]))
        
    }
}
