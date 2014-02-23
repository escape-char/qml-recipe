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
    _recipeConciseList.sqlModel = _recQueryModel
    _recipeDetailedList.sqlModel = _recQueryModel

    var filterRecipesByCategory = function(catId){
        console.log("BrowseController.filterRecipes()")
        DatabaseHandler.filterByCategory(_recQueryModel, catId);
    }

    //category events
    _categoryList.categorySelect.connect(function(c){
        console.log("BrowseController.categoryList.onCategorySelect()")
        console.log("BrowseController.categoryList.onCategorySelect: category id=" + c.id);
        filterRecipesByCategory(c.id);
    });
    _categoryList.allClick.connect(function(){
        console.log("BrowseController.categoryList.onAllClick()");
        _categoryList.deselect();
        DatabaseHandler.filterByCategory(_recQueryModel, -1); //no filter

    });

    //recipe list events
    _recipeDetailedList.itemClicked.connect(function(d){
        console.log("BrowseController.recipeDetailedList.onItemClicked()");
        console.log(d.id);
        _browseView.push(_recPage);
    });
    _recipeConciseList.backClicked.connect(function(){
        console.log("BrowseController.onBackClicked");
        _browseView.pop();
        _recipeDetailedList.reset();


      })

}
