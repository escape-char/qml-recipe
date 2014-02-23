//add format method to String object

var QUERY_ALL_RECIPES = "SELECT * FROM recipes";
var QUERY_ALL_CATEGORIES = "SELECT * FROM CATEGORIES";
var QUERY_FILTER_BY_CATEGORIES =
    "SELECT recipes.id as recipes_id, recipes.title as title,\
        recipes.description, recipes.rating, recipes.difficulty, \
        recipes.image, recipes.created, recipes.updated, recipes.duration, \
        cr.category_id, \
        c.name, \
        i.id as ingredient_id, \
        GROUP_CONCAT(i.ingredient), \
        d.id as directions_id, \
        GROUP_CONCAT(d.step) \
       FROM recipes \
    INNER JOIN categories_recipes as cr ON recipes_id=cr.recipe_id \
    INNER JOIN categories as c ON cr.category_id={0} \
    LEFT OUTER JOIN ingredients as i ON recipes.id = i.recipe_id \
    LEFT OUTER JOIN directions as d ON recipes.id = d.recipe_id \
    GROUP BY recipes.id";
String.prototype.format = function (args) {
    var str = this;
    return str.replace(String.prototype.format.regex, function(item) {
        var intVal = parseInt(item.substring(1, item.length - 1));
        var replace;
        if (intVal >= 0) {
            replace = args[intVal];
        } else if (intVal === -1) {
            replace = "{";
        } else if (intVal === -2) {
            replace = "}";
        } else {
            replace = "";
        }
        return replace;
    });
};

//add recipe to database
//tableModel = model to interact with tables in database
//recipe = data to put into database
function addRecipeToTableModel(tableModel, recipe){
    console.log("DATABASEHANDLER.addRecipeToTableModel()")

    //record to add to recipes table
    var recipeRecord= {
        "tableName": "recipes",
        "fields":{
            "title": recipe.title,
            "description": recipe.description,
            "image": recipe.image,
            "duration": recipe.duration,
            "difficulty": recipe.difficulty,
            "rating": recipe.rating
        }
    }
    //add recipe record to table
    //and get the rowid of new record
    var recipe_id = tableModel.appendRecord(recipeRecord)

    console.log("DATABASEHANDLER.addRecipeToTableModel(): recipeID: " + recipe_id)

    //data for ingredients table
    var ingredientRecord = {
        "tableName": "ingredients",
        "fields":{
            "ingredient": "",
            "recipe_id": recipe_id
        }
    }
    //add ingredients to ingredients table
    for(var i = 0; i < recipe.ingredients.length; i++){
        ingredientRecord.fields["ingredient"] = recipe.ingredients[i]
        tableModel.appendRecord(ingredientRecord)
    }
    //data for categories table
    var categoryRecord = {
        "tableName": "categories",
        "fields":{
            "name": ""
        }
    }
    //holds category ids for many-many relationship table with recipe
    var categoryIdList = []

    var id = -1;
    //add categories to categories table
    for(var i = 0; i<recipe.categories.length; i++){
        categoryRecord.fields["name"] = recipe.categories[i]

        console.log("DATABASEHANDLER.addRecipeToTable(): category name: " + categoryRecord.fields.name)
        id = tableModel.rowIdOf(categoryRecord.tableName, "id", "name", categoryRecord.fields.name)
        console.log("DATABASEHANDLER.addRecipeToTable(): category id: " + id)

        //check if row exists with that category name already
        if(id < 0)
             id = tableModel.appendRecord(categoryRecord) //add new category
        categoryIdList.push(id)
    }

    //many-many relationship data
    var categoriesRecipesRecord = {
        "tableName": "categories_recipes",
        "fields":{
            "recipe_id": recipe_id,
            "category_id": null
        }
    }
    //add many-to-many relationship to database
    for(var i = 0; i < categoryIdList.length; i++){
        categoriesRecipesRecord.fields["category_id"] = categoryIdList[i]
        tableModel.appendRecord(categoriesRecipesRecord)
    }
    //record for direction
    var directionRecord = {
        "tableName": "directions",
        "fields": {
            "step": "",
            "recipe_id": recipe_id
        }

    }
    //add direction to database
    for(var i = 0; i < recipe.directions.length; i++){
        directionRecord.fields["step"] = recipe.directions[i]
        tableModel.appendRecord(directionRecord)
    }
}

//filters recipes by a category
//queryModel = SqlQueryModel to interact with database
//id = category id to filter by
function filterByCategory(queryModel, id){
    console.log("DatabaseHandler.filterByCategory()")

    var query = null; //query to filter database

    //regex to use for formating string
    String.prototype.format.regex = new RegExp("{-?[0-9]+}", "g");

    var placeHolder = ""; //placeholder for query

    //select all
    if(!id || id < 0){
        placeHolder = "cr.id"
    }
    //filter by category id
    else{
        placeHolder = id.toString()
    }

    query = QUERY_FILTER_BY_CATEGORIES.format([placeHolder])
   queryModel.updateQuery(query)
}
