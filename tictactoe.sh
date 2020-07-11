#! /bin/bash

echo Tic-Tac-Toe problem solved here

function resetBoard() #reset the board by making all array position as '.'
{
   boardLength=$1
   for ((index=0;index<$boardLength;index++))
   do
      Board[$index]=.
   done
}
   
function toss()
{
   tossResult=$(( RANDOM % 2 ))
   case $tossResult in
   0)
      echo "Please select X or O"
      read playerLetter
      case $playerLetter in
      "X")
        computerLetter="O"
       ;;
      "O")
        computerLetter="X"
       ;;
      esac
     ;;
   1)
      random=$(( RANDOM % 2 ))
      if ((random==0))
      then 
         computerLetter="X"
         playerLetter="O"
      else
         computerLetter="O"
         playerLetter="X"
      fi
      echo "Computer won will play first"
      ;;
   esac
   
   echo "Player letter " $playerLetter
   echo "Computer letter" $computerLetter
}
   
function displayBoard()
{
   echo
   column=1
   for ((index=0;index<$boardLength;index++))
   do
      if ((column==$boardSize))
      then
         echo ' ' ${Board[$index]}
         if ((index!=$boardLength-1))
         then
            echo '----- ----- -----'
         fi
         column=0
      else
         echo -n ' ' ${Board[$index]} ' |'
      fi
      ((column++))
   done
   
   isGameOver
}
   
function isTie()
{
   tie=1
   for ((index=0;index<$boardLength;index++))
   do
      if [[ ${Board[$index]} == "." ]]
      then
         tie=0
         break
      fi
   done
   echo $tie
}
   
function checkIfWon()
{
   win=0
   #check for rows
   for ((row=0;row<$boardSize;row++))
   do
      if(($win==1))
      then
         break
      fi
      win=1
      arrayIndex=$((($row)*$boardSize))
      firstElement=${Board[$arrayIndex]}
      for ((column=0;column<$boardSize;column++))
      do
         arrayIndex=$((($row)*$boardSize+($column)))
         if [[ $firstElement != ${Board[$arrayIndex]} ]] || [[ ${Board[$arrayIndex]} == '.' ]]
         then
             win=0
             break
         fi
      done
   done

   if((win==0))
   then
       #check for Columns
       for ((row=0;row<$boardSize;row++))
       do
          if(($win==1))
           then
               break
           fi
           win=1
           firstElement=${Board[$row]}
           for ((column=row;column<$boardLength;column+=$boardSize))
           do
              if [[ $firstElement != ${Board[$column]} ]] || [[ ${Board[$column]} == '.' ]]
              then
                 win=0
                 break
              fi
           done
       done
    fi
     
    #first Diagonal
    if((win==0))
    then
        firstElement=${Board[0]}
        win=1
        for ((row=0;row<$boardSize;row++))
        do
           for ((column=0;column<$boardSize;column++))
           do
              if ((row==column))
              then
                  arrayIndex=$((($row)*$boardSize+($column)))
                  if [[ $firstElement != ${Board[$arrayIndex]} ]] || [[ ${Board[$arrayIndex]} == '.' ]]
                  then
                      win=0
                      break
                  fi
              fi
           done
        done
    fi
     
    #second diagonal
    if((win==0))
    then
        firstElement=${Board[$boardSize-1]}
        win=1
        for ((row=0;row<$boardSize;row++))
        do
            for ((column=0;column<$boardSize;column++))
            do
                if ((row+column==$boardSize-1))
                then
                    arrayIndex=$((($row)*$boardSize+($column)))
                    if [[ $firstElement != ${Board[$arrayIndex]} ]] || [[ ${Board[$arrayIndex]} == '.' ]]
                    then
                        win=0
                        break
                    fi
                fi
            done
        done
    fi
   
    echo $win
}
   
function computerTurn()
{
    currentChance="Computer"
    played=0
    #Play to win
    for ((index=0;index<$boardLength;index++))
    do
       if [ ${Board[$index]} == '.' ]
       then
           Board[$index]=$computerLetter
           if (($(checkIfWon)==1))
           then
              played=1
              break
           else
              Board[$index]='.'
           fi
        fi
    done
   
    if ((played==0))
    then
       #Play to Block
       for ((index=0;index<$boardLength;index++))
       do
          if [ ${Board[$index]} == '.' ]
          then
             Board[$index]=$playerLetter
             if (($(checkIfWon)==1))
             then
                Board[$index]=$computerLetter
                played=1
                break
             else
                Board[$index]='.'
             fi
          fi
       done
    fi
   
   
    if ((played==0))
    then
       #Play for Corners
       if [[ ${Board[0]} == "." ]]
       then
           Board[0]=$computerLetter
           played=1
       elif [[ ${Board[$(($boardSize-1))]} == "." ]]
       then
           Board[$(($boardSize-1))]=$computerLetter
           played=1
       elif [[ ${Board[$((($boardSize-1)*$boardSize))]} == "." ]]
       then
           Board[$((($boardSize-1)*$boardSize))]=$computerLetter
           played=1
       elif [[ ${Board[$((($boardSize-1)*$boardSize+($boardSize-1)))]} == "." ]]
       then
           Board[$((($boardSize-1)*$boardSize+($boardSize-1)))] == $computerLetter ]]
           played=1
       fi
    fi
   
    if ((played==0))
    then
       #play for center
       local centerIndex=$((($boardLength-1)/2))
      if [ ${Board[$centerIndex]} = "." ]
      then
         Board[$centerIndex]=$computerLetter
         played=1
      fi
    fi
   
    if ((played==0))
    then
       #Play remaining position
       for ((index=0;index<$boardLength;index++))
       do
          if [ ${Board[$index]} == '.' ]
          then
              Board[$index]=$computerLetter
              played=1
              break
          fi
       done
    fi
   
    displayBoard
}

function getAvailableMoves()
{
    for ((row=0;row<$boardSize;row++))
    do
        for ((column=0;column<$boardSize;column++))
        do
           arrayIndex=$((($row)*$boardSize+($column)))
           if [[ ${Board[$arrayIndex]} == "." ]]
           then
              avaiableMoves+=$(($row+1))','$(($column+1))' '
           fi
        done
    done
    echo $avaiableMoves
}

function playerTurn()
{
    currentChance="Player"
    while(true)
    do
        local moves=$(getAvailableMoves)
        echo "Avaialble moves: " $moves
        read -p "Enter Row:" row
        read -p "Enter Column:" column

        arrayIndex=$((($row-1)*$boardSize+($column-1)))

        if [[ ${Board[$arrayIndex]} != '.' ]]
        then
            echo "Position already filled. Choose another."
        else
            Board[$arrayIndex]=$playerLetter
            break
        fi
    done
   
    displayBoard
}

function isGameOver()
{
    gameOver=0
    if (($(checkIfWon)==1))
    then
        echo "Game won by " $currentChance
        gameOver=1
    elif (($(isTie)==1))
    then
        echo "Match Drawn"
        gameOver=1
    fi
}

function play()
{
   displayBoard
   while(true)
   do
      if ((tossResult==0))
      then
          playerTurn
          if (( $gameOver==0 ))
          then
             computerTurn
          fi
      else
          computerTurn
          if (( $gameOver==0 ))
          then
            playerTurn
          fi
      fi
   
      if (( $gameOver==1 ))
      then
         break
      fi
   done
}
   
boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss
play
