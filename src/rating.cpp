#include <QDebug>
#include <QPoint>
#include <QPainterPath>
#include<QPainter>
#include<QBrush>
#include<QRect>
#include <cmath>
#include "headers/rating.hpp"

Rating::Rating(QQuickItem* parent):
    QQuickPaintedItem(parent){
    this->setAcceptHoverEvents(true);
    this->setAcceptedMouseButtons(Qt::LeftButton);
    this->_selected = NONE;
    this->_hover=NONE;
    this->_size = 10;
    this->_spacing = 10;
    this->_fillColor = "#bbb";
    this->_strokeColor = this->_fillColor;

    this->setKeepMouseGrab(false);
}
void Rating::paint(QPainter *painter){
    //qDebug() << Q_FUNC_INFO;

    const int totalStars = 5;

    float angle = (2*M_PI) / 10;

    float radius = _size;

    float center[2] = {2*_size, _size};

    float offset = 2*radius + _spacing;

    //star to draw
    QPainterPath path;

    QBrush brush(_fillColor);
    QPen pen(_strokeColor);

    painter->setPen(pen);

    //outter loop to draw five stars
    for(int star = 1; star <= totalStars; star++){
        //rectangle that will surround each star
        //used to detect if mouse is at a star
        QRect boundingRect;
        boundingRect.moveTo(center[0] - radius, center[1] - radius);
        boundingRect.setSize(QSize(2* radius + _spacing, 2*radius));

        //star bounding rectangle for each star
        this->starRect[star - 1] = boundingRect;

        //draw lines for star
        for(int i = 0; i !=11; i++){
            float r = radius*(i % 2 + 1) / 2;
            float nextAngle = angle * i;

            //next point to draw line to
            int dx = (int) (r* sin(nextAngle) + center[0]);
            int dy = (int) (r* cos(nextAngle) + center[1]);
            if(i == 0){path.moveTo(dx, dy);}

            path.lineTo(dx, dy);
        }

        pen.setColor(_strokeColor);

        //paint star gold if hover or clicked on it
        if(_hover > 0 && star <= this->_hover ||
            star <=_selected && _hover == 0){

            brush.setColor(_fillColor);
        }
        //star is transparent
        else{
            brush.setColor("transparent");
        }
        painter->fillPath(path, brush);
        painter->drawPath(path);
        center[0] = center[0] + offset;

        path.moveTo(center[0], center[1]);

    }
}
Rating::Type Rating::getBoundedStar(QPoint point){
    for(int i=0; i < 5; i++){
        if(!this->starRect[i].isValid()){continue;}

        if(starRect[i].contains(point)){
          return Type(i + 1);
        }
    }
    return NONE;
}
void Rating::mousePressEvent(QMouseEvent *event){
    qDebug() << Q_FUNC_INFO;

    Type type = getBoundedStar(event->pos());
    this->_hover = NONE;
    this->_selected = type;
    this->update();

}
void Rating::hoverMoveEvent(QHoverEvent *event){
    qDebug() << Q_FUNC_INFO;


    Type type = getBoundedStar(event->pos());
    this->_hover = type;
    this->update();

}
void Rating::hoverLeaveEvent(QHoverEvent *event){
   qDebug() << Q_FUNC_INFO;
   this->_hover = NONE;
   this->update();
}

