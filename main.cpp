#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QtGlobal> //for asserts
#include <QQmlContext> //for setting context for c++ classes and qml
#include <QSqlRecord>
#include <QQmlApplicationEngine>

#include "qtquick2applicationviewer.h"
#include "Headers/database.hpp"
#include "Headers/sqlquerymodel.hpp"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv); //main application

    //this engines allows us to run QtQuickControls
    QQmlApplicationEngine engine;

    QtQuick2ApplicationViewer viewer; //view for handling widgets

    //initialize database
    bool success = databaseHandler::createConnection();
    Q_ASSERT_X(success, "open database connection", "unable to open database");
    success = databaseHandler::createTables();
    success = databaseHandler::create_indices();
    success = databaseHandler::populate(); //populate with data


    //adding models to qml requires two steps
    //1) create instance of new model and set its sql query for the data you want
    //2) set the viewer to use model in its context property.

    //create instance and set query for recipe model
    SqlQueryModel* recipeSqlModel = new SqlQueryModel(qApp);
    recipeSqlModel->setQuery(modelquery::RECIPE_QUERY);

    //set context property to use our model for qml
    //first parameter is what to reference model in qml, second is instance of model
    engine.rootContext()->setContextProperty("recipeModel", recipeSqlModel);

    engine.load(QUrl::fromLocalFile("qml/recipe-manager/main.qml"));

    return app.exec();
}
