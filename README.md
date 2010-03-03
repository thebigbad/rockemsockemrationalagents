Rock 'Em Sock 'Em Rational Agents
====

During my first Game Theory class, I read an article about (fictitious play)[http://en.wikipedia.org/wiki/Fictitious_play), a demonstration of how two rational agents might converge on Nash equilibrium in [normal-form games](http://en.wikipedia.org/wiki/Normal-form_game) by following a simple strategy:

* Given the frequency with which your opponent has chosen the first option, determine the liklihood that they will choose it for this game. If your opponent has not played this game with your before, set the liklihood to 50%.
* Given the liklihood your opponent will choose the first option and the payoff matrix, determine the expected value of both of your options.
* Given the expected value of both of your options, choose the option with the highest expected value. If both options have the same expected value, choose randomly.

The idea is that two agents following this strategy and playing the same game over and over will mimic the behavior of rational agents who found the Nash equlibria of a given game and chose an appropriate mixed strategy.

That night I wrote a perl script to pit two such players againest each other to see if it worked. Not only did the resulting program validate the article, but it helped me to gain some intuition about Nash equlibria in normal-form games. I'm sticking it on github under a friendly license it the hope that it helps some other game theory nerds out, too.

See [prisoner's dilemma](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma), [stag hunt](http://en.wikipedia.org/wiki/Stag_hunt), [deadlock](http://en.wikipedia.org/wiki/Deadlock_%28game_theory%29), and [volunteer's dilemma](http://en.wikipedia.org/wiki/Volunteer%27s_dilemma) for examples of normal form games. Once you've gotten the hang of it (where "it" is "you need to pick 8 numbers to go in the boxes for the payoff matrix"), try creating your own games to see if anything interesting happens.

Usage
-----

To test payoff matrix:

            Column 1 | Column 2
           ---------------------
    Row 1 |   a,   b |   c,   d
    Row 2 |   e,   f |   g,   h

Run resera.pl with the arguments

    $ perl resera.pl a b c d e f g h

For example, using the Example PD payoff matrix for the wiki page [prisoner's dilemma](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma):

    $ perl resera.pl 3 3 0 5 5 0 1 1
            Column 1 | Column 2
           ---------------------
    Row 1 |   3,   3 |   0,   5
    Row 2 |   5,   0 |   1,   1

    Player 0: (0.000%, 100.000%)
    Player 1: (0.000%, 100.000%)

The output describes the strategy our players mimicked (both players always chose the second option, e.g. "always defect").

One important thing to remember is that the agents act randomly when they don't have any information or when both options are just as good. This means as your games grow more complicated than the prisoner's dilemma (and gain multiple absorbing states), you'll start to notice different behavior on running the same board through more than once. Don't panic--our hard-working little agents have stumbled into an absorbing state at random and will remain there until the next run.

License
-----

Copyright 2010 Ryan Wolf <rwolf@borderstylo.com>

Rock 'Em Sock 'Em Rational agents is released under the romantic WTF public license. See LICENSE for more details.
