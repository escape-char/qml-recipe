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
        bool success = query.exec(
            "CREATE TABLE IF NOT EXISTS ingredients( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "ingredient VARCHAR(60) NOT NULL, "
                "recipe_id INT, "
                "FOREIGN KEY(recipe_id) REFERENCES recipes(id) "
            ");"
        );
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create ingredients table -> " << query.lastError() ; return false;}

        success = query.exec(
            "CREATE TABLE IF NOT EXISTS categories( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "name VARCHAR(100) UNIQUE "
            ");"
        ) && success;
        if(!success){qDebug() << Q_FUNC_INFO << ": failed to create categories table" << query.lastError().text(); return false;}
        success = query.exec(
            "CREATE TABLE IF NOT EXISTS directions( "
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "step TEXT DEFAULT \", \", "
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
    //populate database with dummy data
    static bool populate(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME); //get database

        //not a valid driver for db
        if(!db.isValid()){
            std::cerr << Q_FUNC_INFO << "Invalid connection name / driver for database" << std::endl;
            return false;
        }
        QSqlQuery query;

        //populate recipe table
        bool ok = query.exec(
            "INSERT INTO recipes(title, description, difficulty, rating, duration, image) "
            "VALUES(\"Blueberry Muffin\", \"A delicious muffin only your grandma would like\","
                    "\"hard\", 4, 10, \"random-muffin.jpg\"),"
                "(\"Banana pot pie\", \"Youve had it before. Well here it is again\","
                    "\"impossible\",1, 1, \"pot.jpg\"),"
                "(\"vanilla ice yogurt\", \"perfect for a cool day\", \"doable\","
                    "5, 20, \"yogurt.jpg\"),"
                "(\"tofu ninja sandwich\", \"sometimes getting punched in the face is a good thing\","
                    "\"infinity\", 100, 2, \"invisibleninja.jpg\");"
        );
        if(!ok){qDebug() << " Failed populating recipes: " << query.lastError().text(); return false;}
        //populate recipe table
        ok = query.exec(
            "INSERT INTO recipes(title, description, difficulty, rating, duration, image) "
            "VALUES(\"Blueberry Muffin\", \"A delicious muffin only your grandma would like\","
                    "\"hard\", 4, 10, \"random-muffin.jpg\"),"
                "(\"Banana pot pie\", \"Youve had it before. Well here it is again\","
                    "\"impossible\",1, 1, \"pot.jpg\"),"
                "(\"vanilla ice yogurt\", \"perfect for a cool day\", \"doable\","
                    "5, 20, \"yogurt.jpg\"),"
                "(\"tofu ninja sandwich\", \"sometimes getting punched in the face is a good thing\","
                    "\"infinity\", 100, 2, \"invisibleninja.jpg\");"
        );
        if(!ok){qDebug() << " Failed populating recipes: " << query.lastError().text(); return false;}


        //populate ingredients table
        ok = query.exec(
            "INSERT INTO ingredients(ingredient, recipe_id) "
               "VALUES (\"blueberries\", 1), "
               "(\"flour\", 1), "
                "(\"banana\", 2), "
                " (\"pot\", 2),"
                " (\"pie\", 2),"
                " (\"vanilla extract\", 3),"
                " (\"homemade icecream\", 3),"
                " (\"magic\", 4);"
       );
      if(!ok){qDebug() << " Failed populating ingredients: " << query.lastError().text(); return false;}
      ok = query.exec(
         "INSERT INTO directions(step, recipe_id) "
              "VALUES(\"put the muffin in the microwave and wait patiently\", 1),"
              "(\"when its ready, eat it\", 1),"
              "(\"put the blueberries in the pot\", 2),"
              "(\"put the pot in the pie\", 2),"
              "(\"this is step 1\", 3),"
              "(\"this is step 2\", 3),"
              "(\"this is step 3\", 3),"
              "(\"this is step 1\", 4),"
              "(\"this is step 2\", 4),"
              "(\"this is step 3\", 4);"
      );
      if(!ok){qDebug() << " Failed populating directions: " << query.lastError().text(); return false;}

      //populate categories
      ok = query.exec(
         "INSERT INTO categories(name) "
            "VALUES('fruit'),"
              "('lunch'),"
              "('dessert');"
      );
      if(!ok){qDebug() << " Failed populating categories: " << query.lastError().text(); return false;}

      //populate many-to-many categories_recipes table
      ok = query.exec(
          "INSERT INTO categories_recipes(recipe_id, category_id) "
              "VALUES(1,1),(2,1),(2,2),(4,2),(3,3);"
        );
      if(!ok){qDebug() << " Failed populating categories_recipes: " << query.lastError().text(); return false;}

      return true;
    }
    static void close(){
        QSqlDatabase db = QSqlDatabase::database(CONNECTION_NAME, false);
        //close open connection
        if(db.isOpen()){db.close();}
    }
}

#endif //DATABASEk_H
