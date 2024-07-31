#!/bin/bash
. ./table_options.sh 

Add_DB()
{
echo "Enter the DB name to add" 
read Adddb
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

List_DB()
{
echo "The available databases are:"
ls /home/ebrahim/Databases/ | awk '/^d/'
}

Delete_DB()
{
List_DB

while true; do

echo "Enter the DB name to delete: "
read Deletdb
cd /home/ebrahim/Databases/
if [ -d "$Deletdb" ]; then
rm -r "/home/ebrahim/Databases/$Deletdb"
echo "the Database ($Deletdb) has been deleted successfully"
break
 else
     echo "\033[31mNo Database with the name : $Deletdb please try again \033[0m"
      List_DB
    fi
done
}

Connect_DB()
{
List_DB

while true; do

echo "Enter the DB name to connect:"
read Connectdb
cd /home/ebrahim/Databases/
    
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
