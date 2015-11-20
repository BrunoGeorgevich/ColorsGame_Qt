#ifndef INGAMESTATE_H
#define INGAMESTATE_H

#include "state.h"
class InGameState : public State
{
public:
    InGameState();

    // State interface
    void run();
};

#endif // INGAMESTATE_H
