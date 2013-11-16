/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

// The Page item is intended for use as a root item in QML items that make
// up pages to use with the PageStack.

import QtQuick 2.0

Item {
    id: root

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    visible: false

    // Signal that fires when the page is being activated.
    signal activating
    
    // Signal that fires when the page has been activated.
    signal activated
    
    // Signal that fires when the page is being deactivated.
    signal deactivating
    
    // Signal that fires when the page has been deactivated.
    signal deactivated

    // Defines the tools for the page; null for none.
    property Item tools: null
}

