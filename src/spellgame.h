#ifndef SPELLGAME_H
#define SPELLGAME_H

#include "abstractgame.h"

class SpellGame : public AbstractGame
{
public:
    SpellGame();

    QGraphicsItem *displayItem();
    QGraphicsItem *inputItem();
};

#endif // SPELLGAME_H
