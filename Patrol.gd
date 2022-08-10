extends CharacterBody2D

const SPEED = 300.0

@export_node_path var position_a_path : NodePath
@export_node_path var position_b_path : NodePath

@onready var position_a : Position2D = get_node(position_a_path)
@onready var position_b : Position2D = get_node(position_b_path)
@onready var navigation_agent : NavigationAgent2D = $'%NavigationAgent2D'

var current_target_position : Position2D

func _ready():
	set_target_position(position_a)

func _physics_process(delta):
	var next_location = navigation_agent.get_next_location()
	var direction = (next_location - global_transform.origin).normalized()
	velocity = velocity.move_toward(direction * SPEED, 540 * delta)
	navigation_agent.set_velocity(velocity)
	move_and_slide()
	

func set_target_position(target_position: Position2D) -> void: 
	current_target_position = target_position
	navigation_agent.set_target_location(target_position.position)

func toggle_targe_positon() -> void:
	if current_target_position == position_a:
		set_target_position(position_b)
		return
	
	set_target_position(position_a)

func _on_navigation_agent_2d_navigation_finished():
	toggle_targe_positon()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
