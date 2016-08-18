//
//  AlertView.swift
//  CustomAlertView
//
//  Created by ben ziv on 8/19/15.
//  Copyright (c) 2015 BZGames. All rights reserved.
//

import UIKit

enum BUTTONS_COUNT{
    //You Can add as many as you want...
    
    case ONE, TWO
}

class AlertView:UIView {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //this alert view isnt rounded... 
    //now i will explain a bit on the content size
    //ill show image that explain on it... now lets test it
    
    init(frame: CGRect, alertText:String, buttons_count:BUTTONS_COUNT, buttons_text:[String], actions_name:[String], target: AnyObject?) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
        
        //i like to start 20 pixels from the top and from the left side
        let alertTextView = UITextView(frame: CGRect(x: 20, y: 20, width: frame.width - 40, height: (frame.height / 4) * 3 - 40))
        alertTextView.text = alertText
        alertTextView.textColor = UIColor.whiteColor()
        alertTextView.backgroundColor = UIColor.blackColor()
        alertTextView.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(16))
        alertTextView.scrollEnabled = true // if you have lot of text you should do it... and you think that it will go out of bounds...
        alertTextView.editable = false
        alertTextView.selectable = false
        alertTextView.contentSize = CGSize(width: alertTextView.frame.width, height: alertTextView.frame.height) //it isnt a scroll tutorial but ill explain on it later :)
        
        self.addSubview(alertTextView) // sorry :/ if i made lot of mistakes
        
        switch(buttons_count){
        case .ONE:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 4) * 3, width: frame.width, height: frame.height / 4))
            button.setTitle(buttons_text[0], forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor.grayColor()
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            break
        case .TWO:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 4) * 3, width: frame.width / 2, height: frame.height / 4))
            button.setTitle(buttons_text[0], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.backgroundColor = UIColor.grayColor()
            button.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            
            let button_2 = UIButton(frame: CGRect(x: frame.width / 2, y: (frame.height / 4) * 3, width: frame.width / 2, height: frame.height / 4))
            button_2.setTitle(buttons_text[1], forState: UIControlState.Normal)
            button_2.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button_2.backgroundColor = UIColor.grayColor()
            button_2.titleLabel?.font = UIFont(name: /*<Font Name>*/ "Heiti SC", size: /*Size*/ CGFloat(14))
            button_2.addTarget(target, action: Selector(actions_name[1]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button_2)
            
            break
        }
    }
    
    //more customize
    init(frame: CGRect, Font: UIFont,bgColor:UIColor ,alertText:String, /*alertTextView*/ alertlbl_bgColor:UIColor, alertlbl_txtColor:UIColor,
        /*buttons*/buttons_count:BUTTONS_COUNT, buttons_text:[String], buttons_bgColor:UIColor, buttons_txtColor:UIColor,actions_name:[String], target: AnyObject?) {
   
        super.init(frame: frame)
            
        self.backgroundColor = bgColor
            
        let alertTextView = UITextView(frame: CGRect(x: 20, y: 20, width: frame.width - 40, height: (frame.height / 4) * 3 - 40))
        alertTextView.text = alertText
        alertTextView.textColor = alertlbl_txtColor
        alertTextView.backgroundColor = alertlbl_bgColor
        alertTextView.font = Font
        alertTextView.scrollEnabled = true
        alertTextView.editable = false
        alertTextView.selectable = false
        alertTextView.contentSize = CGSize(width: alertTextView.frame.width, height: alertTextView.frame.height)
            
        self.addSubview(alertTextView)
        
        switch(buttons_count){
        case .ONE:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 4) * 3, width: frame.width, height: frame.height / 4))
            button.setTitle(buttons_text[0], forState: UIControlState.Normal)
            button.setTitleColor(buttons_txtColor, forState: UIControlState.Normal)
            button.backgroundColor = buttons_bgColor
            button.titleLabel?.font = Font
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            break
        case .TWO:
            let button = UIButton(frame: CGRect(x: 0, y: (frame.height / 4) * 3, width: frame.width / 2, height: frame.height / 4))
            button.setTitle(buttons_text[0], forState: .Normal)
            button.setTitleColor(buttons_txtColor, forState: UIControlState.Normal)
            button.backgroundColor = buttons_bgColor
            button.titleLabel?.font = Font
            button.addTarget(target, action: Selector(actions_name[0]), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(button)
            
            let button_2 = UIButton(frame: CGRect(x: frame.width / 2, y: (frame.height / 4) * 3, width: frame.width / 2, height: frame.height / 4))
            button_2.setTitle(buttons_text[1], forState: UIControlState.Normal)
            button_2.setTitleColor(buttons_txtColor, forState: UIControlState.Normal)
            button_2.backgroundColor = buttons_bgColor
            button_2.titleLabel?.font = Font
            button_2.addTarget(target, action: Selector(actions_name[1]), forControlEvents: UIControlEvents.TouchUpInside)

            self.addSubview(button_2)
            
            break
        }
    }
    
    
    
    
}
