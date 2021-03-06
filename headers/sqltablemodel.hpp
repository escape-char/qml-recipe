#ifndef SQLTABLEMODEL_H
#define SQLTABLEMODEL_H
#include<QSqlTableModel>
#include<QVariant>

//class for manipulating tables
//use this table for adding/removing rows to tables
class SqlTableModel: public QSqlTableModel{
    Q_OBJECT
public:
   explicit SqlTableModel(QObject* parent = 0);
   
   //appends new row at the end of the table
    //data = QMap containing 'tableName' and 'fields' keys, where fields is also a QMap
    //returns rowID if successful, -1 otherwise
   Q_INVOKABLE int appendRecord(QVariant data);

   //finds record with a given field value in table
    //if multiple records are found, first occurence is returned
    //returns rowID if fieldValue if found, -1 otherwise
   Q_INVOKABLE int rowIdOf(QString tableName, QString idField, QString fieldName, QVariant value);

    //remove row from table
    //tableName = name of table to remove record
    //fieldName = Name to look for deleting rows
    //fieldValue = value which field must have for record to be delted
   Q_INVOKABLE bool removeRecord(QString tableName, QString fieldName, QVariant fieldValue);

};
#endif //SQLTABLEMODEL
