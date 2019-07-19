extends Label

var score = 0
func add_point():
	score += 1
	text = "Score: " + str(score)

