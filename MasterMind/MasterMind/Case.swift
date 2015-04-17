//
//  Case.swift
//  MasterMind
//
//  Created by Julien Stefani on 17/04/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

class Case: Observable {
    
    enum Color{
        case VIDE, VERT, JAUNE, BLEU, MARRON, VIOLET, ROUGE
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
        var randomIndex:UInt32= arc4random(6)
    
        return (Color)randomIndex;
    }
    
    class func newRandCase(s:Suite)->Case
    {
        var tmp:Case = Case(s:s)
        tmp.setColor(Extensions.randomColor())
    
        return tmp;
    }
    
    public void reset()
    {
        myColor = Color.VIDE;
    
        notifyObservers();
    }
    
    public void setColor(Color c)
    {
        if (mySuite==null || mySuite.getEtat() == Suite.Etat.ACTIF)
        {
            myColor = c;
    
            notifyObservers();
        }
    }
    
    public Color getColor()
    {
        return myColor;
    }
    
    /// <summary>
    /// retourne vrai si le pion courant est de la même couleur que le pion en paramètre
    /// faux dans le cas contraire
    /// </summary>
    /// <param name="c"></param>
    /// <returns></returns>
    public bool isSameColor(Case c)
    {
        if (c.getColor() == this.getColor())
            return true;
        else
            return false;
    }
    
    public int drawnWithoutReplacement(List<Case> listP)
    {
        for (int j = 0; j < listP.Count; j++)
        {
            if (isSameColor(listP.ElementAt(j)))
            {
                listP.RemoveAt(j);
                return 1;
            }
        }
        return 0;
    }
    
    public SuiteHandler getSuite()
    {
        return mySuite;
    }
    
    public override string ToString()
    {
        return myColor.ToString();
    }
    
}
