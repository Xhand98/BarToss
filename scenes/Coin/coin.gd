extends AnimatedSprite2D
@onready var coin: AnimatedSprite2D = $"."

signal flipped(result)
var flipping := false


#func flip_coin() -> void:
	#if flipping:
		#return
	#
	#flipping = true;
	#var result = randi_range(0,1)
	#play("flip")
#
	#await coin.animation_finished
	#
	#if result == 0:
		#play("heads")
	#else:
		#play("tails")
	#
	#flipped.emit(result)
	#
	#flipping = false

func flip_coin() -> void:
	if flipping:
		return

	flipping = true

	var result = randi_range(0, 1)

	print("Starting flip")

	play("flip")

	await animation_finished

	print("Flip finished")

	if result == 0:
		print("Heads")
		play("heads")
	else:
		print("Tails")
		play("tails")
		
	await animation_finished
	flipped.emit(result)

	flipping = false
