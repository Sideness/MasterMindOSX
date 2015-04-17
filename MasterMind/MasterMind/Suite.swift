//
//  Suite.swift
//  MasterMind
//
//  Created by Julien Petitbon on 20/03/2015.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

class Suite: Observable{
    
    enum Etat
    {
        case INITIAL, ACTIF, VALIDE, CACHE
    }
    
    class var NB_PION : Int32  {return 4};
    var myTabCase:[Case] = [];
    var noir:Int32 = 0;
    var blanc:Int32 = 0;
    var monMaster:Master;
    var etat:Etat;
    
    
    init(m:Master)
    {
        monMaster=m;
        etat=Etat.INITIAL;
        for i in 0...Suite.NB_PION
        {

            myTabCase[i].append(Case(Color.VIDE,self))
        }
    }
    
    class func newSuiteA(m:Master)->Suite
    {
        var random : Suite = Suite(m: m);
        random.etat=Etat.CACHE;
        for i in 0...Suite.NB_PION
        {
            random.myTabCase[i] = Case(Extensions.randomColor(),random);
        }
    
        return random;
    }
    
    func getMaster()->Master
    {
        return monMaster;
    }
    
    func getCase(index:Int32)->Case
    {
        if(index<NB_PION)
        {
            return myTabCase[index];
        }
        else
        {
            return null;
        }
    }
    
    func reset()
    {
        for i in 0...Suite.NB_PION
        {
            myTabCase[i].reset();
        }
        noir=0;
        blanc=0;
        setEtat(Etat.INITIAL);
    }
    
    func getNoir()->Int32
    {
        return noir;
    }
    
    func getBlanc()->Int32
    {
        return blanc;
    }
    
    
    func setEtat(e:Etat)
    {
        etat=e;
        notifyObservers();
    }
    
    func getEtat()->Etat
    {
        return etat;
    }
    
    
    func description()->String
    {
        var tmp:String = "\n";
        for i in 0...Suite.NB_PION
        {
            tmp += " "+self.myTabCase[i].ToString();
    
        }
        return "\(tmp) noir : \(noir) blanc : \(blanc) Etat: \(etat)";
    }
    
    /** calcule et retourne la valeur de la donnée membre black d'une suite */
    func black()->Int32
    {
        var black : Int32=0;
        var tmp:[Case] = monMaster.getSuiteA().getTabCase();
        for i in 0...Suite.NB_PION
        {
            if(self.myTabCase[i].getColor()==tmp[i].getColor())
            {
                black++;
            }
        }
            return black;
    }
    
    /// <summary>
    ///  calcule et retourne la somme des nombres black et white d'une suite
    /// </summary>
    /// <returns></returns>
    func grey()->Int32
    {
        var gris:Int32=0;
        var copie:[Case] = monMaster.getSuiteA().getTabCase().ToList<Case>();
        for i in 0...Suite.NB_PION
        {
            gris+=myTabCase[i].drawnWithoutReplacement(copie);
        }
        return gris;
    }
    
    /// <summary>
    /// Calcul et retourne la valeur de la donnée membre white d'une suite
    /// </summary>
    /// <returns></returns>
    func white()->Int32
    {
        return grey()-black();
    }
    
    /// <summary>
    /// Méthode publique appelée lors de la validation de la suite par le joueur
    /// </summary>
    func validated()
    {
        noir=black();
        blanc=white();
        setEtat(Etat.VALIDE);
        if (noir == Suite.NB_PION)
        {
            monMaster.setEtat(Master.Etat.GAGNE);
        }
    
    
    }
    
    func getTabCase()->[Case]
    {
        return myTabCase;
    }
    
    
       
}

    


