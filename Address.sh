#!/bin/bash

function create()
{
	# Name of address book
        BOOK="address-book.txt"

        echo -ne " \n Enter First Name : "
        read fname

	echo -ne " \n Enter Last Name : "
        read lname

	echo -ne " \n Enter Address : "
        read address

	echo -ne " \n Enter City : "
        read city

	echo -ne " \n Enter State : "
        read state

	echo -ne " \n Enter ZipCode : "
        read zip

	echo -ne " \n Enter Mobile Number : "
        read mobile

        # Echo the answers and ask for confirmation
        echo -ne "\n Should I Enter The Following Data : \n"
        echo -e "\n $fname ; $lname ; $address ; $city ; $state  ; $zip ; $mobile  \n"
        echo -n "y/n: "
        read answer

        if [ "$answer" == "y" ]
        then
            # Write the values to the address book
            echo -ne " $fname ; $lname ; $address ; $city ; $state  ; $zip ; $mobile " >>$BOOK
        else
            # Give the user a message
            echo -ne "\n Data NOT written to $BOOK \n "

	fi
}

function display()
{
	BOOK="address-book.txt"

        # Display the format before the entries
        echo -ne "\n Sr.No.:   First Name  ;  Last Name  ;  Address  ;  City  ;  State   ;  Zip  ;  Mobile  \n"

        nl --number-separator=":    " $BOOK | awk -F ";" '{print $1 $2 $3 $4 $5 $6 $7}'

}

function search()
{
	BOOK="address-book.txt"

        echo -ne "\n Enter Name Or Mobile No Of Person's You Want To Search : "
        read find

        echo -ne "\n"
	grep -i $find $BOOK
}

function modify()
{
        BOOK="address-book.txt"

	echo -ne "\n Enter Name Or Mobile No Of Person's You Want To Modify : "
        read find_mobile

        len=`grep -i $find_mobile $BOOK`

	if [ $len -ne 0 ]
	then
		echo -ne "\n Enter New Address City State Zip "
                read address city state zip
		new=`$address $city $state $zip`
		old=`cat $BOOK | ($address $city $state $zip)`

		sed -i s/"$old"/"$new"/g $BOOK
		echo -ne "\n Record Modified ..! \n"
	else
		echo -ne "\n Mobile Number Not Found "
	fi
}

function delete()
{
	BOOK="address-book.txt"

        # Ask the user which line to delete
        echo -ne "\n Please Enter Sr.No. You Want To Delete : "
        read number

        # Rename the file before deleting
        mv $BOOK boo.txt

        # Add line numbers and delete against that number
        nl --number-separator=":" boo.txt | grep -v $number: | awk -F: '{print $2}' |  tee $BOOK

}

while [ true ]
do

	echo -ne "\n ***** Menu *****\n"
	echo -ne "\n 1. Create_Record "
	echo -ne "\n 2. Display_Record "
	echo -ne "\n 3. Search_Record "
	echo -ne "\n 4. Modify_Record "
	echo -ne "\n 5. Delete_Record "
	echo -ne "\n 6. Exit \n"
	echo -ne "\n Enter Choice : "
	read choice

	case $choice in
		1)      create
                        ;;
		2)	display
			;;
		3)      search
                        ;;
		4)      modify
                        ;;
		5)      delete
                        ;;

		6)	exit
			;;
	esac
done


