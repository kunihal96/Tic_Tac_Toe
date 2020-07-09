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
   case $tossResult in
   0)
      echo "Please select X or O"
      read playerletter
      if ((playerletter=="X"))
      then
          computerletter="O"
      else
          computerletter="X"
      fi
      echo "Player won will play first"
      ;;
   1)
      random=$(( RANDOM % 2 ))
      if ((tossResult==0))
      then
         computerletter="X"
         playerletter="O"
      else
         computerletter="O"
         playerletter="X"
      fi
      echo "Computer won will play first"
      ;;
   esac
   
   echo "Player letter " $playerletter
   echo "Computer letter" $computerletter
}
   
function displayBoard()
{
   echo
   j=1
   for ((i=0;i<$boardLength;i++))
   do
      if ((j==$boardSize))
      then
         echo ' ' ${Board[i]}
         if ((i!=$boardLength-1))
         then
            echo '----- ----- -----'
         fi
         j=0
      else
         echo -n ' ' ${Board[i]} ' |'
      fi
      ((j++))
   done
   
   isGameOver
}
   
function isTie()
{
   tie=1
   for ((i=0;i<$boardLength;i++))
   do
      if [ ${Board[$i]} == "." ]
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
         if [[ $firstElement != ${Board[arrayIndex]} ]] || [[ ${Board[arrayIndex]} == '.' ]]
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
    for ((j=0;j<$boardLength;j++))
    do
       if [ ${Board[j]} == '.' ]
       then
           Board[j]=$computerletter
           if (($(checkIfWon)==1))
           then
              played=1
              break
           else
              Board[j]='.'
           fi
        fi
    done
   
    if ((played==0))
    then
       #Play to Block
       for ((j=0;j<$boardLength;j++))
       do
          if [ ${Board[j]} == '.' ]
          then
             Board[j]=$playerletter
             if (($(checkIfWon)==1))
             then
                Board[j]=$computerletter
                played=1
                break
             else
                Board[j]='.'
             fi
          fi
       done
    fi
   
   
    if ((played==0))
    then
       #Play for Corners
       if [[ ${Board[0]} == "." ]]
       then
           Board[0]=$computerletter
           played=1
       elif [[ ${Board[$(($boardSize-1))]} == "." ]]
       then
           Board[$(($boardSize-1))]=$computerletter
           played=1
       elif [[ ${Board[$((($boardSize-1)*$boardSize))]} == "." ]]
       then
           Board[$((($boardSize-1)*$boardSize))]=$computerletter
           played=1
       elif [[ ${Board[$((($boardSize-1)*$boardSize+($boardSize-1)))]} == "." ]]
       then
           Board[$((($boardSize-1)*$boardSize+($boardSize-1)))] == "." ]]
           played=1
       fi
    fi
   
    if ((played==0))
    then
       #play for center
       local centerIndex=$((($boardLength-1)/2))
  if [ ${Board[$centerIndex]} = "." ]
  then
  Board[$centerIndex]=$computerletter
  played=1
  fi
    fi
   
    #Play remaining position
    for ((j=0;j<$boardLength;j++))
    do
       if [ ${Board[j]} == '.' ]
       then
           Board[j]=$computerletter
           played=1
           break
        fi
    done
   
    displayBoard
}

function playerturn()
{
    currentChance="Player"
    while(true)
    do
        read -p "Enter Row:" row
        read -p "Enter Column:" column

        arrayIndex=$((($row-1)*$boardSize+($column-1)))

        if [[ ${Board[$arrayIndex]} != '.' ]]
        then
            echo "Position already filled. Choose another."
        else
            Board[$arrayIndex]=$playerletter
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
   
boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss
   

while(true)
do
    if ((tossResult==0))
    then
        playerturn
        if (( $gameOver==0 ))
        then
            computerTurn
        fi
    else
        computerTurn
        if (( $gameOver==0 ))
        then
            playerturn
        fi
    fi
   
    if (( $gameOver==1 ))
    then
       break
    fi
   
done
   
#Player or Computer Move
if (($(checkIfWon)==1))
then
   echo "Match Won"
elif (($(isTie)==1))
then
   echo "Match Drawn"
else
   echo "Change Turn"
fi
