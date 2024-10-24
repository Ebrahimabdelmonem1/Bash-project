# Bash Project for Database Management

This project is a Bash Script-based Database Management System (DBMS). It allows users to create, manage, and interact with databases using simple Bash commands. The project simulates basic functionalities of a DBMS and provides a hands-on approach to database management through shell scripting.

## Features

- Create and delete databases.
- Create, update, and delete tables within databases.
- Insert, update, delete, and query records from tables.
- Error handling for invalid inputs and operations.

## Project Structure

```
├── databases/
│   └── [database folders]
├── scripts/
│   ├── create_db.sh
│   ├── drop_db.sh
│   ├── create_table.sh
│   ├── drop_table.sh
│   ├── insert_record.sh
│   ├── update_record.sh
│   ├── delete_record.sh
│   ├── query_records.sh
│   └── main.sh
└── README.md
```

- **databases/**: Contains folders for each database created.
- **scripts/**: Bash scripts to handle different database and table operations.

## Requirements

- **Bash Shell**: Ensure you have Bash installed and running on your system.
- **Permissions**: Ensure that you have proper execution permissions for the Bash scripts (`chmod +x` for the script files).

## Setup and Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/Ebrahimabdelmonem1/Bash-project.git
    cd Bash-project
    ```

2. Run the main script to start interacting with the DBMS:
    ```bash
    ./scripts/main.sh
    ```

3. Follow the on-screen options to perform operations like creating databases, tables, and managing records.

## Example Operations

1. **Create a Database**:
    ```bash
    ./scripts/create_db.sh my_database
    ```

2. **Create a Table**:
    ```bash
    ./scripts/create_table.sh my_database my_table
    ```

3. **Insert a Record**:
    ```bash
    ./scripts/insert_record.sh my_database my_table
    ```

4. **Query Records**:
    ```bash
    ./scripts/query_records.sh my_database my_table
    ```

## Clean-Up

To remove all created databases and tables, simply delete the `databases/` folder or specific databases as needed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
