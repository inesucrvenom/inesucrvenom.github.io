<?php

class Post
{
    public $id;
    public $title;
    public $summary;
    public $content;
    public $created;

    public static function getBySql($sql)
    {
        try
        {
            // Open database connection
            $database = new Database();

            // Set the error reporting attribute
            $database->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Execute database query
            $statement = $database->query($sql);

            // Fetch results from cursor
            $statement->setFetchMode(PDO::FETCH_CLASS, __CLASS__); //todo: vidim da radi, ne kužim zašto
            $result = $statement->fetchAll();

            // Close database resources
            $database = null;

            // Return results
            return $result;
        }
        catch (PDOException $exception)
        {
            die($exception->getMessage());
        }
    }

    public static function getAll()
    {
        $sql = 'select * from post';
        return self::getBySql($sql);
    }

    public static function getById($id)
    {
        try
        {
            // Open database connection
            $database = new Database();

            // Set the error reporting attribute
            $database->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Build database statement
            $sql = "select * from post where id = :id limit 1";
            $statement = $database->prepare($sql);
            $statement->bindParam(':id', $id, PDO::PARAM_INT);

            // Execute database statement
            $statement->execute();

            // Fetch results from cursor
            $statement->setFetchMode(PDO::FETCH_CLASS, __CLASS__);
            $result = $statement->fetch();

            // Close database resources
            $database = null;

            // Return results
            return $result;
        }
        catch (PDOException $exception)
        {
            die($exception->getMessage());
        }
    }
}