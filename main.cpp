#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QtGlobal> //for asserts
#include <QQmlContext> //for setting context for c++ classes and qml
#include <QSqlRecord>
#include "qtquick2applicationviewer.h"
#include "Headers/database.hpp"
#include "Headers/sqlquerymodel.hpp"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv); //main application

    QtQuick2ApplicationViewer viewer; //view for handling widgets

    //start database connection and create table
    bool success = databaseHandler::createConnection();
    Q_ASSERT_X(success, "open database connection", "unable to open database");

    //this may fail because database tables could already be created
    success = databaseHandler::createTables();

    //populate database with dummy data
    if(!databaseHandler::dummyData()){
        qDebug() << "failed to populated database with dummy data";
    }

    //adding models to qml requires two steps
    //1) create instance of new model and set its sql query for the data you want
    //2) set the viewer to use model in its context property.

    //create instance and set query for recipe model
    SqlQueryModel* recipeSqlModel = new SqlQueryModel(qApp);
    recipeSqlModel->setQuery("SELECT * FROM recipes");

    //set context property to use our model for qml
    //first parameter is what to reference model in qml, second is instance of model
    viewer.rootContext()->setContextProperty("recipeModel", recipeSqlModel);

    viewer.setMainQmlFile(QStringLiteral("qml/recipe-manager/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
