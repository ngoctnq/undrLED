//
//  ViewController.swift
//  undrLED
//
//  Created by Ngoc Tran on 14.11.16.
//  Copyright © 2016 Ngoc Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var Rslider: UISlider!
    @IBOutlet weak var Gslider: UISlider!
    @IBOutlet weak var Bslider: UISlider!
    @IBOutlet weak var colorPreview: UIView!
    @IBAction func submit() {
        var r = String(Int(Rslider.value * 255), radix: 16);
        if r.characters.count == 1 {
            r = "0" + r;
        }
        var g = String(Int(Gslider.value * 255), radix: 16);
        if g.characters.count == 1 {
            g = "0" + g;
        }
        var b = String(Int(Bslider.value * 255), radix: 16);
        if b.characters.count == 1 {
            b = "0" + b;
        }
        print("set color: "+r+g+b);
        sendShit(val: r+g+b);
    }
    @IBAction func valentine() {
        if toggle.isOn {
            print("toggled on.");
            button.isEnabled = false;
            button.setTitle("fuck dancing.", for: .normal);
            sendShit(val: "moodie");
        }
        else {
            print("toggled off.");
            button.isEnabled = true;
            button.setTitle("let's dance.", for: .normal);
            sendShit(val: "alloff");
            submit();
        }
    }
    @IBAction func setColor() {
        let r = Rslider.value;
        let g = Gslider.value;
        let b = Bslider.value;
        colorPreview.backgroundColor = UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: 1);
    }
    
    func sendShit(val: String) {
        let client:TCPClient = TCPClient(addr: "rpi.underlandian.com", port: 2112)
        var (success, errmsg)=client.connect(timeout: 1)
        if success{
            (success, errmsg)=client.send(str: val)
            if !success {print(errmsg)}
        } else{print(errmsg)}
        (success, errmsg) = client.close()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

