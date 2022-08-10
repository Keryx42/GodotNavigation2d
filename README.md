# GodotNavigation2d Obstacle Problem Showcase

This repository is a basic example with problems that occur in the current godot 4 navigation2d.
I also could reproduce this in the Godot 3.5 backport.

## How To Execute
Open the Projekt with Godot4 Alpha 13.
Hit the play button and watch the example Scene behaviour.

## Setting
A Character with navigation agent is placed on a tilemap where all fields are "navigatable"
The Character want's to patrol between PositonA and PositionB. 
On his path it as to avoid the Obstacles.

## Problem
The Character is unable to navigate around the obstacles.
I also think that it's strange that you can not set an obstacle to a specific navigation layer
