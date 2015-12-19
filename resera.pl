#!/usr/bin/perl

use strict;
use warnings;

my $iterations = 100000;

my $frequencies = [
  [0, 0],
  [0, 0]
];

# default taken from http://en.wikipedia.org/wiki/Prisoner%27s_dilemma
my $payoff_matrices = [
  [
    [3, 0],
    [5, 1]
  ],
  [
    [3, 0],
    [5, 1]
  ]
];

# also takes command line arguments
if (scalar @ARGV == 8) {
  $payoff_matrices->[0] = [
    [$ARGV[0], $ARGV[2]],
    [$ARGV[4], $ARGV[6]]
  ];
  $payoff_matrices->[1] = [
    [$ARGV[1], $ARGV[5]],
    [$ARGV[3], $ARGV[7]]
  ];
}

for (my $i = 0; $i < $iterations; $i++) {
  # players must choose simultaneously--don't update the frequencies in loop
  my $choices = [undef, undef];
  foreach my $player (0, 1) {
    # find the probability the other player will choose the first option
    my $other_player = ($player + 1) % 2;
    my $frequency = $frequencies->[$other_player];
    my $chose_first = $frequency->[0];
    my $total_choices = $chose_first + $frequency->[1];
    my $p = .5;
    unless ($total_choices == 0) {
      $p = $chose_first / $total_choices;
    }
    # find the expected value of each option
    # we'll skip the /2, since we're comparing them
    my $pm = $payoff_matrices->[$player];
    my $first_choice_ev = $p * $pm->[0][0] + (1 - $p) * $pm->[0][1];
    my $second_choice_ev = $p * $pm->[1][0] + (1 - $p) * $pm->[1][1];
    # pick the choice with the highest ev, or choose at random if they tie
    if ($first_choice_ev != $second_choice_ev) {
      $choices->[$player] = ($first_choice_ev > $second_choice_ev) ? 0 : 1;
    }
    else {
      $choices->[$player] = int(rand() + .5);
    }
  }
  # update frequencies to reflect this round
  foreach my $player (0, 1) {
    $frequencies->[$player][$choices->[$player]]++;
  }
}

my $pm =  "        Column 1 | Column 2\n" .
          "       ---------------------\n" .
          "Row 1 | %3d, %3d | %3d, %3d\n" .
          "Row 2 | %3d, %3d | %3d, %3d\n\n";
printf(
  $pm,
  $payoff_matrices->[0][0][0],
  $payoff_matrices->[1][0][0],
  $payoff_matrices->[0][0][1],
  $payoff_matrices->[1][1][0],
  $payoff_matrices->[0][1][0],
  $payoff_matrices->[1][0][1],
  $payoff_matrices->[0][1][1],
  $payoff_matrices->[1][1][1],
);
foreach my $player (0, 1) {
  printf(
    "Player %d: (%.3f%%, %.3f%%)\n",
    $player,
    ($frequencies->[$player][0] / $iterations) * 100,
    ($frequencies->[$player][1] / $iterations) * 100
  );
}
