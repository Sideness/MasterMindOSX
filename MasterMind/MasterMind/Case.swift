//
//  Case.swift
//  MasterMind
//
//  Created by Julien Stefani on 17/04/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

class Case: Observable {
    
    enum Color : UInt32{
        case VIDE = 1,
        VERT = 2,
        JAUNE = 3,
        BLEU = 4,
        MARRON = 5,
        VIOLET = 6,
        ROUGE = 7
        
        var description : String {
            get {
                switch(self) {
                case VIDE:
                    return "VIDE"
                case VERT:
                    return "VERT"
                case JAUNE:
                    return "JAUNE"
                case BLEU:
                    return "BLEU"
                case MARRON:
                    return "MARRON"
                case VIOLET:
                    return "VIOLET"
                case ROUGE:
                    return "ROUGE"
                }
            }
        }

    }
    
    var myColor:Color;
    var mySuite:Suite;
    
    
    
    init(s:Suite)
    {
    
        mySuite = s;
        myColor = Color.VIDE;
    }
    
    init(c:Color, s:Suite)
    {
        myColor = c;
        mySuite = s
    }
    
    class func randomColor()->Color
    {
        var randomIndex:UInt32 = 2 + arc4random_uniform(6)
    
        return Color(rawValue: randomIndex)!;
    }
    
    class func newRandCase(s:Suite)->Case
    {
        var tmp:Case = Case(s:s)
        tmp.setColor(randomColor())
    
        return tmp;
    }
    
    func reset()
    {
        myColor = Color.VIDE;
    
        notifyObservers();
    }
    
    func setColor(c:Color)
    {
        if ( mySuite.getEtat() == Suite.Etat.ACTIF)
        {
            myColor = c;
    
            notifyObservers();
        }
    }
    
    func getColor()->Color
    {
        return myColor;
    }
    
    
    /// <summary>
    /// retourne vrai si le pion courant est de la même couleur que le pion en paramètre
    /// faux dans le cas contraire
    /// </summary>
    /// <param name="c"></param>
    /// <returns></returns>
    func isSameColor(c:Case)->Bool
    {
        if (c.getColor() == self.getColor()){
            return true;
        }
        else{
            return false;
        }
    }
    
    func drawnWithoutReplacement(var listP:[Case?])->Int
    {

        for var j = 0; j < listP.count; j++
        {
            if (isSameColor(listP[j]!))
            {
                let removed = listP.removeAtIndex(j)
                return 1;
            }
        }
        return 0;
    }
    
    func getSuite()->Suite
    {
        return mySuite;
    }
    
    func toString()->String
    {
        return myColor.description
    }

    
}
