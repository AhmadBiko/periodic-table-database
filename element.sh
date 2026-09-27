#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#checking if the user gave an input
if [[ -z $1 ]]

#didn't give an input
then
  echo Please provide an element as an argument.

#gave an input
else 

  #reading the input
  INPUT=$1

  #checking if its a number
  if [[ $INPUT =~ ^[0-9]+$ ]]
  then 

    #its number 
    NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$INPUT';")

    #check if it exists in data base
    if [[ -z $NUM ]] 
    then 

      echo I could not find that element in the database.

    else

    #finding the needed data to print
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $NUM;")
      SYMPOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $NUM;")
      TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING(type_id) WHERE atomic_number = $NUM;")
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $NUM;")
      MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $NUM;")
      BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $NUM;")

      #printing the sentence.
      echo "The element with atomic number $NUM is $NAME ($SYMPOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."

    fi

  else

    #its not number
    CHECK_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$INPUT';")
    CHECK_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$INPUT';")

    #checking if its a name or a symbol
    if [[ -z $CHECK_NAME && -z $CHECK_SYMBOL ]] 
    then

      echo I could not find that element in the database.

    else

      #its a name or symbol
      #checking if its a name
      if  [[ -z $CHECK_SYMBOL ]]
      then

        #its a name
        #finding the needed data to print
        NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$INPUT';")
        SYMPOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $NUM;")
        TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING(type_id) WHERE atomic_number = $NUM;")
        MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $NUM;")
        MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $NUM;")
        BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $NUM;")

        #printing the sentence.
        echo "The element with atomic number $NUM is $INPUT ($SYMPOL). It's a $TYPE, with a mass of $MASS amu. $INPUT has a melting point of $MELT celsius and a boiling point of $BOIL celsius."

      else

        #its a symbol
        #finding the needed data to print
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$INPUT';")
        NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$INPUT';")
        TYPE=$($PSQL "SELECT type FROM properties FULL JOIN types USING(type_id) WHERE atomic_number = $NUM;")
        MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $NUM;")
        MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $NUM;")
        BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $NUM;")

        #printing the sentence.
        echo "The element with atomic number $NUM is $NAME ($INPUT). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."

      fi
    fi
  fi
fi