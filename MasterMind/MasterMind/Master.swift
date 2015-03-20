//
//  Master.swift
//  MasterMind
//
//  Created by Julien Stefani on 20/03/15.
//  Copyright (c) 2015 Julien Stefani. All rights reserved.
//

import Cocoa

public class Master: Observable {
    public enum Etat {
        case EN_COURS, GAGNE, PERDU
    }
    
    class var NB_SUITE:Int32{return 10}
    var historique:Suite = []
    var suiteAleatoire:Suite
    var etat:Etat
    var selectedColor:Color
    var currentIndex:int
}
