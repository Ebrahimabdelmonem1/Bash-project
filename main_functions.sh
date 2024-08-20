#!/bin/bash
. ./table_options.sh 

#function to display the main menu options

Display_main()
{
echo -e "\n"
echo -e "\033[32m#***********************************************#\033[0m"
echo "#                                               #" 
echo "#      Press '1' to Create Database             #"
echo "#      Press '2' to List Databases              #"
echo "#      Press '3' to Connect to Database         #"
echo "#      Press '4' to Drop Database               #"
echo "#      Press '5' to exit                        #"
echo "#                                               #" 
echo -e "\033[32m#***********************************************#\033[0m"
echo -e "\n"
}

#function to add new database

Add_DB()
{

echo "Enter the DB name to add" 

#reading database name to create

read Adddb

#check if the name user entered is valid or not

while true ; do  

 if [[ $Adddb =~ ^[a-zA-Z]+$ ]] ; then 
 mkdir /home/ebrahim/Databases/$Adddb
 
break
 else
 echo "please enter a valid input   (strings only) "
 Add_DB
fi

done

}

#function to list available databases

List_DB()
{
echo "The available databases are:"

#list the available databases 

ls /home/ebrahim/Databases/ 

}

#function to delete existing database

Delete_DB()
{
List_DB

while true; do

#reading database name to delete 

echo "Enter the DB name to delete: "
read Deletdb
cd /home/ebrahim/Databases/

#check if the database name user entered is available or not

if [ -d "$Deletdb" ]; then
rm -r "/home/ebrahim/Databases/$Deletdb"
echo "the Database ($Deletdb) has been deleted successfully"
break
 else
     echo "\033[31m No Database with the name : $Deletdb please try a valid name \033[0m"
      List_DB
    fi
done

}

#function to connect to existing database

Connect_DB()
{
List_DB

while true; do

#reading database name to connect

echo "Enter the DB name to connect:"
read Connectdb
cd /home/ebrahim/Databases/

#check if the database name user entered is available or not

    if [ -d "$Connectdb" ]; then
     cd "/home/ebrahim/Databases/$Connectdb"
      tab_mod
       break  
    else
     echo -e "\033[31mNo Database with the name : $Connectdb please try again \033[0m"
      List_DB
    fi
    done
    
}
