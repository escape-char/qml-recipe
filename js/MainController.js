Qt.include(DatabaseHandler.js);

var MainController = function MainController(window) {
    console.log("MainController.MainController()")

    //components to interact with
    var _window = window;
    var _currentState;
    var _browseLoader = _window.browse;
    var _dialogLoader = _window.dialog;
    var _mainMenu= _window.menu;
    var _currentRecipe; //currently selected recipe
    var _currentCategory; //currently selected category

    //categories currently being displayed
    var _categories;
    //recipes currently being displayed
    var _recipes;

    var t = this; //save this refering to MainController

    //handle menu menu actions
    _mainMenu.addRecipeButtonClick.connect(function(){
        t.loadDialog("recipe");
    });
    _mainMenu.groceriesButtonClick.connect(function(){
        _window.state="GROCERY"
      });
    _mainMenu.settingsButtonClick.connect(function(){
        t.loadDialog("setting")
      });
    _mainMenu.browseButtonClick.connect(function(){
        _window.state="BROWSE"
      });


    //handle browse loader status changes
    _browseLoader.statusChanged.connect(function(){
        if(_browseLoader.status === Loader.Null)
            console.log("MainController.browseLoader.onStatusChanged(): state is currently null")
        else if (browseLoader.status ===- Loader.Error)
            console.log("MainController.browseLoader.onStatusChanged(): error occurred during load")
        else if (browseLoader.status === Loader.Loading)
            console.log("MainController.browseLoader.onStatusChanged(): loading componenet... " +
                        _browseLoader.progress*100 + "%.")
        else{
            console.log("MainController.browseLoader.onStatusChanged(): successfully loaded component")
            console.log("MainController.browseLoader.onStatusChanged(): loaded " + _browseLoader.item.objectName)
            _browseLoader.item.state = "SHOW"

            //handle if its browse view
            if(_browseLoader.item.objectName === "Browse"){
                _browseLoader.item.chosenCategory.connect(function(category){
                    console.log("MainController.browseLoader.onChosenCategory()");
                    //create table Model dynamically
                    var tableModel = Qt.createQmlObject(
                                "import QtQuick 2.0; import Widgets 1.0; SqlQueryModel{}",
                                 _browseLoader.item,
                                "../");

                    console.log("MainController.onCategorySelect(): filter by category id: " + category.id);

                    //Data
                    DatabaseHandler.filterByCategory(tableModel, category.id);
                    _browseLoader.item.update();
                    //goToView()
                });
                 //browseLoader.item.refreshCategories()
                // browseLoader.item.deselectCategories()
                 //browseLoader.item.loadRecipeList()
            }

         }
    });
    //handle status changes for dialog loader
    _dialogLoader.statusChanged.connect(function(){
        if(_dialogLoader.status === Loader.Null){
            console.log("MainController.dialogLoader.onStatusChanged(): state is currently null")
         }
        else if (dialogLoader.status ===- Loader.Error)
            console.log("MainController.dialogLoader.onStatusChanged(): error occurred during load")
        else if (dialogLoader.status === Loader.Loading){
            console.log("MainController.dialogLoader.onStatusChanged(): loading componenet... " +
                        dialogLoader.progress*100 + "%.")
         }
        else{
            console.log("MainController.dialogLoader.onStatusChanged():"
                        + "successfully loaded component");
            console.log("MainController.dialogLoader.onStatusChanged():"
                        + " component objectName is "
                        + dialogLoader.item.objectName);

            dialogLoader.item.state = "SHOW"

            //handle cancel event
            dialogLoader.item.cancelClick.connect(function(){
                console.log("MainController.dialogLoader.cancelClick()");
                t.unloadDialog();
           });
            if(dialogLoader.item.objectName === "RecipeDialog"){
                dialogLoader.item.saveRecipe.connect(function(r){
                    console.log("MainController.dialogLoader.saveRecipe()");
                    t.saveRecipe(r);
                 });
            }
        }
     });
    //save a recipe to database
    this.saveRecipe = function (recipe){
        console.log("MainController.saveRecipe()");
        console.log("\ttitle: " + recipe.title)
         console.log("\trating: " + recipe.rating)
         console.log("\tcategories: " + recipe.categories.toString())
         console.log("\tdescr: " + recipe.description)
         console.log("\tdirections: " + recipe.directions.toString())
         console.log("\tingredients: " + recipe.ingredients.toString())
         console.log("\tduration: " + recipe.duration)
         console.log("\tdifficulty: " + recipe.difficulty)

        var tableModel = Qt.createQmlObject("import QtQuick 2.0; import Widgets 1.0; SqlTableModel{}",
                                            dialogLoader, "./");
        DatabaseHandler.addRecipeToTableModel(tableModel, recipe);
        t.unloadDialog();

        if(browseLoader && browseLoader.status === Loader.Ready){
            var rModel = browseLoader.item.getRecipeQueryModel();
            var cModel = browseLoader.item.getCategoryQueryModel();
            rModel.updateQuery("SELECT * FROM recipes");
            cModel.updateQuery("SELECT * FROM categories");
        }
    }

    //handle state changes for app window
    _window.stateChanged.connect(function(){
        console.log("MainController.appWindow.onStateChanged(): " + _window.state);

        switch(_window.state){
            case "BROWSE":{
                t.loadBrowse();

            }break;
            case "GROCERY":{
                t.loadGrocery();

            }break;
            default:{}
        }
      });
    this.loadBrowse = function(){
        console.log("MainController.loadBrowse()");
        if(_browseLoader){
            _browseLoader.asynchronous = true;
            _browseLoader.source = "../qml/recipe-manager/BrowseView.qml"
        }
    }

    this.loadDialog = function(type){
        console.log("MainController.loadDialog()");

        if(!_dialogLoader){
            console.log("MainController.loadDialog(): dialogLoader is null");
            return;
        }
        _dialogLoader.asynchronous = true;

        if(type === "recipe")
            _dialogLoader.source = "../qml/recipe-manager/RecipeDialog.qml"
        else if (type === "setting")
            _dialogLoader.source = "../qml/recipe-manager/SettingsView.qml"
        else{
            console.log("MainController.loadDialog(): unknown dialog type  " + type);
            return
        }
        console.log("MainController.loadDialog(): Chosen to load Dialog of type " + type)
    }
    this.loadGrocery=function(){
        console.log("MainController.loadGrocery()")
        if(_browseLoader){
            _browseLoader.source = "../qml/recipe-manager/GroceriesView.qml"
        }

    }

    this.unloadBrowse = function(){
        if(_browseLoader){
            _browseLoader.source = "";
        }

    }
    this.unloadDialog = function(){
        if(_dialogLoader){
            _dialogLoader.source = "";
        }

    }

    this.loadRecipeDialog = function(){

    }
}
