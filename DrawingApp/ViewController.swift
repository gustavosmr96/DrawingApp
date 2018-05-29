//
//  ViewController.swift
//  DrawingApp
//
//  Created by Gustavo Rodrigues on 28/05/18.
//  Copyright © 2018 Gustavo Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var palavra: UILabel!
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushSize: CGFloat = 5.0
    
    @IBOutlet weak var toolIcon: UIButton!
    var tool: UIImage!
    var isDrawing = true
    let categoria = Categoria(categoria: "Objetos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        palavra.text = categoria.sortear()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first{
            lastPoint = touch.location(in: self.view)
        }
    }
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushSize)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first{
            let currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    @IBAction func pular(_ sender: Any) {
        palavra.text = categoria.sortear()
        self.imageView.image = nil
    }
    @IBAction func reset(_ sender: Any) {
        self.imageView.image = nil
    }
    @IBAction func erase(_ sender: Any) {
        if isDrawing {
            (red, green, blue) = (1,1,1)
            toolIcon.setImage(#imageLiteral(resourceName: "pen"), for: .normal)
        }else{
            (red,green,blue) = (0,0,0)
            toolIcon.setImage(#imageLiteral(resourceName: "eraser"), for: .normal)
        }
        isDrawing = !isDrawing
    }
    @IBAction func colorsPicked(_ sender: AnyObject) {
        switch sender.tag {
        case 0:
            (red,green, blue) = (208/255,2/255,27/255)
        case 1:
            (red,green, blue) = (65/255,117/255,5/255)
        case 2:
            (red,green, blue) = (255/255,100/255,251/255)
        case 3:
            (red,green, blue) = (241/255,196/255,15/255)
        case 4:
            (red,green, blue) = (255/255,255/255,255/255)
        default:
            (red,green, blue) = (0/255,0/255,0/255)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.red = red
        settingsViewController.blue = blue
        settingsViewController.green = green
        settingsViewController.brushSize = brushSize
    }
}
extension ViewController: SettingsViewControllerDelegate{
    func settingsViewControllerDidFinish(_ settingsViewController: SettingsViewController) {
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        self.brushSize = settingsViewController.brushSize
    }
}

