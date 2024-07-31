#!/bin/bash

# Function to Add new table
Add_Table()
{
db_name="$1"
table_name=""
num_columns=""
column_names=""
column_name=""
schema_file=""
i=""
    
    read -p "enter db name again :" db_name
    
    read -p "Enter table name: " table_name

    touch $table_name 
   
    schema_file="/home/ebrahim/Databases/$db_name/$table_name.schema"

    touch "$schema_file"

    read -p "Enter the number of columns: " num_columns

    if ! [[ "$num_columns" =~ ^[1-9]+$ ]] || [ "$num_columns" -le 0 ]; then
        echo "Invalid number of columns."
        return 1
    fi

    
    echo "Table: $table_name" > "$schema_file"
    echo "Columns:" >> "$schema_file"

columns=()
for (( i=1; i<=num_columns; i++ ))
do
    echo "Enter the name of column $i:"
    read column
    if [ -z "$column" ]; then
            echo "Column name cannot be empty."
            return 1
          fi    
          columns+=("$column")
          echo "$column" >> "$schema_file"
done
        
# Create the table header using the entered column names
header="+"
header_line="|"
for col in "${columns[@]}"
do
    header+=$(printf '%-s+' "------------")
    header_line+=$(printf '%-s |' "$col")
done

# Use awk to format and print the table
touch monitor_file
awk -F, -v header="$header" -v header_line="$header_line" 'BEGIN {
    print header;
    print header_line;
   # print header;
}
{
    row="|";
    for (i=1; i<=NF; i++) {
        row = row sprintf(" %-s |", $i);
    }
    print row;
}
END {
    print header;
}' monitor_file>"$table_name"
echo "formated table saved to $table_name"

#   echo "$column" >> "$schema_file"
    

    echo "Table '$table_name' created successfully in database '$db_name'."
     
}


# Function to list available table
List_Tables()
{
echo "the available tables are :"
ls
}                


# Function to drop table
Drop_Table()
{

List_Tables

while true ; do 
echo "select table name to drop : "
read rem_name
if [[ -e $rem_name ]] ; then
rm -r $rem_name
rm -r $rem_name.schema
echo "Table with name ( $rem_name ) has been dropped successfully"
break
else
echo -e "\033[31mthere are not table with name ( $rem_name ) , please try again \033[0m "

List_Tables

fi
done 
}
                
                
# Function to insert data into a table
Insert_into_Table()
{
    read -p " enter the database name " db_name
    read -p " enter the table name " table_name

    # Check if the database exists
    if [ ! -d "/home/ebrahim/Databases/$db_name" ]; then
        echo "Database '$db_name' does not exist."
        return 1
    fi

    # Check if the table exists
    if [ ! -f "/home/ebrahim/Databases/$db_name/$table_name.schema" ]; then
        echo "Table '$table_name' does not exist in database '$db_name'."
        return 1
    fi

    # Read column names from the schema file
    schema_file="/home/ebrahim/Databases/$db_name/$table_name.schema"
    columns=($(tail -n +3 "$schema_file"))
     
    # Read values from the user
    values=()
    for column in "${columns[@]}"; do
        read -p "Enter value for column '$column': " value
        if [ -z "$value" ]; then
            echo "Value for column '$column' cannot be empty."
            return 1
        fi
        values+=("$value")
    done

    # Format the data to match the table format
    data_row="|"
    for value in "${values[@]}"; do
        data_row+=$(printf ' %-11s |' "$value")
    done

    # Insert data into the table file
    table_file="/home/ebrahim/Databases/$db_name/$table_name"
    if [ ! -f "$table_file" ]; then
        touch "$table_file"
    fi
    echo "$data_row" >> "$table_file"
    echo "Data inserted successfully into table '$table_name'."
}

# Example usage
# insert_into_table "my_database" "my_table"


 # Function to select data into a table
Select_from_Table()
{

}
                
                
# Function to delete data into a table                
Delete_from_Table()
{


}



# Function to Update table
Update_Table()
{
                
               
                
}
