using Godot;
using System;
using System.Collections.Generic;

public class TileManager : Node
{
	public Dictionary<int, Dictionary<int, Tile>> tiles = new Dictionary<int, Dictionary<int, Tile>>();
	
	public override void _Ready()
	{
		
	}
}
