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
          computerletter="O"
      else
          computerletter="X"
      fi
      echo "Player won will play first"
   else
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
   fi
   
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
   for ((i=0;i<$boardSize;i++))
   do
      if(($win==1))
      then
         break
      fi
      win=1
      arrayIndex=$((($i)*$boardSize))
      firstElement=${Board[$arrayIndex]}
     
      if [ $firstElement != '.' ]
      then
         for ((j=0;j<$boardSize;j++))
         do
            arrayIndex=$((($i)*$boardSize+($j)))
      
            if [[ $firstElement != ${Board[arrayIndex]} ]]
            then
               win=0
               break
            fi
         done
      else
         win=0
      fi
   done
   
   if((win==0))
   then
      #check for Columns
      for ((i=0;i<$boardSize;i++))
      do
         if(($win==1))
         then
            break
         fi
         win=1
         firstElement=${Board[$i]}
     
         if [ $firstElement != '.' ]
         then
            for ((j=i;j<$boardLength;j+=$boardSize))
            do
               if [[ $firstElement != ${Board[$j]} ]]
               then
                  win=0
                  break
               fi
            done
         else
            win=0
         fi
      done
   fi
   
   #first Diagonal
   if((win==0))
   then
       firstElement=${Board[0]}
       win=1
       for ((i=0;i<$boardSize;i++))
       do
          for ((j=0;j<$boardSize;j++))
          do
              if ((i==j)) 
              then
                 arrayIndex=$((($i)*$boardSize+($j)))
                 if [[ $firstElement != ${Board[$arrayIndex]} ]]
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
       for ((i=0;i<$boardSize;i++))
       do
          for ((j=0;j<$boardSize;j++))
          do
              if ((i+j==$boardSize-1)) 
              then
                 arrayIndex=$((($i)*$boardSize+($j)))
                 if [[ $firstElement != ${Board[$arrayIndex]} ]]
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

boardSize=3
resetBoard $( expr $boardSize '*' $boardSize)
toss

Board[0]="O"
Board[1]="X"
Board[3]="X"
Board[4]="X"
Board[5]="O"
Board[2]="O"
Board[7]="M"
Board[6]="O"
Board[8]="X"

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

#computer steps will be defined in further use cases

