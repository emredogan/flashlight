//
//  ViewController.swift
//  flashLight
//
//  Created by Emre Dogan on 23/04/17.
//  Copyright © 2017 Emre Dogan. All rights reserved.
//

import UIKit
import AVFoundation
import RappleColorPicker




class ViewController: UIViewController, RappleColorPickerDelegate {
    
    
    
    let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture
        
        self.view.backgroundColor = UIColor.yellow
        button.setTitleColor(.black, for: .normal)
        
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidEnterBackground),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Why are you shaking me?")
            toggleFlash()
            if button.title(for: UIControlState.normal) == "ON" {
                button.setTitle("OFF", for: UIControlState.normal)
            } else {
                
                button.setTitle("ON", for: UIControlState.normal)
                
                
            }
        }
    }
    
    func applicationDidEnterBackground(notification: NSNotification) {
        print("I'm out of focus!")
        button.setTitle("ON", for: UIControlState.normal)
        
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureTorchMode.on) {
                    device?.torchMode = AVCaptureTorchMode.off
                } else {
                    try device?.torchMode = AVCaptureTorchMode.off
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
       

        
   //     toggleFlash()
        
    }
    
    
    func colorSelected(_ color: UIColor, tag: Int) {
        
        self.view.backgroundColor = color

        RappleColorPicker.close()
    }
    
    
    func toggleFlash() {
        
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureTorchMode.on) {
                    device?.torchMode = AVCaptureTorchMode.off
                } else {
                    try device?.setTorchModeOnWithLevel(1.0)
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }    }
    
    @IBAction func onOffbtn(_ sender: Any) {
        
        toggleFlash()
        
        if button.title(for: UIControlState.normal) == "ON" {
            button.setTitle("OFF", for: UIControlState.normal)
        } else {
            
            button.setTitle("ON", for: UIControlState.normal)
            
            
        }
        

        
        
    }
    
    @IBAction func lowBtn(_ sender: Any) {
        UIScreen.main.brightness = CGFloat(0.1)
        
    }
    
    @IBAction func mediumBtn(_ sender: Any) {
        
        UIScreen.main.brightness = CGFloat(0.5)
    }
    
    @IBAction func highBtn(_ sender: Any) {
        
        UIScreen.main.brightness = CGFloat(10)
    }
    
    
    
    
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func whiteBtn(_ sender: Any) {
        self.view.backgroundColor = UIColor.white
        button.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func blackBtn(_ sender: Any) {
        self.view.backgroundColor = UIColor.black
        button.setTitleColor(.white, for: .normal)
        
        
    }
    
    
    @IBAction func chooseColor(_ sender:UIButton?) {
        
        let attributes : [RappleCPAttributeKey : AnyObject] = [
            .BGColor : UIColor.yellow.withAlphaComponent(0.6),
            .TintColor : UIColor.red.withAlphaComponent(0.6),
            .Style : RappleCPStyleCircle as AnyObject,
            .BorderColor : UIColor.red.withAlphaComponent(0.6)
        ]
        
        RappleColorPicker.openColorPallet(onViewController: self, origin: CGPoint(x: sender!.frame.midX - 115, y: sender!.frame.minY - 50), delegate: self, attributes: attributes)
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
