Rock 'Em Sock 'Em Rational Agents
====

See <http://en.wikipedia.org/wiki/Fictitious_play> for the gist.

See [prisoner's dilemma](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma), [stag hunt](http://en.wikipedia.org/wiki/Stag_hunt), [deadlock](http://en.wikipedia.org/wiki/Deadlock_%28game_theory%29), and [volunteer's dilemma](http://en.wikipedia.org/wiki/Volunteer%27s_dilemma) for examples of games RESERA can play. See [normal-form game](http://en.wikipedia.org/wiki/Normal-form_game) for the most confusing a general explanation.

Usage
-----

To test payoff matrix:

              Choice 1 | Choice 2
              -------------------
    Choice 1 | a, b    | c, d
    Choice 2 | e, f    | g, h

Run resera.pl with the arguments

    $ perl resera.pl a b c d e f g h

For example, using the Example PD payoff matrix for the wiki page [prisoner's dilemma](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma):

    $ perl resera.pl 3 3 0 5 5 0 1 1
    Player Column:  (0.000000%, 100.000000%)
    Player Row:     (0.000000%, 100.000000%)

The output describes the strategy our players mimicked (both players always chose the second option, e.g. "always defect").

TODO
-----

* expand summary
* ouput the board
* there's a lot of room to optimise (precomputing $a-$b-$c+$d instead of finding it n times comes immediately to mind)--faster means more iterations
* add a fun license (maybe [WTFPL](http://en.wikipedia.org/wiki/Do_What_The_Fuck_You_Want_To_Public_License)?)
