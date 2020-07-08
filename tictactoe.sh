
#! /bin/bash
echo Tic-Tac-Toe problem solved here
function resetBoard() #reset the board by making all array position as '.'
{
boardLength=$1
for ((i=0;i<$boardLength;i++))
do
Board[i]=.
done
}

function toss()
{
  tossResult=$(( RANDOM % 2 ))
  if ((tossResult==0))
  then
     echo "Please select X or O"
     read playerletter
     if ((playerletter=="X"))
     then
         computerletter="Y"
     else
         computerletter="X"
     fi
     echo "Player won will play first"
  else
     random=$(( RANDOM % 2 ))
     if ((tossResult==0))
     then
        computerletter="X"
        playerletter="Y"
     else
        computerletter="Y"
        playerletter="X"
     fi
     echo "Computer won will play first"
  fi
 
  echo "Player letter " $playerletter
  echo "Computer letter" $computerletter
}

boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss
