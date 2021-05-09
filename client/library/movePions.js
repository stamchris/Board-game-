function choosePlayer(playerColor) {
	switch(playerColor) {
		case "Cyan":
			return player1
		case "Orange":
			return player2
		case "Green":
			return player3
		case "White":
			return player4
		case "Pink":
			return player5
		case "Blue":
			return player6
		case "Red":
			return player7
		case "Black":
			return cerbere
		default:
			break;
	}
}

function movePlayer(newPosition, player) {
	player.moveTo(rowId.children[newPosition])
}
