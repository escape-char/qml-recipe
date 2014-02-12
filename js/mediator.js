Qt.include(DatabaseHandler.js);

var Mediator = function Mediator(window) {

    console.log("Mediator.Mediator()")

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

    var t = this; //save this refering to mediator

    //handle menu menu actions
    _mainMenu.addRecipeButtonClick.connect(function(){
        console.log("inside add recipe click")
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
    browseLoader.statusChanged.connect(function(){
        if(_browseLoader.status === Loader.Null)
            console.log("Mediator.browseLoader.onStatusChanged(): state is currently null")
        else if (browseLoader.status ===- Loader.Error)
            console.log("Mediator.browseLoader.onStatusChanged(): error occurred during load")
        else if (browseLoader.status === Loader.Loading)
            console.log("Mediator.browseLoader.onStatusChanged(): loading componenet... " +
                        _browseLoader.progress*100 + "%.")
        else {
            console.log("Mediator.browseLoader.onStatusChanged(): successfully loaded component")
            console.log("Mediator.browseLoader.onStatusChanged(): loaded " + _browseLoader.item.objectName)
            _browseLoader.item.state = "SHOW"

            //handle if its browse view
            if(_browseLoader.item.objectName === "Browse"){
                _browseLoader.item.chosenCategory.connect(function(){
                    console.log("Mediator.browseLoader.onChosenCategory()");
                 });
                //  browseLoader.item.refreshCategories()
                // browseLoader.item.deselectCategories()
                 //browseLoader.item.loadRecipeList()
            }

         }
    });


    //handle status changes for dialog loader
    _dialogLoader.statusChanged.connect(function(){

        if(_dialogLoader.status === Loader.Null){
            console.log("Mediator.dialogLoader.onStatusChanged(): state is currently null")
         }
        else if (dialogLoader.status ===- Loader.Error)
            console.log("Mediator.dialogLoader.onStatusChanged(): error occurred during load")
        else if (dialogLoader.status === Loader.Loading){
            console.log("Mediator.dialogLoader.onStatusChanged(): loading componenet... " +
                        dialogLoader.progress*100 + "%.")
         }
        else{
            console.log("Mediator.dialogLoader.onStatusChanged():"
                        + "successfully loaded component");
            console.log("Mediator.dialogLoader.onStatusChanged():"
                        + " component objectName is "
                        + dialogLoader.item.objectName);

            dialogLoader.item.state = "SHOW"

            //handle cancel event
            dialogLoader.item.cancelClick.connect(function(){
                console.log("Mediator.dialogLoader.cancelClick()");
                t.unloadDialog();
           });
            if(dialogLoader.item.objectName === "RecipeDialog"){
                dialogLoader.item.saveRecipe.connect(function(recipe){
                    console.log("Mediator.dialogLoader.saveRecipe()");
                    t.saveRecipe(recipe);
                 });
            }
        }
     });
    //save a recipe to database
    this.saveRecipe = function (recipe){
        console.log("Mediator.saveRecipe()");
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
        DatabaseHandler.addRecipeToTableModel(tableModel, recipe)
        t.unloadDialog();
    }

    //handle state changes for app window
    _window.stateChanged.connect(function(){
        console.log("Mediator.appWindow.onStateChanged(): " + _window.state);

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
        console.log("Mediator.loadBrowse()");
        if(_browseLoader){
            _browseLoader.asynchronous = true;
            _browseLoader.source = "../qml/recipe-manager/BrowseView.qml"
        }
    }

    this.loadDialog = function(type){
        console.log("Mediator.loadDialog()");

        if(!_dialogLoader){
            console.log("Mediator.loadDialog(): dialogLoader is null");
            return;
        }
        _dialogLoader.asynchronous = true;

        if(type === "recipe") {
             console.log("Type equals recipe");
            _dialogLoader.source = "../qml/recipe-manager/RecipeDialog.qml";
        }
        else if (type === "setting")
            _dialogLoader.source = "../qml/recipe-manager/SettingsView.qml"
        else{
            console.log("Mediator.loadDialog(): unknown dialog type  " + type);
            return
        }
        console.log("Mediator.loadDialog(): Chosen to load Dialog of type " + type)
    }
    this.loadGrocery=function(){
        console.log("Mediator.loadGrocery()")
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
}
