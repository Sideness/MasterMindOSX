//
//  Master.swift
//  MasterMind
//
//  Created by Julien Stefani on 20/03/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

class Master: Observable{
    enum Etat {
        case EN_COURS, GAGNE, PERDU
    }
    
    class var NB_SUITE:Int{return 10}
    var historique:[Suite] = []
    var suiteAleatoire:Suite? = nil
    var etat:Etat = Etat.EN_COURS
    var selectedColor:Case.Color = Case.Color.VIDE
    var currentIndex:Int = 0
    
    
    override init()
    {
        super.init()
        suiteAleatoire = Suite.newSuiteA(self)
        suiteAleatoire?.validated()
        suiteAleatoire?.setEtat(Suite.Etat.CACHE)
        for i in 0...Master.NB_SUITE - 1
        {
            historique.append(Suite(m:self))
        }
    
        selectedColor = Case.Color.VIDE
        etat = Etat.EN_COURS
        currentIndex = 0
        var s:Suite = historique[currentIndex]
        s.setEtat(Suite.Etat.ACTIF)
    }
    
    class func newRandMastermind()->Master
    {
        var tmp:Master = Master()
        var i:Int
        for i=0; i < NB_SUITE; i++
        {
            tmp.historique[i] = Suite.newSuiteA(tmp)
            var s:Suite = tmp.historique[i] as Suite
            s.validated()
        }
        return tmp
    }
    
    
    func reset()
    {
        self.suiteAleatoire = Suite.newSuiteA(self)
        for i in 0...Master.NB_SUITE
        {
            historique[i].reset()
        }
    
        setEtat(Etat.EN_COURS)
        currentIndex = 0
        historique[currentIndex].setEtat(Suite.Etat.ACTIF)
    }
    
    func getSuite(index:Int)->Suite?
    {
        if (index < Master.NB_SUITE){
            return historique[index]
        }
        else{
            return nil
        }
    }
    
    func getSuiteA()->Suite
    {
        return self.suiteAleatoire!
    }
    
    func getSelectedColor()->Case.Color
    {
        return selectedColor
    }
    
    
    func setSelectedColor(c:Case.Color)
    {
        selectedColor = c
        notifyObservers()
    }
    
    func getEtat()->Etat
    {
        return etat;
    }
    
    func setEtat(e:Etat)
    {
        etat = e
        notifyObservers()
    }
    
    func Valide()
    {
        if (etat==Etat.EN_COURS)
        {
            historique[currentIndex].validated()
            currentIndex++
            if (currentIndex < Master.NB_SUITE && etat == Etat.EN_COURS){
                historique[currentIndex].setEtat(Suite.Etat.ACTIF)
            }
            else if(etat != Etat.GAGNE)
            {
                currentIndex = Master.NB_SUITE - 1
				setEtat(Etat.PERDU)
            }
        }
    }
    
    func toString()->String
    {
        var tmp:String = ""
        tmp += "\nSuite aléatoire :"+suiteAleatoire!.toString()+"\nHistorique:"
        var i:Int
        for i=0; i<Master.NB_SUITE; i++
        {
            var s:Suite = historique[i]
                tmp += s.toString()
        }
        return tmp
    }
    
    func getCurrentIndex()->Int
    {
        return self.currentIndex
    }
}
