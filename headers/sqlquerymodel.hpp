#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <string>
#include <QSqlQueryModel>

namespace modelquery{
    const QString RECIPE_QUERY(
            "SELECT recipes.id AS recipes_id, recipes.title AS title, "
                "recipes.description, recipes.rating, recipes.difficulty, "
                "recipes.image, recipes.created, recipes.updated, recipes.duration, "
                "cr.category_id, "
                "c.name,"
                "i.id as ingredient_id, "
                "GROUP_CONCAT(i.ingredient), "
                "d.id AS directions_id, "
                 "GROUP_CONCAT(d.step) "
            "FROM recipes "
                "LEFT JOIN categories_recipes as cr ON recipes_id=cr.recipe_id "
                "INNER JOIN categories as c ON cr.category_id = c.id "
                "INNER JOIN ingredients as i ON recipes.id = i.recipe_id "
                "INNER JOIN directions as d ON recipes.id = d.recipe_id "
                 "GROUP BY recipes.id;"
    );
    const QString CATEGORY_QUERY("SELECT id, name FROM categories");
}
//class for querying directions model
//this class only performs read only operations
//use QSqlTableModel for manipulating tables
class SqlQueryModel: public QSqlQueryModel {
    Q_OBJECT
    Q_PROPERTY(QString query READ query WRITE changeQuery)


public:
    explicit SqlQueryModel(QObject *parent = 0);


    QString query(){return _query;}

    void changeQuery(QString q){
        _query = q;
        this->setQuery(_query);
    }


    //gets data from a model index and role
    //views use this method to get model's data
    Q_INVOKABLE QVariant data(const QModelIndex &item, int role) const;

    //get role names for view. Qt 5 requires us to override this function
    //views use this method for how to display data
    //this class uses custom userRoles mostly
    virtual QHash<int, QByteArray> roleNames() const;

    //generates role names by adding offset to each column + 1 to Qt:UserRole
    //each column in table will have a UserkaRole
    void generateRoleNames();

    //methods to set query for what data will be retrieved
    //the query must be set first for data() method to work
    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase());
    void setQuery(const QSqlQuery &query);

    Q_INVOKABLE bool updateQuery(QString query);
private:
    //roles for accessing data
    QHash <int, QByteArray> _roles;
    QString _query;
};

#endif //RECIPESQUERYMODEL_H
