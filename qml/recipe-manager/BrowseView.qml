import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import "StringFormat.js" as QML

SplitView{
    height: parent.height
    width: parent.width
    resizing:true

    //left pane
    Rectangle{
        Layout.minimumWidth:150
        Layout.maximumWidth:200
        CategoryList{
            onCategorySelected:{
                updateRecipeList(category.id)
            }
            onAllSelected: {
                updateRecipeList(-1) //-1 means all categories
            }
        }
    }
    //middle pane
    Rectangle{
        Layout.minimumWidth:300
        Layout.maximumWidth:400
        RecipeList{id:recipeList}
    }

    //right pane
    Rectangle{
        id: recipePane

        property variant currentRecipe

        signal recipeChanged()

        color: "lightgray"
        height:parent.height;
        Layout.minimumWidth: 300
        Layout.fillWidth: true

        RecipeItem {
            id: recipeItem
            onLoaded: {
                recipeItem.recipe = recipePane.currentRecipe
            }
        }

        onCurrentRecipeChanged: {
            recipeItem.recipe = recipePane.currentRecipe
        }
    }
    states: [
        State {
            name: "SHOW"
            PropertyChanges {
            }
        },
        State {
            name: "HIDE"
            PropertyChanges {
            }
        }
    ]
    function updateRecipeList(id){
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
                INNER JOIN ingredients as i ON recipes.id = i.recipe_id \
                INNER JOIN directions as d ON recipes.id = d.recipe_id \
                GROUP BY recipes.id;".format([id.toString()])
        }
       recipeModel.updateQuery(query) //update recipeModel based on category selection
    }
}
