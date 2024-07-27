#!/bin/bash
. ./functions.sh

clear 
echo "*************************************************************************************************************************************"
echo "#####################################################################################################################################"
echo -e "\n"
echo -e "\033[1;31mWelcome $USER to DevOps Project (DBMS)\033[0m"
echo -e "\033[1;34mDeveloped by Ebrahim Abdelmonem Mohamed \033[0m "
#echo -e "\033[32mDEPI first QAL batch  \033[0m" 
echo -e "\n"
echo "#####################################################################################################################################"
echo "*************************************************************************************************************************************"
echo "Press '1' to Create Database"
echo "Press '2' to List Databases"
echo "Press '3' to Connect to Database"
echo "Press '4' to Drop Database"
echo "Press '5' to exit"
  

while true; do
    read -p "Enter your choice (1-5): " opt
    
     
    if [[ $opt =~ ^[1-5]$ ]]; then
    
    
        case "$opt" in
             "1")
                 Add_DB
                 ;;
             "2")
                 List_DB 
                 ;;
             "3")
                 Connect_DB
                 ;;
             "4")
                 Delete_DB            
                 ;;
             "5")
                 echo "exiting" ; exit
        esac
    
    
    else    
        echo "Invalid input. Please enter a number between 1 and 5 "
    
    fi
    
done

