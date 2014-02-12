# Add more folders to ship with the application, here
folder_01.source = qml/
folder_01.target = ./
folder_02.source = images/
folder_03.source = js/
folder_04.source = fonts/
DEPLOYMENTFOLDERS += folder_01 \
                     folder_02 \
                     folder_03 \
                     folder_04


# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

#header files for project
HEADERS += \
    headers/database.hpp \
    headers/sqlquerymodel.hpp \
    headers/sqltablemodel.hpp \
    headers/rating.hpp

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp \
    src/sqlquerymodel.cpp \
    src/sqltablemodel.cpp \
    src/rating.cpp

# Installation path
target.path = ./debug

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    100x100.gif \
    recipe_manager.xml \
    README.md \
    js/MainController.js \
    qml/recipe-manager/RecipeListDetailed.qml \
    qml/recipe-manager/CategoriesPage.qml \
    qml/recipe-manager/RecipesPage.qml \
    qml/recipe-manager/MainMenu.qml

QT += sql widgets

OTHER_FILES +=
