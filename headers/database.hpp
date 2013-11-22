#ifndef DATABASE_H
#define DATABASE_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include<QDebug>
#include <iostream>

//handles database connection and initialization
class databaseHandler {
public:
    //name of database
    #define DATABASE_NAME  "recipe-manager.db"

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
        bool success = query.exec(
            "CREATE TABLE IF NOT EXISTS ingredients( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "ingredient VARCHAR(60) NOT NULL DEFAULT \"\", "
                "recipe_id INT, "
                "FOREIGN KEY(recipe_id) REFERENCES recipes(id) "
            ");"
        );
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create ingredients table -> " << query.lastError() ; return false;}

        success = query.exec(
            "CREATE TABLE IF NOT EXISTS categories( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name VARCHAR(100) UNIQUE  DEFAULT \"\""
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create categories table" << query.lastError().text(); return false;}
        success = query.exec(
            "CREATE TABLE IF NOT EXISTS directions( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "step VARCHAR(100) DEFAULT \"\", "
                "recipe_id INT, "
                "FOREIGN KEY(recipe_id) REFERENCES recipes(id) "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create directions table"; query.lastError().text();return false;}

        success = query.exec (
            "CREATE TABLE IF NOT EXISTS categories_recipes("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "category_id INTEGER, "
                "recipe_id INTEGER, "
                "FOREIGN KEY(category_id) REFERENCES recipes(id), "
               " FOREIGN KEY(recipe_id) REFERENCES categories(id) "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create categories_recipes table"; return false;}

        success = query.exec(
            "CREATE TABLE IF NOT EXISTS recipes( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title VARCHAR(155) NOT NULL DEFAULT \"\","
                "description TEST NOT NULL DEFAULT \"\","
                "difficulty SMALLINT DEFAULT 0,  "
                "rating SMALLINT DEFAULT 0, "
                "created DATE DEFAULT CURRENT_DATE,  "
                "updated DATE DEFAULT CURRENT_DATE,  "
                "duration STRING NOT NULL DEFAULT \"0:0\", "
                "image VARCHAR(155) NOT NULL DEFAULT \"\" "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create recipes table"; return false;}

        return true;
    }
    static bool create_indices(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME); //get database

        //not a valid driver for db
        if(!db.isValid()){
            std::cerr << Q_FUNC_INFO << "Invalid connection name / driver for database" << std::endl;
            return false;
        }
        QSqlQuery query; //performs query

        bool ok = query.exec("CREATE INDEX IF NOT EXISTS recipes_index ON recipes(title);");
        if(!ok){qDebug() << Q_FUNC_INFO << ": failed to create recipes table indexi => " << query.lastError(); return false;}

        ok = query.exec("CREATE INDEX IF NOT EXISTS ingredients_index"
                          " ON ingredients(recipe_id, ingredient);") && ok;
        if(!ok){qDebug() << Q_FUNC_INFO << ": failed to create ingredients table index"; return false;}

        ok = query.exec("CREATE INDEX IF NOT EXISTS categories_index ON categories(name);") && ok;
        if(!ok){qDebug() << Q_FUNC_INFO << ": failed to create categories table index"; return false;}

        ok = query.exec("CREATE INDEX IF NOT EXISTS directions_index ON directions(recipe_id, step);") && ok;
        if(!ok){qDebug() << Q_FUNC_INFO << ": failed to create direction table index"; return false;}

        ok = query.exec("CREATE INDEX IF NOT EXISTS cat_recip_index ON "
                        "categories_recipes(recipe_id, category_id);") && ok;
        if(!ok){qDebug() << Q_FUNC_INFO << ": failed to create cat_recip table index"; return false;}

        return true;
    }
    static void close(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME, false);
        //close open connection
        if(db.isOpen()){db.close();}
    }
};

#endif //DATABASEk_H
