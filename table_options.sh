#!/bin/bash
. ./tab_functoins.sh


tab_mod()
{
echo "*******************************************************************************************************************"

echo -e "\033[32mPlease choose your operation\033[0m"

echo "********************************************************************************************************************"
echo "Press "1" to add new table"
echo "Press "2" to list tables "
echo "Press "3" to drop table"
echo "Press "4" to insert into table"
echo "Press "5" to select from table"
echo "Press "6" to delete from table"
echo "Press "7" to update table"
echo "Press "8" to back to the main menu"

while true; do
    read -p "Enter your num (1-8): " option
    
    
    if [[ $option =~ ^[1-8]$ ]]; then
    
    
        case "$option" in
            "1")
                Add_Table
                          
                 ;;
             "2") 
                 List_Tables 
                 ;;
             "3")
                 Drop_Table
                 ;;
             "4")
                 Insert_into_Table             
                 ;;
             "5")
             
                 ;;
             
             "6")
             
                 ;;
                
             "7")
             
                 ;;
             
             "8")
                 cd /home/ebrahim/bash_project/Bash-project/ #main_menu
                 ./main_menu.sh
                 exit                          
                
        esac
    
    
    else    
        echo -e "\033[31mInvalid input. Please enter a number between 1 and 8 \033[0m"
    
    fi
done
}
