//
//  Tile+Ingredient.swift
//  BrewMaster
//
//  Created by Andrew Brandt on 4/8/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import Foundation

struct IngredientProperties {
    
}

enum IngredientType: Entity {
    case Leaf
    case Flower
    case Stem
}

typealias Ingredient = IngredientType

extension Tile {
    
    class func tileFromIngredient(ingredient: Ingredient) -> Tile {
        
        var tile = CCBReader.load("Tile") as! Tile
        //var sprite = CCSprite(imageNamed: "Herb")
        var color: CCColor
        switch(ingredient) {
            case .Leaf:
                color = CCColor(red: 1, green: 0, blue: 0, alpha: 1)
            case .Flower:
                color = CCColor(red: 0, green: 1, blue: 0, alpha: 1)
            case .Stem:
                color = CCColor(red: 0, green: 0, blue: 1, alpha: 1)
        }
        tile._background.color = color
        tile.contents = ingredient
        return tile
    }
    
}