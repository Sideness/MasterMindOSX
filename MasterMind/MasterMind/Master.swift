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
    enum Color{
        case VIDE, VERT, JAUNE, BLEU, MARRON, VIOLET, ROUGE
    }
    
    class var NB_SUITE:Int32{return 10}
    var historique:[Suite] = []
    var suiteAleatoire:Suite?
    var etat:Etat?
    var selectedColor:Color?
    var currentIndex:Int32 = 0
    
    override init()
    {
        suiteAleatoire = Suite.newSuiteA(self)
        suiteAleatoire.validated()
        suiteAleatoire.setEtat(Suite.Etat.CACHE)
        for i in 0...Master.NB_SUITE
        {
            historique.append(Suite(self))
        }
    
        selectedColor = Color.VIDE
        etat = Etat.EN_COURS
        currentIndex = 0
        historique[currentIndex].setEtat(Suite.Etat.ACTIF)
    }
    
    class func newRandMastermind()->Master
    {
        var tmp:Master = Master()
        for i in 0...NB_SUITE
        {
            tmp.historique[i] = Suite.newSuiteA(tmp)
            tmp.historique[i].validated()
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
    
    func getSuite(index:Int32)->Suite?
    {
        if (index < Master.NB_SUITE){
            return historique(index)
        }
        else{
            return nil
        }
    }
    
    func getSuiteA()->Suite
    {
        return self.suiteAleatoire
    }
    
    func getSelectedColor()->Color
    {
        return selectedColor
    }
    
    
    func setSelectedColor(c:Color)
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
}
