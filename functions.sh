#!/bin/bash

Add_DB()
{
echo "Enter the DB name to add" 
read Adddb
mkdir /home/ebrahim/Databases/$Adddb
}

List_DB()
{
echo "The available databases are:"
ls /home/ebrahim/Databases/
}

Delete_DB()
{
echo "The available databases are: "
ls -1 "/home/ebrahim/Databases"
echo "Enter the DB name to delete: "
read Deletdb
rm -r "/home/ebrahim/Databases/$Deletdb"
}

Connect_DB()
{
List_DB
echo "Enter the DB name to connect:"
read Connectdb
cd "/home/ebrahim/Databases/$Connectdb"
}





