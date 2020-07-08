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
     echo "Player will play first"
  else
     echo "Computer will play first"
  fi
}

boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss
