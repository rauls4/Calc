//
//  ViewController.swift
//  Calc
//
//  Created by Raul Silva on 12/19/17.
//  Copyright © 2017 Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    
    //MARK: -Vars
    private var engine = CalculatorEngine()
    private var inProgress = true
    private var floatDisplay = false
   
    
    private var displayedValue:Double{                  //Computed property
        get{
            return(Double(display.text!))!
        }
        set{
            if (newValue.truncatingRemainder(dividingBy: 1) == 0  && !floatDisplay){
                if( newValue < Double(INTMAX_MAX)){
                    display.text = String(Int(newValue))
                }else{
                    self.err()
                }
            }else{
                display.text = String(newValue)
            }
        }
    }
    
    //MARK: -IBActions
    @IBAction private  func dotPressed(_ sender: CalcButton) {
        if(inProgress){
            if(!floatDisplay){
                display.text = display.text! + "."
            }
        }else{
            display.text = "0."
            inProgress = true
        }
        floatDisplay = true
    }
    
    @IBAction private  func operatorPressed(_ sender: CalcButton) {
        
        if  let  operationType = sender.titleLabel?.text{
            switch operationType {
                
            case "AC":
                engine.reset()
                self.viewReset()
            case "=":
                if inProgress {                             //If the user was entering a new value
                    engine.updateStackWithValue(value: displayedValue)
                    if(engine.operandStack.count > 1 &&  engine.pendingOperation != nil){
                        let newVal = engine.operate(operation: engine.pendingOperation!)
                        engine.updateStackWithValue(value: newVal)
                        displayedValue = newVal
                    }
                }else{
                    engine.updateStackWithValue(value: displayedValue)
                    inProgress = true
                }
                engine.pendingOperation = nil               //We just equated so there is no pending operation
                
            default:
                
                if inProgress {
                    engine.updateStackWithValue(value: displayedValue)
                    if(engine.operandStack.count > 1 &&  engine.pendingOperation != nil){
                        let newVal = engine.operate(operation: engine.pendingOperation!)
                        engine.operandStack = [newVal]
                        displayedValue = newVal
                    }
                }else{
                    if engine.operandStack.count < 1 {
                        engine.updateStackWithValue(value: displayedValue)
                    }
                }
                engine.pendingOperation = operationType     //How we will resolve value for next opeation or equating
            }
            
        }
        floatDisplay = false                                //If we were showing floating point values, let's make sure we go back to ints
        inProgress = false                                  //User is no longer entering a value
    }
    
    @IBAction private func numberPressed(_ sender: CalcButton) {
        if (display.text?.first == "0" || !inProgress){
            if(floatDisplay){
                display.text? =  (display.text)! + (sender.titleLabel?.text)!
            }else{
                display.text? = (sender.titleLabel?.text)!
            }
        }else{
            display.text = "" + display.text! + (sender.titleLabel?.text)!
        }
        inProgress = true
    }
    
    //MARKL -Funcs
    private func err(){
        display.text = "Error"
        engine.operandStack = []
    }
    
    private func viewReset(){
        display.text = "0"
        engine.pendingOperation = nil
        inProgress = true
    }
}
