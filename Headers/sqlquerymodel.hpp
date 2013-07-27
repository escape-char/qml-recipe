#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <QSqlQueryModel>

//class for querying directions model
//right now it is read-only
//TODO: make it write too
class SqlQueryModel: public QSqlQueryModel {
    Q_OBJECT

public:
    explicit SqlQueryModel(QObject *parent = 0);

    //gets data from a model index and role
    //views use this method to get model's data
    Q_INVOKABLE QVariant data(const QModelIndex &item, int role) const;

    //get role names for view. Qt 5 requires us to override this function
    //views use this method for how to display data
    //this class uses custom userRoles mostly
    virtual QHash<int, QByteArray> roleNames() const;

    //generates role names by adding offset to each column + 1 to Qt:UserRole
    //each column in table will have a UserRole
    void generateRoleNames();

    //methods to set query for what data will be retrieved
    //the query must be set first for data() method to work
    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    void setQuery(const QSqlQuery &query);

private:
    //roles for accessing data
    QHash <int, QByteArray> _roles;
};

#endif //RECIPESQUERYMODEL_H
