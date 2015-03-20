//
//  Observable.swift
//  MasterMind
//
//  Created by Julien Petitbon on 20/03/2015.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa


public class Observable: NSObject {
    
    var Observers : [Observer] = [];
    
    
    public func addObserver(observer : Observer)
    {
        Observers.append(observer);
    }
    
    public func notifyObservers()
    {
        for observer in Observers
        {
            observer.Update();
        }
    }
    

}
