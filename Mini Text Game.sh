#!/bin/bash

#beast stats
beast1atk=$((75 + $RANDOM % 30));
beast1hp=300

#Great Big Sword
sword=30

#functions
function function1 () {
    case $class in
	    samurai)
		    type="samurai"
		    hp=100
		    attack=20
		    ;;
	    prisoner)
		    type="prisoner"
		    hp=150
		    attack=15
		    ;;
	    prophet)
		    type="prophet"
		    hp=200
		    attack=10
		    ;;
    esac
}

function chose1left() {
if [[ $choice1 == "left" ]]; then
	echo "Out of the forest the beast leaps and attacks you!"
	sleep 1
    echo "You have to choose! Will you ?
.. fight OR run"	
fi
read for1
}

function checkvitals() {
    if [[ $hp -ge 1 ]]; then
        echo "$hp hp"
        sleep 1
    else
        echo "You are DEAD!"
        exit
    fi
}

function checkclass() {
    if [[ $class == "prisoner" || $class == "samurai" || $class == "prophet" ]]; then
        function1
    else 
        echo "Please choose samurai, prisoner or prophet"
        sleep 1
        read class
        checkclass
    fi
}

function checkchoice1() {
    read choice1    
    while [[ $choice1 != "left" && $choice1 != "right" ]]
    do
	    echo "$choice1 is not left OR right, try again"
        sleep 1	    
        read choice1
    done
    echo "You chose to go on the $choice1 pathway!"
    sleep 1
if [[ $choice1 == "left" ]]; then
	echo "Out of the forest the beast leaps to attack you!"
	sleep 1
    echo "You were able to dodge and you can choose your next move!"
    sleep 1
    echo "Will you ..
.. fight OR run ?"
	checkchoice2
fi
if [[ $choice1 == "right" ]]; then
    echo "After a while you found a river"
    sleep 1
    echo "You see something shining between the pebles!"
    sleep 1
    echo "What would you do, see what is it, or move on..
.. pick OR move ?"
    checkchoice3
fi
}

function checkchoice2() {
    read for1
    while [[ $for1 != "fight" && $for1 != "run" ]]
    do
	    echo "$for1 is not fight OR run, try again"
	    read for1
    done
    checkchoice2.1
}

function checkchoice2.1() {
    if [[ $for1 == "fight" ]]; then
        yourturn
    elif [[ $for1 == "run" ]]; then
        echo "You ran back to the crossroad..."
        sleep 1
        echo "$choice1 was last time, how about now...
        ...left OR right"
        checkchoice1
    else
        echo "something is wrong with checkchoice2.1"
    fi        
}

function checkchoice3() {
    read pom1
    while [[ $pom1 != "pick" && $pom1 != "move" ]]
    do
	    echo "$pom1 is not pick OR move, try again"
	    read pom1
    done
    checkchoice3.1

}

function checkchoice3.1() {
    if [[ $pom1 == "pick" ]]; then
        echo "You try to push the rocks away to see what is that shining thing."
        sleep 2
        echo "Now you see a handle"        
        sleep 1
        echo "You grab it and pull out.."
        sleep 1        
        getsword
    elif [[ $pom1 == "move" ]]; then
        getmoving
    else
        echo "something is wrong with checkchoice3.1"
    fi        
}

function getsword() {
    echo "WOW A GREAT BIG SWORD!"
    sleep 1
    attack=$((attack * sword))
    echo "After you pick it you feel your atk.power rise to $attack"
    sleep 3
    echo "You decide it's more than enough to slay the beast!"
    sleep 1
    getmoving
}

function getmoving {
echo "Then cross the river and head for the lair of the Beast"
sleep 2
echo "But you spot it preparing an ambush in the woods"
sleep 2
echo "What will it be? Will you Fight the beast?"
sleep 1
echo "Or run cowardly back to the crossroad?
..fight OR run"
checkchoice2
}

function beastattack() {
    echo "The Beast attacks you"
    sleep 1
    hp=$((hp - beast1atk))
    echo "You are down to $hp "
        if [[ $hp -ge 1 ]]; then
            echo "fight OR run"
            read for1
            checkchoice2
        else 
            checkvitals
        fi
}

function attackbeast() {
    echo "You attack the beast!"
    beast1hp=$(( beast1hp - ( $RANDOM%5 + attack )))
    echo "It is down to $beast1hp hp"
    if [[ $beast1hp -ge 1 ]]; then
        sleep 2        
        beastattack
    else 
    echo "The beast is slain, VICTORY!"
    exit
    fi
}

function yourturn() {
    if [[ $hp -ge 1 && $beast1hp -ge 1 ]]; then
        sleep 2        
        attackbeast
    elif [[ $hp -le 0 ]]; then
        checkvitals
    elif [[ $beast1hp -le 0 ]]; then
        echo "The beast is slain - VICTORY!"
    exit
    fi 
}

#story start
echo "Choose your starting class
.. samurai | prisoner | prophet"
sleep 1
read class
checkclass
echo "You chose to play as $type with $hp hp and $attack atk.points."
sleep 1
echo "You are on a journey to slay a beast"
sleep 1
echo "A crossroad is in your way, what do you choose?
.. left OR right"
sleep 1
checkchoice1

