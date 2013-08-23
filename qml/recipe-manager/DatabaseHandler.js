console.log("Inside DatabaseHandler.js")

//add format method to String object
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
    var recipes = {
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
    var recipe_id = tableModel.appendRecord(recipes)

    console.log("DATABASEHANDLER.addRecipeToTableModel(): recipeID: " + recipe_id)

    //date for ingredients table
    var ingredients = {
        "tableName": "ingredients",
        "fields":{
            "ingredient": "",
            "recipe_id": recipe_id
        }
    }
    //add ingredients to ingredients table
    for(var i = 0; i < recipe.ingredients.length; i++){
        ingredients.fields["ingredient"] = recipe.ingredients[i]
        tableModel.appendRecord(ingredients)
    }
    //data for categories table
    var categories = {
        "tableName": "categories",
        "fields":{
            "name": ""
        }
    }
    //holds categories ids for many-many relationship table with recipe
    var categoriesId = []

    var id = -1;
    //add categories to categories table
    for(var i = 0; i<recipe.categories.length; i++){
        categories.fields["name"] = recipe.categories[i]

        console.log("DATABASEHANDLER.addRecipeToTable(): category name: " + categories.fields.name)
        id = tableModel.rowIdOf(categories.tableName, "id", "name", categories.fields.name)
        console.log("DATABASEHANDLER.addRecipeToTable(): category id: " + id)

        //check if row exists with that category name already
        if(id < 0)
             id = tableModel.appendRecord(categories) //add new category
        categoriesId.push(id)
    }

    //many-many relationship data
    var categories_recipes = {
        "tableName": "categories_recipes",
        "fields":{
            "recipe_id": recipe_id,
            "category_id": null
        }
    }

    //add many-to-many relationship to database
    for(var i = 0; i < categoriesId.length; i++){
        categories_recipes.fields["category_id"] = categoriesId[i]
        tableModel.appendRecord(categories_recipes)
    }
}

//updates recipe model by a given category id
//recipeModel = model to interact with the recipes table in database
//id = category id
function updateRecipeModelByCategory(recipeModel, id){
    console.log("DATABASEHANDLER.updateRecipeModelByCategory()")

    var query = null

    //regex to use for formating string
    String.prototype.format.regex = new RegExp("{-?[0-9]+}", "g");

    //select all recipes regardless of categories
    if(id  < 0){
        query = "SELECT recipes.id as recipes_id, recipes.title as title, \
                recipes.description, recipes.rating, recipes.difficulty, \
                recipes.image, recipes.created, recipes.updated, recipes.duration, \
                cr.category_id, \
                c.name, \
                i.id as ingredient_id, \
                GROUP_CONCAT(i.ingredient), \
                d.id as directions_id,  \
                GROUP_CONCAT(d.step) \
            from recipes  \
                LEFT OUTER JOIN categories_recipes as cr ON recipes_id=cr.recipe_id  \
                LEFT OUTER JOIN categories as c ON cr.category_id = c.id \
                LEFT OUTER JOIN ingredients as i ON recipes.id = i.recipe_id \
                LEFT OUTER JOIN directions as d ON recipes.id = d.recipe_id \
                GROUP BY recipes.id;"
    }
    //select specific category
    else{
        query =
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
            GROUP BY recipes.id;".format([id.toString()])
    }
   recipeModel.updateQuery(query)
}
