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

function findYposition(count, choosePlayer, array) {
    switch(count) {
        case '0':
            return choosePlayer.yPosition = case0Id.height + 22*array[0]
        case '1':
            return choosePlayer.yPosition = case1Id.y + 22*array[1]
        case '2':
            return choosePlayer.yPosition = case2Id.y + 22*array[2]
        case '3':
            return choosePlayer.yPosition = case3Id.y + 22*array[3]
        case '4':
            return choosePlayer.yPosition = case4Id.y + 22*array[4]
        case '5':
            return choosePlayer.yPosition = case5Id.y + 22*array[5]
        case '6':
            return choosePlayer.yPosition = case6Id.y + 22*array[6]
        case '7':
            return choosePlayer.yPosition = case7Id.y + 22*array[7]
        case '8':
            return choosePlayer.yPosition = cases8_9id.y + case8Id.y + 22*array[8]
        case '9':
            return choosePlayer.yPosition = cases8_9id.y + case9Id.y + 22*array[9]
        case '10':
            return choosePlayer.yPosition = case10Id.y + 22*array[10]
        case '11':
            return choosePlayer.yPosition = cases11_12id.y + case11Id.y + 22*array[11]
        case '12':
            return choosePlayer.yPosition = cases11_12id.y + case12Id.y + 22*array[12]
        case '13':
            return choosePlayer.yPosition = case13Id.y + 22*array[13]
        case '14':
            return choosePlayer.yPosition = cases14_15id.y + case14Id.y+22*array[14]
        case '15':
            return choosePlayer.yPosition = cases14_15id.y + case15Id.y+22*array[15]
        case '16':
            return choosePlayer.yPosition = cases16_17id.y + case16Id.y+22*array[16]
        case '17':
            return choosePlayer.yPosition = cases16_17id.y + case17Id.y+22*array[17]
        case '18':
            return choosePlayer.yPosition = case18Id.y + 22*array[18]
        case '19':
            return choosePlayer.yPosition = case19Id.y + 22*array[19]
        case '20':
            return choosePlayer.yPosition = case20Id.y + 22*array[20]
        case '21':
            return choosePlayer.yPosition = case21Id.y + 22*array[21]
        case '22':
            return choosePlayer.yPosition = case22Id.y + 22*array[22]
        case '23':
            return choosePlayer.yPosition = caseBarqueId.y + 22*array[23]        
        default:
            break
    }
}

function findXposition(count,choosePlayer,array) {
    switch(count) {
        case '0':
            return choosePlayer.xPosition = case0Id.x + 22*array[0]
        case '1':
            return choosePlayer.xPosition = case1Id.x + 22*array[1]
        case '2':
            return choosePlayer.xPosition = case2Id.x + 22*array[2]
        case '3':
            return choosePlayer.xPosition = case3Id.x + 22*array[3]
        case '4':
            return choosePlayer.xPosition = case4Id.x + 22*array[4]
        case '5':
            return choosePlayer.xPosition = case5Id.x + 22*array[5]
        case '6':
            return choosePlayer.xPosition = case6Id.x + 22*array[6]
        case '7':
            return choosePlayer.xPosition = secondPlateauid.x + case7Id.x + 22*array[7]
        case '8':
            return choosePlayer.xPosition = secondPlateauid.x + cases8_9id.x + case8Id.x + 22*array[8]
        case '9':
            return choosePlayer.xPosition = secondPlateauid.x + cases8_9id.x + case9Id.x + 22*array[9]
        case '10':
            return choosePlayer.xPosition = secondPlateauid.x + case10Id.x + 22*array[10]
        case '11':
            return choosePlayer.xPosition = secondPlateauid.x + cases11_12id.x + case11Id.x + 22*array[11]
        case '12':
            return choosePlayer.xPosition = secondPlateauid.x + cases11_12id.x +  case12Id.x + 22*array[12]
        case '13':
            return choosePlayer.xPosition = thirdPlateauid.x + case13Id.x + 22*array[13]
        case '14':
            return choosePlayer.xPosition = thirdPlateauid.x + cases14_15id.x + case14Id.x + 22*array[14]
        case '15':
            return choosePlayer.xPosition = thirdPlateauid.x + cases14_15id.x + case15Id.x + 22*array[15]
        case '16':
            return choosePlayer.xPosition = thirdPlateauid.x + cases16_17id.x + case16Id.x + 22*array[16]
        case '17':
            return choosePlayer.xPosition = thirdPlateauid.x + cases16_17id.x + case17Id.x + 22*array[17]
        case '18':
            return choosePlayer.xPosition = endPlateauId.x + case18Id.x + 22*array[18]
        case '19':
            return choosePlayer.xPosition = endPlateauId.x + case19Id.x + 22*array[19]
        case '20':
            return choosePlayer.xPosition = endPlateauId.x + case20Id.x + 22*array[20]
        case '21':
            return choosePlayer.xPosition = endPlateauId.x + case21Id.x + 22*array[21]
        case '22':
            return choosePlayer.xPosition = endPlateauId.x + case22Id.x + 22*array[22]
        case '23':
            return choosePlayer.xPosition = endPlateauId.x + caseBarqueId.x + 22*array[23]
        default:
            break
    }
}
