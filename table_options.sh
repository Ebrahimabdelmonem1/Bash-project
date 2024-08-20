#!/bin/bash
. ./tab_functoins.sh


tab_mod()
{
clear
echo "#*****************************************************************************************************************#"
echo  "#                                                                                                                 #"
echo -e "#                        \033[32mPlease choose your operation from the following options\033[0m                                  #"
echo  "#                                                                                                                 #"
echo "#*****************************************************************************************************************#"


while true; do
    Display_table_opt
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
                 Select_Table
                 ;;
             
             "6")
                 delete_row_from_table
                 ;;
                
             "7")
                 Update_Table
                 ;;
             
             "8")
                 cd /home/ebrahim/bash_project/Bash-project/
                 ./DBMS_project
                 exit                          
                
        esac
    
    
    else    
        echo -e "\033[31mInvalid input. Please enter a number between 1 and 8 \033[0m"
    
    fi
done
}
