<?php


class Database extends PDO
{
    public function __construct($dsn, $username, $passwd, $options)
    {
        try
        {
            // Build PDO data source name for MySQL connection
            $dsn = "mysql:host=".DATABASE_HOST.";dbname=".DATABASE_NAME.";charset=utf8";

            // Open database connection
            parent::__construct($dsn, DATABASE_USER, DATABASE_PASSWORD);
        }
        catch (PDOException $exception)
        {
            die($exception->getMessage());
        }
    }
}