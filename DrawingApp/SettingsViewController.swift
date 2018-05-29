//
//  SettingsViewController.swift
//  DrawingApp
//
//  Created by Gustavo Rodrigues on 28/05/18.
//  Copyright © 2018 Gustavo Rodrigues. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate:class {
    func settingsViewControllerDidFinish(_ settingsViewController: SettingsViewController)
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var brushSlider: UISlider!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushSize: CGFloat = 5.0
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawPreview(red: red, green: green, blue: blue)
        redSlider.value = Float(red)
        redLabel.text = "\(Int(redSlider.value * 255))"
        greenSlider.value = Float(green)
        greenLabel.text = "\(Int(greenSlider.value * 255))"
        blueSlider.value = Float(blue)
        blueLabel.text = "\(Int(blueSlider.value * 255))"
        brushSlider.value = Float(brushSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func back(_ sender: Any) {
        if delegate != nil{
            delegate?.settingsViewControllerDidFinish(self)
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func brushSizeChanged(_ sender: Any) {
        let slider = sender as! UISlider
        brushSize = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
    }
    @IBAction func redSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        red = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
    }
    @IBAction func greenSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        green = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }
    @IBAction func blueSliderChanged(_ sender: Any) {
        let slider = sender as! UISlider
        blue = CGFloat(slider.value)
        drawPreview(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }
    
    func drawPreview(red: CGFloat, green: CGFloat, blue: CGFloat){
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor)
        context?.setLineWidth(brushSize)
        context?.setLineCap(CGLineCap.round)
        
        context?.move(to: CGPoint(x: 70, y: 70))
        context?.addLine(to: CGPoint(x: 70, y: 70))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
}
