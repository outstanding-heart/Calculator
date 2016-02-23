//
//  ViewController.swift
//  Calculator
//
//  Created by Lee.HJ on 16/2/13.
//  Copyright © 2016年 Lee.HJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text! = display.text! + digit
        }
        else{
            display.text! = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        //print("digit = \(digit)")
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        switch operation{
        case "×": preformOperationTwo { $0 * $1 }
        case "÷": preformOperationTwo { $1 / $0 }
        case "−": preformOperationTwo { $1 - $0 }
        case "+": preformOperationTwo { $0 + $1 }
        case "√": preformOperationOne { sqrt($0) }
        default: break
        }
    }

    func preformOperationTwo(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func preformOperationOne(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        
        func sum(numbers: Int...) -> Int{
            var sumNumber = 0
            var num = 0
            
            for number in numbers{
                sumNumber += number
                num++
            }
            return sumNumber / num
        }
        
        var average = 0
        average = sum(12, 43, 123)
        print(average)
        
        print("operandStack = \(operandStack)")
    }
    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

