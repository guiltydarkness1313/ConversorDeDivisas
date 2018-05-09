//
//  ViewController.swift
//  conversor de divisas
//
//  Created by Paul Pacheco on 5/9/18.
//  Copyright © 2018 ShibuyaXpress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var initialValueTextField: UITextField!
    
    @IBOutlet weak var fromSegment: UISegmentedControl!
    @IBOutlet weak var toSegment: UISegmentedControl!
    @IBOutlet weak var finalValueLabel: UILabel!
    
    override func viewDidLoad() {
        hideKeyBoardWhenTap()
        super.viewDidLoad()
        finalValueLabel.isHidden=true
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func convertir(_ sender: Any) {
        finalValueLabel.isHidden=false
        if(Double(initialValueTextField.text!) != nil){
            let number:Double=Double(initialValueTextField.text!)!
            var result:Double=0.0
            switch(fromSegment.selectedSegmentIndex){
            case 0: //from millas
                result=millasConverter(inicial: number, toSegment: toSegment.selectedSegmentIndex)
                
                finalValueLabel.text="\(fixData(valor: number)) \(getType(index: fromSegment.selectedSegmentIndex)) = \(fixData(valor: result)) \(getType(index: toSegment.selectedSegmentIndex))"
                break
            case 1: //fromKm
                result=kmConverter(inicial: number, toSegment: toSegment.selectedSegmentIndex)
                
                finalValueLabel.text="\(fixData(valor: number)) \(getType(index: fromSegment.selectedSegmentIndex)) = \(fixData(valor: result)) \(getType(index: toSegment.selectedSegmentIndex))"
                break
            case 2:
                result=yardConverter(inicial: number, toSegment: toSegment.selectedSegmentIndex)
                
                finalValueLabel.text="\(fixData(valor: number)) \(getType(index: fromSegment.selectedSegmentIndex)) = \(fixData(valor: result)) \(getType(index: toSegment.selectedSegmentIndex))"
            default:
                break
            }
        }else{
            finalValueLabel.text="verifica tu valor"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func yardConverter(inicial:Double,toSegment:Int)->Double{
        var result:Double=0.0
        switch toSegment {
        case 0:
            result=yardToMill(valor: inicial)
            break
        case 1:
            result=yardToKm(valor: inicial)
            break
        case 2:
            result=inicial
        default:
            break
        }
        return result
    }
    
    func millasConverter(inicial:Double,toSegment:Int)->Double{
        var result:Double=0.0
        switch toSegment{
            //toMillas
        case 0:
            result=inicial
            break
        case 1:
            //tokm
            result=millToKm(valor: inicial)
            break
        case 2:
            result=millToYard(valor: inicial)
        default:
            break
        }
        return result
    }
    
    func kmConverter(inicial:Double,toSegment:Int)->Double{
        var result:Double=0.0
        switch toSegment {
        case 0:
            result=kmToMill(valor: inicial)
            break
        case 1:
            result=inicial
            break
        case 2:
            result=kmToYard(valor: inicial)
        default:
            break
        }
        return result
    }
    
    func getType(index:Int)->String{
        var res:String=""
        switch index {
        case 0:
            res="Millas"
            break
        case 1:
            res="Km"
            break
        case 2:
            res="Yardas"
            break
        default:
            break
        }
        return res
    }
    func fixData(valor:Double)->String{
        return String(format:"%.2f",valor)
    }
    func kmToMill(valor:Double)->Double{
        return valor*0.621371
    }
    func kmToYard(valor:Double)->Double{
        return valor*1093.61
    }
    func millToKm(valor:Double)->Double{
        return valor*1.60934
    }
    func millToYard(valor:Double)->Double{
        return valor*1760
    }
    func yardToKm(valor:Double)->Double{
        return valor*0.0009144
    }
    func yardToMill(valor:Double)->Double{
        return valor*0.000568182
    }
    func setResult(label:UILabel,initialValue:Double,fromValue:Int,toValue:Int,finalValue:Double){
        label.text="\(fixData(valor: initialValue)) \(getType(index:fromValue)) = \(fixData(valor: finalValue)) \(getType(index:toValue))"
    }

}
extension UIViewController {
    func hideKeyBoardWhenTap(){
        let tap = UITapGestureRecognizer(target:self,action:#selector(ViewController.dimissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dimissKeyboard(){
        view.endEditing(true)
    }
}

