#ifndef RATING_H
#define RATING_H
#include <QQuickPaintedItem>

class Rating : public QQuickPaintedItem{
    Q_OBJECT
    Q_PROPERTY(int selected READ selected WRITE setSelected NOTIFY selectedChanged)
    Q_PROPERTY(float size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(int spacing READ spacing WRITE setSpacing)
    Q_PROPERTY(QColor fillColor READ fillColor WRITE setFillColor)
    Q_PROPERTY(QColor strokeColor READ strokeColor WRITE setStrokeColor)
    Q_ENUMS(Type)

public:
    enum Type{NONE, TERRIBLE, POOR, AVERAGE, GOOD, EXCELLENT };
    Rating(QQuickItem* parent=0);
    void paint(QPainter* painter);

    //mouse events
    void hoverMoveEvent(QHoverEvent *event);
    void hoverLeaveEvent(QHoverEvent *event);
    void mousePressEvent(QMouseEvent *event);

    void setSelected(int s){
        if(s >= NONE && s <= EXCELLENT){
            _selected = (Type) s;
            emit selectedChanged(_selected);
         }
    }
    Type selected() const {return _selected;}
    void setSize(float size){
        _size = size;
        emit sizeChanged(_size);
    }
    float size() const{ return _size;}
    void setSpacing(int spacing){_spacing=spacing;}
    void setFillColor( QColor color ) { _fillColor = color; }
    void setStrokeColor(QColor color) {_strokeColor = color;}
    QColor strokeColor() { return _strokeColor; }
    QColor fillColor() {return  _fillColor;}
    int spacing(){return _spacing;}

signals:
    void selectedChanged(Type type);
    void sizeChanged(float size);
private:
    Type _selected; //selected rating
    Type _hover; //current rating mouse is hovered on
    float _size; //size of the star
    int _spacing; //horizontal spacing between stars
    QColor _fillColor;
    QColor _strokeColor;

    //each star has a bounding rectangle
    //the rectangle to handle mouse events ie which star the mouse is at
    QRect starRect[5];

    //finds which type rating star the point is in
    Type getBoundedStar(QPoint point);

};

#endif // RATING_H
