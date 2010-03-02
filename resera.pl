#!/usr/bin/perl

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

my $pm =  "          Choice 1 | Choice 2\n" .
          "          -------------------\n" .
          "Choice 1 | %d, %d    | %d, %d\n" .
          "Choice 2 | %d, %d    | %d, %d\n\n";
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


my $choices = [[0,0], [0,0]];

my $iterations = 10000;

for (my $n = 0; $n < $iterations; $n++) {
  my $this_choice = choice($choices,$grid);
  $choices->[0][$this_choice->[0]]++;
  $choices->[1][$this_choice->[1]]++;
}

printf("Player Column:\t(%f%%, %f%%)\n",
  ($choices->[0][0] / $iterations) * 100,
  ($choices->[0][1] / $iterations) * 100);
printf("Player Row:\t(%f%%, %f%%)\n",
  ($choices->[1][0] / $iterations) * 100,
  ($choices->[1][1] / $iterations) * 100);

sub player_outcome {
  my ($player,$row,$col,$grid) = @_;
  return $grid->[$row][$col][$player];
}

sub outcomes {
  my ($row,$col,$grid) = @_;
  return [
    player_outcome(0,$row,$col,$grid),
    player_outcome(1,$row,$col,$grid)
  ];
}

sub player_slope {
  my ($player,$other_p,$grid) = @_;
  my $a = player_outcome($player,0,0,$grid);
  my $b = player_outcome($player,0,1,$grid);
  my $c = player_outcome($player,1,0,$grid);
  my $d = player_outcome($player,1,1,$grid);
  if ($player == 0) {
    return ($a-$b-$c+$d)*$other_p + ($b-$d);
  }
  return ($a-$b-$c+$d)*$other_p + ($c-$d);
}

sub distributions {
  my $choices = shift;
  # if no one has picked anything, guess
  if ($choices->[0][0] + $choices->[0][1] == 0 ||
    $choices->[1][0] + $choices->[1][1] == 0) {
    return [.5,.5];
  }
  return [
    $choices->[0][0] /
      ($choices->[0][0] + $choices->[0][1]),
    $choices->[1][0] /
      ($choices->[1][0] + $choices->[1][1])
  ];
}

sub choice {
  my ($choices, $grid) = @_;
  my $dist = distributions($choices);
  my $this_choice = [undef,undef];
  foreach my $player (0,1) {
    my $other = ($player==0) ? 1 : 0;
    my $slope = player_slope(
    $player,
    $dist->[$other],
    $grid);
    if ($slope > 0) {
      $this_choice->[$player] = 0;
    }
    elsif ($slope < 0) {
      $this_choice->[$player] = 1;
    }
    else {
      if (rand() < .5) {
        $this_choice->[$player] = 0;
      }
      else {
        $this_choice->[$player] = 1;
      }
    }
  }
  return $this_choice;
}
