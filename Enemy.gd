extends Node2D

var hp = 25 setget set_hp
var target = null

onready var hpLabel = $HPLabel
onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	hpLabel.text = str(hp) + "hp"
	

func attack(target) -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	animationPlayer.play("Attack")
	self.target = target
	yield(animationPlayer, "animation_finished")
	self.target = null
	emit_signal("end_turn")
	

func deal_damage():
	self.target.hp -= 4
	print("deal damage")


	
func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")
	
	
func is_dead():
	return hp <= 0
	
	
	
	
	
	
	
