extends Node2D

@onready var navigation_region_2d : NavigationRegion2D = $'%NavigationRegion2D'
@onready var obstacles : Node2D = $Obstacles

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().root.ready
	
	cut_obstacles_2()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

# I saw this method in this Issue https://github.com/godotengine/godot/issues/61334 
func cut_obstacles():
	var navigation_polygon : NavigationPolygon = navigation_region_2d.navpoly
	
	for obstacle in obstacles.get_children():
		var collison_polygon : CollisionPolygon2D = obstacle.get_node("CollisionPolygon2D")
		var collison_polygon_global_transform : Transform2D = collison_polygon.global_transform
		var collison_polygon_polygon : PackedVector2Array = collison_polygon.polygon
		var new_cut_out_poly : PackedVector2Array = PackedVector2Array()
		for vertex in collison_polygon_polygon:
			var current_vertex : Vector2 = vertex
			new_cut_out_poly.append(collison_polygon_global_transform.basis_xform(current_vertex))
		navigation_polygon.add_outline(new_cut_out_poly)
	
	navigation_polygon.make_polygons_from_outlines()
	navigation_region_2d.navpoly = navigation_polygon
	navigation_region_2d.force_update_transform()
	
# other try 
func cut_obstacles_2():
	
	for obstacle in obstacles.get_children():
		var navigation_polygon : NavigationPolygon = navigation_region_2d.navpoly
		var collison_polygon : CollisionPolygon2D = obstacle.get_node("CollisionPolygon2D")
		var collison_polygon_polygon : PackedVector2Array = collison_polygon.polygon
		var new_cut_out_poly : PackedVector2Array = PackedVector2Array()
		var cut_out : PackedVector2Array = Geometry2D.exclude_polygons(collison_polygon_polygon, navigation_polygon.get_vertices()).front()
		navigation_polygon.add_outline(new_cut_out_poly)
		navigation_polygon.make_polygons_from_outlines()
		navigation_region_2d.navpoly = navigation_polygon
	#navigation_polygon.make_polygons_from_outlines()
	#navigation_region_2d.navpoly = navigation_polygon
	#navigation_region_2d.force_update_transform()
