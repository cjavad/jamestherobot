using Godot;
using System;
using System.Collections.Generic;

public class TileManager : Node
{
	public Dictionary<int, Dictionary<int, Tile>> tiles = new Dictionary<int, Dictionary<int, Tile>>();
	
	public override void _Ready()
	{
		
	}
	
	public void AddTile(TilePosition p, Tile tile) 
	{
		if (!this.tiles.ContainsKey(p.x)) {
			this.tiles.Add(p.x, new Dictionary<int, Tile>());
		}
		
		this.tiles[p.x].Add(p.y, tile);
		
		GD.Print("Tile added!");
	}
}
