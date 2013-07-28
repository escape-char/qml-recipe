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

        QSqlQuery query; //performs query
        bool success = query.exec("DROP TABLE IF EXISTS ingredients");
        success = query.exec(
            "CREATE TABLE ingredients( \
                id INTEGER PRIMARY KEY AUTOINCREMENT,\ 
                ingredient VARCHAR(60) NOT NULL, \
                recipe_id INT, \
                FOREIGN KEY(recipe_id) REFERENCES recipes(id) \
            );") && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create ingredients table"; return false;}

        success = query.exec("DROP TABLE if EXISTS categories;");
        success = query.exec(
            "CREATE TABLE categories( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name VARCHAR(100) UNIQUE "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create categories table" << query.lastError().text(); return false;}
        success = query.exec("DROP TABLE IF EXISTS directions;");
        success = query.exec(
            "CREATE TABLE directions( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "step TEXT DEFAULT \", \", "
                "recipe_id INT, "
                "FOREIGN KEY(recipe_id) REFERENCES recipes(id) "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create directions table"; query.lastError().text();return false;}

        success = query.exec("DROP TABLE IF EXISTS categories_recipes;");
        success = query.exec (
            "CREATE TABLE categories_recipes("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "category_id INTEGER, "
                "recipe_id INTEGER, "
                "FOREIGN KEY(category_id) REFERENCES recipes(id), "
               " FOREIGN KEY(recipe_id) REFERENCES categories(id) "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create categories_recipes table"; return false;}

        success = query.exec("DROP TABLE IF EXISTS recipes;");
        success = query.exec(
            "CREATE TABLE recipes( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT,  "
                "title VARCHAR(155) NOT NULL DEFAULT \"\",  "
                "description text DEFAULT \"\",  "
                "difficulty VARCHAR(30) DEFAULT \"\",  "
                "rating SMALLINT, "
                "created DATE DEFAULT CURRENT_DATE,  "
                "updated DATE DEFAULT CURRENT_DATE,  "
                "duration SMALLINT,  "
                "image VARCHAR(155) "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create recipes table"; return false;}

        return true;
    }
    /*
    static bool create_indices(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME); //get database

        //not a valid driver for db
        if(!db.isValid()){
            std::cerr << Q_FUNC_INFO << "Invalid connection name / driver for database" << std::endl;
            return false;
        }
        const QString RECIPES_INDEX( 
            "Begin; \
            DROP INDEX IF EXISTS recipes_index; \
            CREATE INDEX recipes_index ON recipes(title); \
            COMMIT;"
        );
        const QString INGREDIENTS_INDEX ( 
            "BEGIN; \
            DROP INDEX IF EXISTS ingredients_index; \ 
            CREATE INDEX ingredients_index ON ingredients(recipe_id, ingredient); \
            COMMIT;"
        );
        const QString CATEGORIES_INDEX ( 
            "BEGIN;\
            DROP INDEX IF EXISTS categories_index; \
            CREATE INDEX categories_index ON categories(name); \
            COMMIT;"
        );
        const QString DIRECTIONS_INDEX ( 
            "BEGIN;\
            DROP INDEX IF EXISTS directions_index; \
            CREATE INDEX directions_index ON directions(recipe_id, step); \
            COMMIT;"
        );
        const QString CAT_RECIP_INDEX(
            "BEGIN;\
            DROP INDEX IF EXISTS cat_recip_index; \ 
            CREATE INDEX cat_recip_index ON categories_recipes(recipe_id, category_id); \
            COMMIT;"
        );
        //start queries to create tables
        QSqlQuery query; //performs query
        bool success = query.exec(DIRECTIONS_INDEX);
        success = query.exec(CATEGORIES_INDEX) && success;
        success = query.exec(INGREDIENTS_INDEX) && success;
        success = query.exec(CAT_RECIP_INDEX) && success;
        success = query.exec(RECIPES_INDEX) && success;

        //one of the queries failed
        if(!success){
            QSqlError error = query.lastError();
            qDebug()<< Q_FUNC_INFO <<  " Queries to create table failed: " << error.text();
            return false;
        }

        return true;
    }
*/
    //populate database with dummy data
    static bool populate(){
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
