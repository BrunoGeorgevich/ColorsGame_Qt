#include "stopedgamestate.h"
#include "components/structure/game.h"

StopedGameState::StopedGameState(){}

void StopedGameState::run(){ Game::getInstance()->resumeTimer(); }

