Rock 'Em Sock 'Em Rational Agents
====

See <http://en.wikipedia.org/wiki/Fictitious_play> for the gist.

See [prisoner's dilemma](http://en.wikipedia.org/wiki/Prisoner%27s_dilemma), [stag hunt](http://en.wikipedia.org/wiki/Stag_hunt), [deadlock](http://en.wikipedia.org/wiki/Deadlock_%28game_theory%29), and [volunteer's dilemma](http://en.wikipedia.org/wiki/Volunteer%27s_dilemma) for examples of games RESERA can play. See [normal-form game](http://en.wikipedia.org/wiki/Normal-form_game) for the most confusing a general explanation.

Usage
-----

The board is hard-coded into resara.pl, so edit and run it:

    $ perl resera.pl
    Player Column:  (100.000000%, 0.000000%)
    Player Row:     (100.000000%, 0.000000%)

TODO
-----

* expand summary
* take the board as command line arguments
* ouput the board
* there's a lot of room to optimise (precomputing $a-$b-$c+$d instead of finding it n times comes immediately to mind)--faster means more iterations
* add a fun license
