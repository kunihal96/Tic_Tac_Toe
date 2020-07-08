#! /bin/bash

echo Tic Tac Toe game played here

function resetBoard() #reset the board by making all array position as '.'
{
  boardLength=$1

for ((i=0;i<$boardLength;i++))
do
  Board[i]=.
done
}

boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
