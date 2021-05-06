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
	switch(newPosition) {
		case '0':
			player.parent = layoutPawn0
			break;
		case '1':
			player.parent = layoutPawn1
			break;
		case '2':
			player.parent = layoutPawn2
			break;
		case '3':
			player.parent = layoutPawn3
			break;
		case '4':
			player.parent = layoutPawn4
			break;
		case '5':
			player.parent = layoutPawn5
			break;
		case '6':
			player.parent = layoutPawn6
			break;
		case '7':
			player.parent = layoutPawn7
			break;
		case '8':
			player.parent = layoutPawn8
			break;
		case '9':
			player.parent = layoutPawn9
			break;
		case '10':
			player.parent = layoutPawn10
			break;
		case '11':
			player.parent = layoutPawn11
			break;
		case '12':
			player.parent = layoutPawn12
			break;
		case '13':
			player.parent = layoutPawn13
			break;
		case '14':
			player.parent = layoutPawn14
			break;
		case '15':
			player.parent = layoutPawn15
			break;
		case '16':
			case16Id.color = "red"
			case16Id.color= Qt.rgba(case16Id.color.r,case16Id.color.g, case16Id.color.b,0.25)
			case14Id.color = "cyan"
			case14Id.color= Qt.rgba(case14Id.color.r,case14Id.color.g, case14Id.color.b,0.25)
			case17Id.color = "cyan"
			case17Id.color= Qt.rgba(case17Id.color.r,case17Id.color.g, case17Id.color.b,0.25)
			case15Id.color = "brown"
			case15Id.color= Qt.rgba(case15Id.color.r,case15Id.color.g, case15Id.color.b,0.25)
			player.parent = layoutPawn16
			break;
		case'17':
			player.parent = layoutPawn17
			if(!layoutPawn16.children[0]) {
				case16Id.color = "transparent"
				case16Id.opacity = 1
				case14Id.color = "transparent"
				case16Id.opacity = 1
				case17Id.color = "transparent"
				case17Id.opacity = 1
				case15Id.color = "transparent"
				case15Id.opacity = 1
			}
			break;
		case '18':
			player.parent = layoutPawn18
			break;
		case '19':
			player.parent = layoutPawn19
			break;
		case '20':
			player.parent = layoutPawn20
			break;
		case '21':
			player.parent = layoutPawn21
			break;
		case '22':
			player.parent = layoutPawn22
			break;
		case '23':
			player.parent = layoutPawnBarque
			break;  
		default:
			break
	}
}
