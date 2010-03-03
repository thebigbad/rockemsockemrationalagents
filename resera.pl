#!/usr/bin/perl
# Copyright 2010 Ryan Wolf <rwolf@borderstylo.com>
#
# This file is part of Rock 'Em Sock 'Em Rational Agents and is released under
# the romantic WTF public license. See LICENSE for more details.

use strict;
use warnings;

# default taken from http://en.wikipedia.org/wiki/Prisoner%27s_dilemma
my $grid = [
  [[3, 3], [0, 5]],
  [[5, 0], [1, 1]]
];
if (scalar @ARGV == 8) {
  $grid = [
    [[$ARGV[0], $ARGV[1]], [$ARGV[2], $ARGV[3]]],
    [[$ARGV[4], $ARGV[5]], [$ARGV[6], $ARGV[7]]]
  ];
}

my $pm =  "           Choice 1 | Choice 2\n" .
          "          --------------------\n" .
          "Choice 1 | %3d, %3d | %3d, %3d\n" .
          "Choice 2 | %3d, %3d | %3d, %3d\n\n";
printf(
  $pm,
  $grid->[0][0][0],
  $grid->[0][0][1],
  $grid->[0][1][0],
  $grid->[0][1][1],
  $grid->[1][0][0],
  $grid->[1][0][1],
  $grid->[1][1][0],
  $grid->[1][1][1]
);

my $m = [
  $grid->[0][0][0] - $grid->[0][1][0] - $grid->[1][0][0] + $grid->[1][1][0],
  $grid->[0][0][1] - $grid->[0][1][1] - $grid->[1][0][1] + $grid->[1][1][1]
];

my $b = [
  $grid->[1][0][0] - $grid->[1][1][0],
  $grid->[1][0][1] - $grid->[1][1][1]
];

my $choices = [[0,0], [0,0]];

my $iterations = 100000;

for (my $n = 0; $n < $iterations; $n++) {
  my $this_choice = choice($choices, $m, $b);
  $choices->[0][$this_choice->[0]]++;
  $choices->[1][$this_choice->[1]]++;
}

printf("Player Column:\t(%.0f%%, %.0f%%)\n",
  ($choices->[0][0] / $iterations) * 100,
  ($choices->[0][1] / $iterations) * 100);
printf("Player Row:\t(%.0f%%, %.0f%%)\n",
  ($choices->[1][0] / $iterations) * 100,
  ($choices->[1][1] / $iterations) * 100);

sub p_of_first_choice {
  my ($n_chose_first, $n_chose_second) = @_;
  my $total_choices = $n_chose_first + $n_chose_second;
  if ($total_choices == 0) {
    return .5;
  }
  return $n_chose_first / $total_choices;
}

sub distributions {
  my $choices = shift;
  return [
    p_of_first_choice($choices->[0][0], $choices->[0][1]),
    p_of_first_choice($choices->[1][0], $choices->[1][1])
  ];
}

sub choice {
  my ($choices, $b, $m) = @_;
  my $dist = distributions($choices);
  my $this_choice = [undef,undef];
  foreach my $player (0,1) {
    my $other_p =$dist->[($player + 1) % 2];
    my $slope = $m->[$player]*$other_p + $b->[$player];
    if ($slope == 0) {
     $this_choice->[$player] = int(rand() + .5);
     next;
    }
    $this_choice->[$player] = ($slope > 0) ? 0 : 1;
  }
  return $this_choice;
}
