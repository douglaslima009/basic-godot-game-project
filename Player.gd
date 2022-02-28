extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300
const ACCEL = 10

var motion = Vector2()
var facing_rigth = true

func _ready():
	pass


func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_rigth == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
		
	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	
	if Input.is_action_pressed("rigth"):
		motion.x += ACCEL
		facing_rigth = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_rigth = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("Idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				motion.y = -JUMPFORCE
		
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("fall")
		
	motion = move_and_slide(motion,UP)
	
