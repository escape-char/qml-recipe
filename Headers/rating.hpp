#ifndef RATING_H
#define RATING_H
#include <QQuickPaintedItem>

class Rating : public QQuickPaintedItem{
    Q_OBJECT
    Q_PROPERTY(Type selected READ selected WRITE setSelected NOTIFY selectedChanged)
    Q_PROPERTY(float size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(int spacing READ spacing WRITE setSpacing)

    Q_ENUMS(Type)

public:
    enum Type{NONE, TERRIBLE, POOR, AVERAGE, GOOD, EXCELLENT };
    Rating(QQuickItem* parent=0);
    void paint(QPainter* painter);

    //mouse events
    void hoverMoveEvent(QHoverEvent *event);
    void hoverLeaveEvent(QHoverEvent *event);
    void mousePressEvent(QMouseEvent *event);

    void setSelected(Type selected){
        _selected = selected;
        emit selectedChanged(_selected);
    }
    Type selected() const {return _selected;}
    void setSize(float size){
        _size = size;
        emit sizeChanged(_size);
    }
    float size() const{ return _size;}
    void setSpacing(int spacing){_spacing=spacing;}
    int spacing(){return _spacing;}
signals:
    void selectedChanged(Type type);
    void sizeChanged(float size);
private:
    Type _selected; //selected rating
    Type _hover; //current rating mouse is hovered on
    float _size; //size of the star
    int _spacing; //horizontal spacing between stars

    //each star has a bounding rectangle
    //the rectangle to handle mouse events ie which star the mouse is at
    QRect starRect[5];

    //finds which type rating star the point is in
    Type getBoundedStar(QPoint point);

};

#endif // RATING_H
