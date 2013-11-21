#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QtGlobal> //for asserts
#include <QQmlContext> //for setting context for c++ classes and qml
#include <QQmlApplicationEngine>

#include "qtquick2applicationviewer.h"
#include "headers/database.hpp"
#include "headers/sqlquerymodel.hpp"
#include "headers/rating.hpp"
#include "headers/sqltablemodel.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv); //main application

    //this engines allows us to run QtQuickControls
   QQuickView view;
   view.setResizeMode(QQuickView::SizeRootObjectToView);

    qmlRegisterType<Rating>("Widgets", 1, 0, "Rating");
    qmlRegisterType<SqlQueryModel>("Widgets", 1,0, "SqlQueryModel");
    qmlRegisterType<SqlTableModel>("Widgets", 1,0, "SqlTableModel");


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

    view.setSource(QUrl::fromLocalFile("qml/recipe-manager/main.qml"));
    view.show();

    return app.exec();
}
