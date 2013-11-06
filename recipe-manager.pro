# Add more folders to ship with the application, here
folder_01.source = qml/recipe-manager
folder_01.target = qml
folder_02.source = images/
DEPLOYMENTFOLDERS += folder_01 \
                     folder_02


# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

#header files for project
HEADERS += \
    Headers/database.hpp \
    Headers/sqlquerymodel.hpp \
    sqltablemodel.hpp \
    Headers/rating.hpp

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    sqlquerymodel.cpp \
    sqltablemodel.cpp \
    rating.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    100x100.gif \
    recipe_manager.xml \
    README.md \
    qml/recipe-manager/AddItemView.qml

QT += sql widgets

OTHER_FILES +=
