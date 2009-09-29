#ifndef ABSTRACTGAME_H
#define ABSTRACTGAME_H

#include <QGraphicsItem>

class AbstractGame : public QObject
{
public:
    AbstractGame();

    virtual QGraphicsItem *displayItem() = 0;
    virtual QGraphicsItem *inputItem() = 0;

protected:
    int m_points;
};

#endif // ABSTRACTGAME_H
