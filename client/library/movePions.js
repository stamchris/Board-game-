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

function fixYArray(array, index) {
    if (array[index] > 2) {
        return array[index] = 0
    } else {
        return array[index] += 1
    }
}

function fixXCounter(array, index) {
    if (array[index] <8 ) {
        return array[index] += 1
    } else{
        return array[index] = 0
    }
}

function fixXArray(xarray, xCounter, index) {
    if (xCounter[index] > 4) {
        return xarray[index] = 1
    } else {
        return xarray[index] = 0
    }
}

function findYposition(count, choosePlayer) {
    switch(count) {
        case '0':
            choosePlayer.parent = layoutPawn0
            return choosePlayer.yPosition = layoutPawn0.height
        case '1':
            choosePlayer.parent = layoutPawn1
            return choosePlayer.yPosition = layoutPawn1.height
        case '2':
            choosePlayer.parent = layoutPawn2
            return choosePlayer.yPosition = layoutPawn2.height
        case '3':
            choosePlayer.parent = layoutPawn3
            return choosePlayer.yPosition = layoutPawn3.height
        case '4':
            choosePlayer.parent = layoutPawn4
            return choosePlayer.yPosition = layoutPawn4.height
        case '5':
            choosePlayer.parent = layoutPawn5
            return choosePlayer.yPosition = layoutPawn5.height
        case '6':
            choosePlayer.parent = layoutPawn6
            return choosePlayer.yPosition = layoutPawn6.height
        case '7':
            choosePlayer.parent = layoutPawn7
            return choosePlayer.yPosition = layoutPawn7.height
        case '8':
            choosePlayer.parent = layoutPawn8
            return choosePlayer.yPosition = layoutPawn8.height
        case '9':
            choosePlayer.parent = layoutPawn9
            return choosePlayer.yPosition = layoutPawn9.height
        case '10':
            choosePlayer.parent = layoutPawn10
            return choosePlayer.yPosition = layoutPawn10.height
        case '11':
            choosePlayer.parent = layoutPawn11
            return choosePlayer.yPosition = layoutPawn11.height
        case '12':
            choosePlayer.parent = layoutPawn12
            return choosePlayer.yPosition = layoutPawn12.height
        case '13':
            choosePlayer.parent = layoutPawn13
            return choosePlayer.yPosition = layoutPawn13.height
        case '14':
            choosePlayer.parent = layoutPawn14
            return choosePlayer.yPosition = layoutPawn14.height
        case '15':
            choosePlayer.parent = layoutPawn15
            return choosePlayer.yPosition = layoutPawn15.height
        case '16':
            console.log("portail activé")
            case16Id.color = "red"
            case16Id.opacity = 0.25
            case14Id.color = "cyan"
            case14Id.opacity = 0.25
            case17Id.color = "cyan"
            case17Id.opacity = 0.25
            case15Id.color = "brown"
            case15Id.opacity = 0.25
                
            choosePlayer.parent = layoutPawn16
            return choosePlayer.yPosition = layoutPawn16.height
        case'17':
            choosePlayer.parent = layoutPawn17
            if(!layoutPawn16.children[0]) {
                case16Id.color = "transparent"
                case16Id.opacity = 1
                case14Id.color = "transparent"
                case16Id.opacity = 1
                case17Id.color = "transparent"
                case17Id.opacity = 1
                case15Id.color = "transparent"
                case15Id.opacity = 1
                console.log("portail désactivé")
            }
            return choosePlayer.yPosition = layoutPawn17.height
        case '18':
            choosePlayer.parent = layoutPawn18
            return choosePlayer.yPosition = layoutPawn18.height
        case '19':
            choosePlayer.parent = layoutPawn19
            return choosePlayer.yPosition = layoutPawn19.height
        case '20':
            choosePlayer.parent = layoutPawn20
            return choosePlayer.yPosition = layoutPawn20.height
        case '21':
            choosePlayer.parent = layoutPawn21
            return choosePlayer.yPosition = layoutPawn21.height
        case '22':
            choosePlayer.parent = layoutPawn22
            return choosePlayer.yPosition = layoutPawn22.height
        case '23':
            choosePlayer.parent = layoutPawnBarque
            return choosePlayer.yPosition = layoutPawnBarque.height   
        default:
            break
    }
}

function findXposition(count, choosePlayer) {
    switch(count) {
        case '0':
            choosePlayer.parent = layoutPawn0
            return  choosePlayer.xPosition = layoutPawn0.x
        case '1':
            choosePlayer.parent = layoutPawn1
            return  choosePlayer.xPosition = layoutPawn1.x
        case '2':
            choosePlayer.parent = layoutPawn2
            return choosePlayer.xPosition = layoutPawn2.x
        case '3':
            choosePlayer.parent = layoutPawn3
            return choosePlayer.xPosition = layoutPawn3.x
        case '4':
            choosePlayer.parent = layoutPawn4
            return choosePlayer.xPosition = layoutPawn4.x
        case '5':
            choosePlayer.parent = layoutPawn5
            return choosePlayer.xPosition = layoutPawn5.x
        case '6':
            choosePlayer.parent = layoutPawn6
            return choosePlayer.xPosition = layoutPawn6.x
        case '7':
            choosePlayer.parent = layoutPawn7
            return choosePlayer.xPosition = layoutPawn7.x
        case '8':
            choosePlayer.parent = layoutPawn8
            return choosePlayer.xPosition = layoutPawn8.x
        case '9':
            choosePlayer.parent = layoutPawn9
            return choosePlayer.xPosition = layoutPawn9.x
        case '10':
            choosePlayer.parent = layoutPawn10
            return choosePlayer.xPosition = layoutPawn10.x
        case '11':
            choosePlayer.parent = layoutPawn11
            return choosePlayer.xPosition = layoutPawn11.x
        case '12':
            choosePlayer.parent = layoutPawn12
            return choosePlayer.xPosition = layoutPawn12.x
        case '13':
            choosePlayer.parent = layoutPawn13
            return choosePlayer.xPosition = layoutPawn13.x
        case '14':
            choosePlayer.parent = layoutPawn14
            return choosePlayer.xPosition = layoutPawn14.x
        case '15':
            choosePlayer.parent = layoutPawn15
            return choosePlayer.xPosition = layoutPawn15.x
        case '16':
            choosePlayer.parent = layoutPawn16
            return choosePlayer.xPosition = layoutPawn16.x
        case '17':
            choosePlayer.parent = layoutPawn17
            return choosePlayer.xPosition = layoutPawn17.x
        case '18':
            choosePlayer.parent = layoutPawn18
            return choosePlayer.xPosition = layoutPawn18.x
        case '19':
            choosePlayer.parent = layoutPawn19
            return choosePlayer.xPosition = layoutPawn19.x
        case '20':
            choosePlayer.parent = layoutPawn20
            return choosePlayer.xPosition = layoutPawn20.x
        case '21':
            choosePlayer.parent = layoutPawn21
            return choosePlayer.xPosition = layoutPawn21.x
        case '22':
            choosePlayer.parent = layoutPawn22
            return choosePlayer.xPosition = layoutPawn22.x
        case '23':
            choosePlayer.parent = layoutPawnBarque
            return choosePlayer.xPosition = layoutPawnBarque.x
        default:
            break
    }
}
