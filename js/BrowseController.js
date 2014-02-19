Qt.include(DatabaseHandler.js);

var BrowseController = function func(browseView) {

    var _browseView = browseView;
    var _catPage = browseView.categoriesPage;
    var _recPage = browseView.recipesPage;
    var _categoryList = browseView.categoriesPage.categoryList;


    var _recipeConciseList = _recPage.recipeListView;
    var _recipeDetailedList = _catPage.recipeListView;


    var _catQueryModel = Qt.createQmlObject("import QtQuick 2.0; import Widgets 1.0; SqlQueryModel{}", _browseView, "../");
    _catQueryModel.query = DatabaseHandler.QUERY_ALL_CATEGORIES;
    _catQueryModel.updateQuery(DatabaseHandler.QUERY_ALL_CATEGORIES)

    var _recQueryModel = Qt.createQmlObject("import QtQuick 2.0; import Widgets 1.0; SqlQueryModel{}", _browseView, "../");
    _recQueryModel.query = DatabaseHandler.QUERY_ALL_RECIPES
    _recQueryModel.updateQuery(DatabaseHandler.QUERY_ALL_RECIPES)


    var that = this

    _categoryList.model = _catQueryModel

    console.log("recipeconciselist: " + _recPage)
    _recipeConciseList.model = _recQueryModel
    _recipeDetailedList.model = _recQueryModel

    var filterRecipesByCategory = function(catId){
        console.log("BrowseController.filterRecipes()")
        DatabaseHandler.filterByCategory(_recQueryModel, catId);
    }
    _categoryList.categorySelect.connect(function(c){
        console.log("BrowseController.onCategorySelect()")
        console.log("BrowseController.onCategorySelect: category id=" + c.id);
        filterRecipesByCategory(c.id);
    });

}
