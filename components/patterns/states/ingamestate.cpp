#include "ingamestate.h"
#include "components/structure/game.h"

InGameState::InGameState(){}

void InGameState::run()
{
    Game::getInstance()->stopTimer();
}

