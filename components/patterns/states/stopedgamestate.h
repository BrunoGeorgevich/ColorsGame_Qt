#ifndef STOPEDGAMESTATE_H
#define STOPEDGAMESTATE_H

#include "state.h"

class StopedGameState : public State
{
public:
    StopedGameState();

    // State interface
    void run();
};

#endif // STOPEDGAMESTATE_H
