//
//  Grid.swift
//  BrewMaster
//
//  Created by Andrew Brandt on 4/3/15.
//  Copyright (c) 2015 Dory Studios. All rights reserved.
//

import UIKit

struct GridCoordinate {
    var row: Int = 0
    var column: Int = 0
}

//MARK: - Main class, lifecycle related methods
class Grid: CCNode {

    var tiles: [[Tile]]! = [[Tile]](count:7, repeatedValue:[Tile](count:7, repeatedValue:Tile()))
    var state: GameState!
    var columnWidth: CGFloat = 0
    var columnHeight: CGFloat = 0
    var tileMarginVertical: CGFloat = 0
    var tileMarginHorizontal: CGFloat = 0
    //Grid+Touch
    var touchTile: Tile!
    
    let GRID_SIZE: Int = 7
    
    func didLoadFromCCB() {
        state = GameState.sharedInstance
        self.setupGrid()
        self.userInteractionEnabled = true
    }
    
    func setupGrid() {
        var tile = CCBReader.load("Tile")
        columnWidth = tile.contentSize.width
        columnHeight = tile.contentSize.height
        tileMarginHorizontal = (self.contentSize.width - (CGFloat(GRID_SIZE) * columnWidth)) / (CGFloat(GRID_SIZE)+1)
        tileMarginVertical = (self.contentSize.height - (CGFloat(GRID_SIZE) * columnHeight)) / (CGFloat(GRID_SIZE)+1)
    }

    func addTileToGrid(tile: Tile, atColumn column: Int, atRow row: Int) {
        var coord = GridCoordinate(row: row, column: column)
        self.addTileToGrid(tile, atGridCoordinate: coord)
    }
    
    func addTileToGrid(tile: Tile, atGridCoordinate coordinate: GridCoordinate) {
        tiles[coordinate.column][coordinate.row] = tile
        self.addChild(tile)
        //tile.position = self.pointFromGridCoordinate(coordinate)
        tile.gridCoordinate = coordinate
        self.animateTile(tile, toGridCoordinate: coordinate)
    }
    
    func swapTouchTileWithTile(tile: Tile) {
        //swap grid coordinates
        var tempCoordinate = touchTile.gridCoordinate
        touchTile.gridCoordinate = tile.gridCoordinate
        tile.gridCoordinate = tempCoordinate
        //swap array location
        tiles[tile.gridCoordinate.column][tile.gridCoordinate.row] = tile
        tiles[touchTile.gridCoordinate.column][touchTile.gridCoordinate.row] = touchTile
        self.animateTileSwap(touchTile, second: tile)
        touchTile = Tile.dummyTile()
    }
    
}