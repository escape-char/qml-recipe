#ifndef SQLTABLEMODEL_H #define SQLTABLEMODEL_H 
#include<QSqlTableModel>
#include<QVariant>

//class for manipulating tables
//use this table for adding/removing rows to tables
class SqlTableModel: public QSqlTableModel{
    Q_OBJECT
public:
   explicit SqlTableModel(QObject* parent = 0);
   
   //appends new row at the end of the table
    //data should be a QMap containing 'tableName' and 'fields' keys
   Q_INVOKABLE bool appendRecord(QVariant data);

    //remove row from table
    //data should bq a QMap containing 'tableName' and 'id' keys
   //Q_INVOKABLE bool removeRecord(QVariant data);

};
#endif //SQLTABLEMODEL
