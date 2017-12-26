//
//  CPU.swift
//  Calc
//
//  Created by Raul Silva on 12/19/17.
//  Copyright © 2017 Silva. All rights reserved.
//

import Foundation

class CalculatorEngine: NSObject
{
    var operandStack = Array<Double>() //array
    var pendingOperation:String?
    
    func updateStackWithValue(value: Double)
    { self.operandStack.append(value) }
    
    func reset(){
        operandStack = Array<Double>()
    }
    
    func operate(operation: String) ->Double
        
    { switch operation
        
    {
        
    case "×":
        if operandStack.count >= 2 {
            return self.operandStack.removeLast() * self.operandStack.removeLast()
        }
        
    case "÷":
        
        if operandStack.count >= 2 {
            return self.operandStack.removeFirst() / self.operandStack.removeLast()
        }
        
    case "+":
        if operandStack.count >= 2 {
            return self.operandStack.removeLast() + self.operandStack.removeLast()
        }
        
    case "−":
        if operandStack.count >= 2 {
            return self.operandStack.removeFirst() - self.operandStack.removeLast()
        }
        
        
    default:break
        }
        return 0.0
    }
}


