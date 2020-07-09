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
   
function computerNextMove()
{
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
                break
             else
                Board[j]='.'
             fi
          fi
       done
    fi
}
   
boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss
   
Board[0]="O"
Board[1]="X"
Board[3]="X"
Board[4]="X"
Board[5]="O"
Board[2]="O"
#Board[7]="M"
Board[6]="O"
Board[8]="X"
   
displayBoard
   
computerNextMove
   
displayBoard
   
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
