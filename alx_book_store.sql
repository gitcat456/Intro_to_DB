import mysql.connector
from mysql.connector import Error

try:
    # Connect to MySQL server (without specifying database)
    connection = mysql.connector.connect(
        host="localhost",
        user="Astax",
        password="Pt$#523jI"
    )

    if connection.is_connected():
        cursor = connection.cursor()

        # Create database if not exists
        cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
        print("Database 'alx_book_store' created.")

        # Switch to that database
        cursor.execute("USE alx_book_store")

        # Define table creation queries
        table_definitions = [

            """
            CREATE TABLE IF NOT EXISTS Authors (
                author_id INT AUTO_INCREMENT PRIMARY KEY,
                author_name VARCHAR(215)
            )
            """,

            """
            CREATE TABLE IF NOT EXISTS Books (
                book_id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(130),
                author_id INT,
                price DOUBLE,
                publication_date DATE,
                FOREIGN KEY (author_id) REFERENCES Authors(author_id)
            )
            """,

            """
            CREATE TABLE IF NOT EXISTS Customers (
                customer_id INT AUTO_INCREMENT PRIMARY KEY,
                customer_name VARCHAR(215),
                email VARCHAR(215),
                address TEXT
            )
            """,

            """
            CREATE TABLE IF NOT EXISTS Orders (
                order_id INT AUTO_INCREMENT PRIMARY KEY,
                customer_id INT,
                order_date DATE,
                FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
            )
            """,

            """
            CREATE TABLE IF NOT EXISTS Order_Details (
                orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
                order_id INT,
                book_id INT,
                quantity DOUBLE,
                FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                FOREIGN KEY (book_id) REFERENCES Books(book_id)
            )
            """
        ]

        # Execute table creation queries
        for query in table_definitions:
            cursor.execute(query)

        print(" All tables created successfully.")

except Error as err:
    print(f"Error: {err}")

finally:
    if 'cursor' in locals():
        cursor.close()
    if 'connection' in locals() and connection.is_connected():
        connection.close()
        print("MySQL connection closed.")
