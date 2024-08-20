#!/bin/bash

#function to display table options

Display_table_opt()
{
echo -e "\n"
echo -e "\033[32m#********************************************#\033[0m"
echo "#                                            #"
echo "#   Press "1" to add new table                 #"
echo "#   Press "2" to list tables                   #"
echo "#   Press "3" to drop table                    #"
echo "#   Press "4" to insert into table             #"
echo "#   Press "5" to monitor data in table         #"
echo "#   Press "6" to delete row from table         #" 
echo "#   Press "7" to update table                  #"
echo "#   Press "8" to back to the main menu         #"
echo "#                                            #"
echo -e "\033[32m#********************************************#\033[0m"
echo -e "\n"
}

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
ls | grep -v "schema" | grep -v "monitor_file"
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
    read -p " enter the database name : " db_name
    read -p " enter the table name : " table_name

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
     while true  ; do
        read -p "Enter value for column '$column': " value
        if [ -z "$value" ]; then
            echo "Value for column '$column' cannot be empty."
            return 1
        fi
        if [[ ${#value} -gt 15 ]] ; then 
        echo "invalid input please try less than 16 character"       
        continue 
        fi
        if [[ $column == "id" ]] && ! [[ $value =~ ^[0-9]+$ ]]   ; then
        echo "enter integer numbers only in (id) column  please"
        continue 
        fi
        if [[ $column == "name" ]] && ! [[ $value =~ ^[a-zA-Z]+$ ]]   ; then
        echo "enter string characters only in (name) column please"
        continue 
        fi
 #if all inputs are valid
      
           values+=("$value")
        break
        done
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


 # Function to select data into a table
Select_Table()
{
    read -p " enter the database name : " db_name
    read -p " enter the table name : " table_name

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

    # Print the header
    header="+"
    header_line="|"
    for col in "${columns[@]}"; do
        header+=$(printf '%-12s+' "------------")
        header_line+=$(printf ' %-11s |' "$col")
    done
    echo "$header"
    echo "$header_line"
    echo "$header"

    # Print the data rows
    table_file="/home/ebrahim/Databases/$db_name/$table_name"
    if [ ! -f "$table_file" ]; then
        echo "Table '$table_name' is empty."
        return 1
    fi

    awk -F '|' -v header="$header" -v columns="${columns[*]}" '
    BEGIN {
        split(columns, col_array, " ")
    }
    {
        row="|"
        for (i=2; i<=NF-1; i++) {
            row = row sprintf(" %-11s |", $i)
        }
        print row
    }
    END {
        print header
    }' "$table_file"
}



# Function to delete a row from a table
delete_row_from_table() {
    read -p " enter the database name : " db_name
    read -p " enter the table name : " table_name

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

    # Display columns and prompt the user to select a column
    echo "Available columns:"
    for col in "${columns[@]}"; do
        echo "$col"
    done

    read -p "Enter the column name to use for deletion: " column_name

    # Check if the entered column name is valid
    if [[ ! " ${columns[@]} " =~ " $column_name " ]]; then
        echo "Invalid column name."
        return 1
    fi

    read -p "Enter the value of the row to delete: " value_to_delete

    # File paths
    table_file="/home/ebrahim/Databases/$db_name/$table_name"
    temp_file=$(mktemp)

    # Delete the row from the table file
    awk -F '|' -v col="$column_name" -v val="$value_to_delete" -v columns="${columns[*]}" '
    BEGIN {
        split(columns, col_array, " ")
        for (i in col_array) {
            if (col_array[i] == col) {
                target_col = i + 1
                break
            }
        }
    }
    {
        if ($target_col !~ val) {
            print $0 > FILENAME".temp"
        } else {
            deleted=1
        }
    }
    END {
        if (deleted) {
            print "Row deleted successfully."
        } else {
            print "No matching row found."
        }
    }' "$table_file"

    # Replace the original file with the updated file if a row was deleted
    if [ -f "$table_file.temp" ]; then
        mv "$table_file.temp" "$table_file"
    fi
}



# Function to update data in a table
Update_Table()
{
    read -p " enter the database name : " db_name
    read -p " enter the table name : " table_name

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

    # Display columns and prompt the user to select a column to search
    echo "Available columns:"
    for col in "${columns[@]}"; do
        echo "$col"
    done

    read -p "Enter the column name to search: " column_name

    # Check if the entered column name is valid
    if [[ ! " ${columns[@]} " =~ " $column_name " ]]; then
        echo "Invalid column name."
        return 1
    fi

    read -p "Enter the value to search for: " search_value

    # Prompt the user for the new values for each column
    declare -A new_values
    for col in "${columns[@]}"; do
        read -p "Enter new value for column '$col' (leave empty to keep current value): " new_value
        new_values["$col"]=$new_value
    done

    # File paths
    table_file="/home/ebrahim/Databases/$db_name/$table_name"
    temp_file=$(mktemp)

    # Update the table file
    awk -F '|' -v col="$column_name" -v val="$search_value" -v columns="${columns[*]}" '
    BEGIN {
        split(columns, col_array, " ")
        for (i in col_array) {
            if (col_array[i] == col) {
                target_col = i + 1
                break
            }
        }
    }
    {
        # Check if the value in the target column matches the search value
        if ($target_col ~ val) {
            for (i = 2; i <= NF-1; i++) {
                col_name = col_array[i-1]
                new_val = ENVIRON["new_"col_name]
                if (new_val != "") {
                    gsub(/^ +| +$/, "", new_val)  # Trim leading/trailing spaces
                    $i = " "new_val" "
                }
            }
            updated=1
        }
        print $0 > FILENAME".temp"
    }
    END {
        if (updated) {
            print "Row(s) updated successfully."
        } else {
            print "No matching row found."
        }
    }' "$table_file" columns="${columns[*]}" $(for col in "${columns[@]}"; do echo "new_$col=${new_values[$col]}"; done)

    # Replace the original file with the updated file if a row was updated
    if [ -f "$table_file.temp" ]; then
        mv "$table_file.temp" "$table_file"
    fi
}




