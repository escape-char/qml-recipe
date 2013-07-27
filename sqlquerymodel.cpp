#include <QDebug>
#include <QSqlRecord>
#include <QSqlError>
#include <QVariant>
#include <iostream>

 #include "Headers/sqlquerymodel.hpp"

SqlQueryModel::SqlQueryModel(QObject *parent)
    : QSqlQueryModel(parent){
}
QVariant SqlQueryModel::data(const QModelIndex &index, int role) const{

   //Qt predefined role
   if(role < Qt::UserRole){return  QSqlQueryModel::data(index, role);}

   //use the userRole key to access columns of table
   //the userRole key = role + Qt:UserRole+1
   //simply subtract from role to get column index
   int columnIndex = role - Qt::UserRole - 1;

   //now we have row index and column index needed to get ModelIndex to data
   QModelIndex modelIndex = this->index(index.row(),columnIndex);

   //get data using display role, which means the data will be rendered as text
   return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}
void SqlQueryModel::generateRoleNames(){
    _roles.clear();
    for(int i = 0; i < this->record().count(); i++){
        //start assigning roles from Qt UserRole and onward
        //each column name is a role
         this->_roles[Qt::UserRole + i + 1] = QVariant(this->record().fieldName(i)).toByteArray();
    }
}
QHash<int, QByteArray> SqlQueryModel::roleNames() const{
    return _roles;
}
void SqlQueryModel::setQuery(const QString &query, const QSqlDatabase &db)
{
    QSqlQueryModel::setQuery(query,db);

    //error performing query
    if(QSqlQueryModel::lastError().isValid()){
        qDebug() << Q_FUNC_INFO << QSqlQueryModel::lastError();
    }
    //update roles based on query
    generateRoleNames();
}

void SqlQueryModel::setQuery(const QSqlQuery & query)
{
    QSqlQueryModel::setQuery(query);

    //error performing query
    if(QSqlQueryModel::lastError().isValid()){
        qDebug() << Q_FUNC_INFO << QSqlQueryModel::lastError();
    }
    //update role based on query
    generateRoleNames();
}
