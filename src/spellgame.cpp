#include "spellgame.h"

SpellGame::SpellGame()
{
}

QGraphicsItem *SpellGame::displayItem()
{
    return new QGraphicsLineItem(100, 100, 400, 400);
}

QGraphicsItem *SpellGame::inputItem()
{
    return new QGraphicsEllipseItem(100, 100, 400, 100);
}
