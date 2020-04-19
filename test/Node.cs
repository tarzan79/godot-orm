using Godot;
using System;

public class Node : Godot.Node
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    private String b = "test";
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        Console.WriteLine("Hello World!");
    }

    public String test(){
        return b;
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
