#include <QApplication>
#include <QGraphicsView>

#include "stage.h"
#include "spellgame.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    Stage stage;
    SpellGame game;
    stage.addItem(game.displayItem());
    stage.addItem(game.inputItem());
    QGraphicsView view;
    view.setScene(&stage);
    view.show();

    return a.exec();
}
