extends Panel

export var rollCost = 10 
export var winMultiply = 4

var allWheels = []
var readyWheels = []

var lastRolled = []

func register_wheel(newWheel):
	get_node(newWheel).connect("is_stopped", self, "_on_wheel_is_stopped")
	
	
	randomize_wheel(newWheel)
	
	allWheels.insert(allWheels.size(), newWheel)
	readyWheels.insert(readyWheels.size(), newWheel)



func start_all_Wheels():
	for entry in allWheels:
		get_node(entry).start_wheel()
		readyWheels.erase(entry)


func randomize_wheel(wheel):
	randomize()
	get_node(wheel).set_index(randi()%3)



func _on_StartButton_pressed():
	if get_node("../Player").can_pay(rollCost) && readyWheels.size() == allWheels.size():
		get_node("../Player").sub_money(rollCost)
		start_all_Wheels()


func _on_wheel_is_stopped(wheel, value):
	
	if !readyWheels.has(wheel):
		readyWheels.insert(readyWheels.size(), wheel)
		lastRolled.insert(lastRolled.size(), value)
	
	if lastRolled.size() >= allWheels.size():
		evaluate_player_roll()
		lastRolled.clear()
	

func evaluate_player_roll():
	var playerWin = true
	var index = 0
	var firstValue = lastRolled[0]
	
	for entry in allWheels:
		if firstValue == lastRolled[index]:
			index += 1	
		else:
			playerWin = false
	
	if(playerWin == true):
		print("Congratz! You win " + String(rollCost * winMultiply))
		get_node("../Player").add_money(rollCost * winMultiply)
	else:
		print("Nothing - try a next Spin!")
	
	pass
