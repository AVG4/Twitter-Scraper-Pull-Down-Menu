#!/usr/bin/env bash


# Written By Acon1tum 2021 as a BASH exercise - Original Menu Unknown and Butchered.

# IMPORTANT - You will need to install lolcat or remove it from the script.  



# Setting up your functions

# Option 1 shows all tweets from a user's timeline

function option1 { 
clear
echo "Option 1"
echo
 read -p "Enter Username>" username
 twint -u $username
}

# Option 2 shows all tweets from a user's timeline containing a keyword

function option2 { 
clear
echo "Option 2"
echo
 read -p "Enter Username>" username
 read -p "Enter Keyword>" keyword
 twint -u $username -s $keyword 
}

# Option 3 shows all tweets containing a keyword from every user

function option3 { 
clear
echo "Option 3"
echo
 read -p "Enter Keyword>" keyword
 twint -s $keyword
}

# Option 4 shows tweets from a user that were tweeted before a certain year

function option4 { 
clear
echo "Option 4"
echo
 read -p "Enter Username>" username
 read -p "Enter Year (e.g. 2016)>" date
 twint -u $username --year $date
}

# Option 5 shows tweets from a user that were tweeted since a certain date

function option5 { 
clear
echo "Option 5"
echo
 read -p "Enter Username>" username
 read -p "Enter Date (e.g. 2018-06-24)>" date
 twint -u $username --since $date
}

# Option 6 shows tweets by verified users that tweeted about a keyword

function option6 { 
clear
echo "Option 6"
echo
 read -p "Enter Keyword>" keyword
 twint -s $keyword --verified
}

# Option 7 shows tweets from a raidus of a certain distance around a location and saves to a text file

function option7 { 
clear
echo "Option 7"
echo
 read -p "Enter File Name>" file
 read -p "Enter Latitude>" latitude
 read -p "Enter Longitude>" longitude
 read -p "Enter Distance (e.g. 1km)>" distance
 twint -g=$latitude,$longitude,$distance -o $file.txt
}

# Option 8 shows all tweets from a user and saves them to a text file

function option8 { 
clear
echo "Option 8"
echo
 read -p "Enter File Name>" file
 read -p "Enter Username>" username
 twint -u $username -o $file.txt
}

# Option 9 exits the menu

function option9 { 
clear
echo -e "\e[31mQuitting...\e[0m"
echo
sleep 2
clear
exit 1
}
clear


# Setting up title, change however you like it

echo "Welcome to" | lolcat
figlet "Twitter Scrape" | lolcat
echo "by AV4LANCH3" | lolcat
echo
figlet "Menu" | lolcat
echo Please choose one of the following options:



#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...


#   Return value: selected index (0 for opt1, 1 for opt2 ...)
function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}


# Telling user what buttons to use to operate the menu - using escape characters 
echo -e "(Use \e[91mUP\e[0m and \e[91mDOWN\e[0m arrows and \e[91mENTER\e[0m to confirm)"
echo

# Setting up menu items, change these as you wish
options=("1) Show all tweets from a user's timeline" "2) Show all tweets from a user's timeline containing 'keyword'" "3) Show all tweets containing 'keyword' from every user" "4) Show tweets that were tweeted before 'year'" "5) Show tweets that were tweeted since 'date'" "6) Show tweets by verified users that tweeted about 'keyword'" "7) Show tweets from a raidus of '1km' around 'location' and save to a text file" "8) Collect all tweets from a user and save to a text file" "9) Exit")

select_option "${options[@]}"
choice=$?

echo "Choosen index = $choice"
echo "        value = ${options[$choice]}"


# Checking choice and firing the function off

if [[ $choice == 0 ]];then
option1

elif [[ $choice == 1 ]];then
option2

elif [[ $choice == 2 ]];then
option3

elif [[ $choice == 3 ]];then
option4

elif [[ $choice == 4 ]];then
option5

elif [[ $choice == 5 ]];then
option6

elif [[ $choice == 6 ]];then
option7

elif [[ $choice == 7 ]];then
option8

elif [[ $choice == 8 ]];then
option9




fi
