#include <QtGlobal>
#include <QDebug>
#include<QSqlError>
#include <QSqlQuery>
#include <QMapIterator>
#include <QStringList>
#include <QMap>
#include "sqltablemodel.hpp"

SqlTableModel::SqlTableModel(QObject* parent)
        : QSqlTableModel(parent){

}
int SqlTableModel::rowIdOf(QString tableName, QString idField, QString fieldName, QVariant value){
    QSqlQuery query;
    QString statement = QString("SELECT %1 FROM %2 WHERE %3=\"%4\"").arg(idField, tableName,
                                                                     fieldName, value.toString());
    qDebug() << Q_FUNC_INFO << statement;

    bool ok = query.prepare(statement);
    if(!ok){qDebug() << Q_FUNC_INFO << "failed prepare => " << query.lastError(); return -1;}

    ok = query.exec();
    if(!ok){qDebug() << Q_FUNC_INFO << "failed executing statement => " << query.lastError(); return -1;}

   return query.next() ? query.value(0).toInt() : -1;
}

int SqlTableModel::appendRecord(QVariant data){
    qDebug() << Q_FUNC_INFO;

    //data must be of type QMap
    if(!data.canConvert(QVariant::Map)){
         qDebug() << Q_FUNC_INFO << "expect record of type 'QMap' instead got type " << data.typeName();
        return -1;
    }
    
    //get map of what to insert
    QMap<QString, QVariant> recordMap = data.toMap();

    //tableName key is required
    if(!recordMap.contains("tableName")){
        qDebug() << Q_FUNC_INFO << " map is missing key 'tableName'";
        return -1;
    }
    //fields key is required
    if(!recordMap.contains("fields")){
        qDebug() << Q_FUNC_INFO << " map is missing key 'fields'";
        return -1;
    }

    //get the amount of field to insert
    int amountOfFields = recordMap.value("fields").toMap().keys().size();

    //place holder for inserting value
    //every placeholder is the key with a ':' added at the beginning
    QString placeholder = "";
    QString fieldNames = "";

    QString tableName = recordMap.value("tableName").toString(); //table to append data

    //gather fieldnames and placeholders needed for prepare statement
    for(int i = 0; i < amountOfFields; i++){
        placeholder.append(":");
        placeholder.append(recordMap.value("fields").toMap().keys()[i]);

        fieldNames.append(recordMap.value("fields").toMap().keys()[i]);

        //append commas for every placeholder and field name except the last
        if(i != amountOfFields - 1) {
            placeholder.append(", ");
            fieldNames.append(", ");
        }
    }
    QSqlQuery query;
    QString statement = QString("INSERT INTO %1 (%2) VALUES(%3);").arg(tableName, fieldNames, placeholder);
    qDebug() << Q_FUNC_INFO << statement;
    bool ok = query.prepare(statement);

    if(!ok){qDebug() << Q_FUNC_INFO << "failed to prepare sql statement: " << SqlTableModel::lastError();}

    QStringList bindPlaceholder = placeholder.split(",");

    int i = 0;
    //bind the values
    foreach(QVariant value, recordMap.value("fields").toMap().values()){
        query.bindValue(bindPlaceholder[i].trimmed(), value);

        //check for errors
        if(SqlTableModel::lastError().isValid()){
            qDebug() << Q_FUNC_INFO << QString("failed to bind placeholder %1 with type %2").arg(bindPlaceholder[i], value.type());
            return -1;
        }
        i++;
    }
    ok = query.exec();
    qDebug() <<  Q_FUNC_INFO << "EXECUTE QUERY => " << query.executedQuery();

   if(!ok){
       qDebug() << Q_FUNC_INFO << " Failed to execute statement-> " << query.lastError();
       return -1;
    }
    return query.lastInsertId().toInt();//return row ID of newly appended record
}
bool SqlTableModel::removeRecord(const QString tableName, const QString fieldName, const QVariant conditionValue){
   QSqlQuery query; 

   //placeholder for where condition
   QString placeholder = QString(":%1").arg(fieldName);
   //sql statement to prepare
   QString statement = QString("DELETE FROM %1 WHERE %2=%3").arg(tableName, fieldName, placeholder);
   qDebug() << Q_FUNC_INFO << statement;

   //prepare query before bind
   bool ok = query.prepare(statement);
   if(!ok){qDebug() << Q_FUNC_INFO << "could not prepare query => " << query.lastError(); return false;}

   qDebug() << "before BIND";
   //bind value
   query.bindValue(placeholder, conditionValue);
   if(query.lastError().isValid()){qDebug() << Q_FUNC_INFO << "failed bind " << query.lastError(); return false;}
   qDebug() << "before Exec";

   //execute query
   ok = query.exec();
   qDebug() << Q_FUNC_INFO << "EXECUTED QUERY: " << query.executedQuery();
   if(!ok){qDebug() << "failed executing query => " << query.lastError(); return false;}
   qDebug() << "after exec";

   return true;
}
