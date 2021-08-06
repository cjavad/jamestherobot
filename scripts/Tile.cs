using Godot;
using System;

public struct TilePosition 
{
	public int x;
	public int y;
	
	public TilePosition(Vector3 p) {
		this.x = (int)Math.Round(p.x);
		this.y = (int)Math.Round(p.z);
	}
}

public class Tile : Spatial
{
	public bool canTraverse = true;
	
	public override void _Ready()
	{
		// take global position and insert into manager
		TilePosition p = new TilePosition(this.GlobalTransform.origin);
		
		TileManager manager = GetNode<TileManager>("/root/TileManager");
		
		manager.AddTile(p, this);
	}
	
	// called by agent when occupying
	public virtual void UpdateAgent(ref Agent agent) 
	{
		
	}
}
