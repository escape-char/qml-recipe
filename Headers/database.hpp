#ifndef DATABASE_H
#define DATABASE_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include<QDebug>
#include <iostream>

//handles database connection and initialization
namespace databaseHandler {
    //name of database
    #define DATABASE_NAME  "recipemanager"

   //database type
    #define CONNECTION_TYPE "QSQLITE"

    //default connection name. If you use this default, Qt will automatically use this connection
    //if you change it, you must provide the connection name for each database transaction
    #define CONNECTION_NAME "qt_sql_default_connection"

    //put queries to create tables here
    #define  RECIPES_QUERY "CREATE TABLE IF NOT EXISTS recipes(id INTEGER PRIMARY KEY autoincrement, name VARCHAR(100) NOT NULL, description text, difficulty VARCHAR(20), timestamp VARCHAR(10))"
    #define  INGREDIENTS_QUERY "CREATE TABLE  IF NOT EXISTS ingredients(id INTEGER PRIMARY KEY autoincrement, requirement TEXT NOT NULL, recipe INT, FOREIGN KEY(recipe) REFERENCES recipes(id))"
    #define  DIRECTIONS_QUERY "CREATE TABLE IF NOT EXISTS directions(id INTEGER PRIMARY KEY autoincrement, step TEXT NOT NULL, recipe INT, FOREIGN KEY(recipe), REFERENCES recipes(id))"

    static bool createConnection(){
        //add sqlite database to qt
        QSqlDatabase db = QSqlDatabase::addDatabase(CONNECTION_TYPE, CONNECTION_NAME);
        db.setDatabaseName(DATABASE_NAME);
        db.setConnectOptions("foreign_keys=ON");

        //failed to open database
        if(!db.open()){
            std::cerr << "Failed to open Sqlite database. Make sure you have sqlite installed" << std::endl;
            return false;
        }
        return true;
    }
    static bool createTables(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME); //get database

        //not a valid driver for db
        if(!db.isValid()){
            std::cerr << Q_FUNC_INFO << "Invalid connection name / driver for database" << std::endl;
            return false;
        }

        //start queries to create tables
        QSqlQuery query; //performs query
        bool success = query.exec(DIRECTIONS_QUERY);
        success = query.exec(INGREDIENTS_QUERY) && success;
        success = query.exec(RECIPES_QUERY) && success;

        //one of the queries failed
        if(!success){
            QSqlError error = query.lastError();
            qDebug()<< Q_FUNC_INFO <<  " Queries to create table failed: " << error.text();
            return false;
        }

        return true;
    }
    //populate database with dummy data
    static bool dummyData(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME); //get database

        //not a valid driver for db
        if(!db.isValid()){
            std::cerr << Q_FUNC_INFO << "Invalid connection name / driver for database" << std::endl;
            return false;
        }
        QSqlQuery query;

        bool ok = query.prepare("INSERT INTO recipes(id, name, description, difficulty, timestamp) "
                                               "VALUES (:id, :name, :description, :difficulty, :timestamp)");
        //prepare query failed
        if(!ok){
            qDebug() << Q_FUNC_INFO << ": preparing query: " << query.lastError().text();
            return false;
        }

        //bind data to record
        query.bindValue(":name", "testing");
        query.bindValue(":description", "testing description");
        query.bindValue(":difficulty", "easy");
        query.bindValue(":timestamp", "now");
        query.bindValue(":id", query.lastInsertId());

        //execution of query failed
        if(!query.exec()){
            qDebug() << Q_FUNC_INFO << "executing query: " << query.lastError().text();
            return false;
        }
        query.exec("SELECT * FROM recipes");
        return true;
    }
    static void close(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME, false);
        //close open connection
        if(db.isOpen()){db.close();}
    }
}

#endif //DATABASEk_H
