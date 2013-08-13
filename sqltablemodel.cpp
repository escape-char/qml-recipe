#include <QtGlobal>
#include <QDebug>
#include <QSqlField>
#include <QSqlRecord>
#include<QSqlError>
#include <QMapIterator>
#include <QMap>
#include "sqltablemodel.hpp"

SqlTableModel::SqlTableModel(QObject* parent)
        : QSqlTableModel(parent){

}

bool SqlTableModel::appendRecord(QVariant data){
    qDebug() << Q_FUNC_INFO;
    //data must be of type QMap
    if(!data.canConvert(QVariant::Map)){
         qDebug() << Q_FUNC_INFO << "expect record of type 'QMap' instead got type " << data.typeName();
        return false;
    }
    
    QMap<QString, QVariant> recordMap = data.toMap();

    //data must have 'tableName' key with value of type QString
    if(!recordMap.contains("tableName")){qDebug() << Q_FUNC_INFO << " record does not contain 'tableName' key"; return false;}
    if(!recordMap["tableName"].canConvert(QVariant::String)){qDebug() << Q_FUNC_INFO << "data's 'tableName' value must be of type QString"; return false;}

    //data must have 'fields' key with value of type QMap
    if(!recordMap.contains("fields")){qDebug() << Q_FUNC_INFO << " record does not contain 'fields' key"; return false;}
    if(!recordMap["fields"].canConvert(QVariant::Map)){qDebug() << Q_FUNC_INFO << "data's 'fields' value must be of type QMap"; return false;}

    QString tName = recordMap["tableName"].toString();
    this->setTable(tName);

    //record to append to table
    QSqlRecord r;

    //fields for the record
    QMapIterator<QString, QVariant> iter(recordMap["fields"].toMap());

    //keep appending fields from data to record
    while(iter.hasNext()){
         iter.next();
         qDebug() <<  Q_FUNC_INFO << "adding key " << iter.key() << "with value of type " << iter.value().typeName();

        //append fields to record
        QSqlField field(iter.key(), iter.value().type());
        field.setValue(iter.value());
        r.append(field);
    }
    //append record to end of table
    this->insertRecord(-1, r);

    //check if there was any errors
    if(QSqlTableModel::lastError().isValid()){
        qDebug() << Q_FUNC_INFO << QSqlTableModel::lastError();
        return false;
    }
    return true;
}
