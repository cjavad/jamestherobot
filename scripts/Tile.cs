using Godot;
using System;
using System.Collections.Generic;

public class Tile : Spatial
{
	public bool canTraverse = true;
	
	public override void _Ready()
	{
		// take global position and insert into manager
		int x = (int)Math.Round(this.GlobalTransform.origin.x);
		int y = (int)Math.Round(this.GlobalTransform.origin.y);
		
		TileManager manager = GetNode<TileManager>("/root/TileManager");
		
		if (!manager.tiles.ContainsKey(x)) {
			manager.tiles.Add(x, new Dictionary<int, Tile>());
		}
		
		manager.tiles[x].Add(y, this);
	}
	
	// called by agent when occupying
	public virtual void UpdateAgent(ref Agent agent) 
	{
		
	}
}
