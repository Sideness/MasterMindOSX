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
        
        var description : String {
            get {
                switch(self) {
                case INITIAL:
                    return "INITIAL"
                case ACTIF:
                    return "ACTIF"
                case VALIDE:
                    return "VALIDE"
                case CACHE:
                    return "CACHE"
                }
            }
        }
    }
    
    class var NB_PION : Int {return 4};
    var myTabCase:[Case?] = [Case?](count: Suite.NB_PION, repeatedValue: nil)
    var noir:Int = 0;
    var blanc:Int = 0;
    var monMaster:Master? = nil;
    var etat:Etat = Etat.INITIAL;
    
    
    init(m:Master)
    {
        super.init()

        monMaster=m;
        etat=Etat.INITIAL;
        var color:Case.Color = Case.Color.VIDE
        var i:Int
        for i = 0; i < Suite.NB_PION; i++
        {

            myTabCase[i] = Case(s:self);
            myTabCase[i]?.setColor(color)
        }
    }
    
    class func newSuiteA(m:Master)->Suite
    {
        var random : Suite = Suite(m: m);
        random.etat=Etat.CACHE;
        var i:Int
               for i = 0; i < Suite.NB_PION; i++
        {
            random.myTabCase[i] = Case(c:Case.randomColor(),s:random);
        }
    
        return random;
    }
    
    func getMaster()->Master
    {
        return monMaster!;
    }
    
    func getCase(index:Int)->Case?
    {
        if(index < Suite.NB_PION)
        {
            return myTabCase[index];
        }
        else
        {
            return nil;
        }
    }
    
    func reset()
    {
        for i in 0...Suite.NB_PION
        {
            myTabCase[i]?.reset();
        }
        noir=0;
        blanc=0;
        setEtat(Etat.INITIAL);
    }
    
    func getNoir()->Int
    {
        return noir;
    }
    
    func getBlanc()->Int
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
    
    
    func toString()->String
    {
        var tmp:String = "\n";
        for i in 0...Suite.NB_PION-1
        {
            tmp += " "+self.myTabCase[i]!.toString();
    
        }
        return "\(tmp) noir : \(noir) blanc : \(blanc) Etat: \(etat.description)";
    }
    
    /** calcule et retourne la valeur de la donnée membre black d'une suite */
    func black()->Int
    {
        var black : Int=0;
        var tmp:[Case?] = monMaster!.getSuiteA().getTabCase();
        for i in 0...Suite.NB_PION-1
        {
            if(self.myTabCase[i]!.getColor()==tmp[i]!.getColor())
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
    func grey()->Int
    {
        var gris:Int=0;
        var copie:[Case?] = monMaster!.getSuiteA().getTabCase()
        for i in 0...Suite.NB_PION-1
        {
            gris+=myTabCase[i]!.drawnWithoutReplacement(copie);
        }
        return gris;
    }
    
    /// <summary>
    /// Calcul et retourne la valeur de la donnée membre white d'une suite
    /// </summary>
    /// <returns></returns>
    func white()->Int
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
            monMaster!.setEtat(Master.Etat.GAGNE);
        }
    
    
    }
    
    func getTabCase()->[Case?]
    {
        return myTabCase;
    }
    
    
       
}

    


