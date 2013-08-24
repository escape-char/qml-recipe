#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QtGlobal> //for asserts
#include <QQmlContext> //for setting context for c++ classes and qml
#include <QQmlApplicationEngine>

#include "qtquick2applicationviewer.h"
#include "Headers/database.hpp"
#include "Headers/sqlquerymodel.hpp"
#include "Headers/rating.hpp"
#include "sqltablemodel.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv); //main application

    //this engines allows us to run QtQuickControls
    QQmlApplicationEngine engine;

    qmlRegisterType<Rating>("Widgets", 1, 0, "Rating");

    //initialize database
    bool success = databaseHandler::createConnection();
    Q_ASSERT_X(success, "open database connection", "unable to open database");
    success = databaseHandler::createTables();
    success = databaseHandler::create_indices();

    //models to be used in QML
    SqlTableModel* tableModel = new SqlTableModel(qApp);
    SqlQueryModel* recipeSqlModel = new SqlQueryModel(qApp);
    recipeSqlModel->setQuery("SELECT * FROM recipes");
    SqlQueryModel* categorySqlModel = new SqlQueryModel(qApp);
    categorySqlModel->setQuery(modelquery::CATEGORY_QUERY);

    //set models to be usuable in QML
    engine.rootContext()->setContextProperty("recipeModel", recipeSqlModel);
    engine.rootContext()->setContextProperty("categoryModel", categorySqlModel);
    engine.rootContext()->setContextProperty("tableModel", tableModel);

    engine.load(QUrl::fromLocalFile("qml/recipe-manager/main.qml"));

    return app.exec();
}
