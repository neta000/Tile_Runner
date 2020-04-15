extends Node2D


func _ready():
	$background.play()


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://finalmenu.tscn")
