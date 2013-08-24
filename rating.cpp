#include <QDebug>
#include <QPoint>
#include <QPainterPath>
#include<QPainter>
#include<QBrush>
#include<QRect>
#include <cmath>
#include "Headers/rating.hpp"

Rating::Rating(QQuickItem* parent):
    QQuickPaintedItem(parent){
    this->setAcceptHoverEvents(true);
    this->setAcceptedMouseButtons(Qt::LeftButton);
    this->_selected = NONE;
    this->_hover=NONE;
    this->_size = 10;
    this->_spacing = 10;
}
void Rating::paint(QPainter *painter){
    qDebug() << Q_FUNC_INFO;
    const int totalStars = 5;

    float angle = (2*M_PI) / 10;

    float radius = _size;

    float center[2] = {2*_size,2*_size};

    float offset = 2*radius + _spacing;

    //star to draw
    QPainterPath path;

    QBrush brush("gold");

    for(int star = 1; star <= totalStars; star++){
        QRect boundingRect;
        boundingRect.moveTo(center[0] - radius, center[1] - radius);
        boundingRect.setSize(QSize(2* radius, 2*radius));

        this->starRect[star - 1] = boundingRect;

        for(int i = 0; i !=11; i++){
            float r = radius*(i % 2 + 1) / 2;
            float nextAngle = angle * i;

            //next point to draw line to
            int dx = (int) (r* sin(nextAngle) + center[0]);
            int dy = (int) (r* cos(nextAngle) + center[1]);
            if(i == 0){path.moveTo(dx, dy);}

            path.lineTo(dx, dy);
        }
        if(_hover > 0 && star <= this->_hover ||
            star <=_selected && _hover == 0){
            brush.setColor("gold");
        }
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
           qDebug() << "INSIDE STAR: " << i + 1;
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

