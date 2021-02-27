function choosePlayer(player){

switch (player) {
    case'player1':
           return player1
    case'player2':
            return player2
    case'player3':
            return player3
    case'player4':
            return player4
    case'player5':
            return player5
    case'player6':
            return player6
    case'player7':
            return player7
    default :
           console.log("wrong string player")
           break;
    }
}

function findYposition(count,choosePlayer){

  switch(count){
        case'0':
            return   choosePlayer.yPosition = case0Id.y
        case'1':
            return   choosePlayer.yPosition = case1Id.y
        case'2':
            return  choosePlayer.yPosition = case2Id.y
        case'3':
            return  choosePlayer.yPosition = case3Id.y
        case'4':
            return  choosePlayer.yPosition = case4Id.y
        case'5':
            return  choosePlayer.yPosition = case5Id.y
        case'6':
            return  choosePlayer.yPosition = case6Id.y
        case'7':
            return  choosePlayer.yPosition = case7Id.y
        case'8':
            return  choosePlayer.yPosition = case8Id.y
        case'9':
            return  choosePlayer.yPosition = case9Id.y
        case'10':
            return  choosePlayer.yPosition = case10Id.y
        default:
            console.log("no change..")
  }
}

function findXposition(count,choosePlayer){

  switch(count){
        case'0':
            return choosePlayer.xPosition = case0Id.x
        case'1':
            return  choosePlayer.xPosition = case1Id.x
        case'2':
            return choosePlayer.xPosition = case2Id.x
        case'3':
            return choosePlayer.xPosition = case3Id.x
        case'4':
            return choosePlayer.xPosition = case4Id.x
        case'5':
            return choosePlayer.xPosition = case5Id.x
        case'6':
            return choosePlayer.xPosition = case6Id.x
        case'7':
            console.log("x7 = "+ case7Id.x)
            return choosePlayer.xPosition = case7Id.x

        case'8':
            console.log("x8 = "+ case8Id.x)
            return choosePlayer.xPosition = case8Id.x
        case'9':
            return choosePlayer.xPosition = case9Id.x
        case'10':
            return choosePlayer.xPosition = case10Id.x
        default:
            console.log("no change..")
  }
}
