#!/usr/bin/perl -w
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

#ACSII Art file
my $greetings = 'welcome.txt';

open (my $file, "<", $greetings)
    or die "Cannot open file!";

#Read and print welcome.txt    
chomp(my @lines = <$file>);
print "\n";
foreach (@lines) {
    print "$_\n";    
};
close $file;

print "\nEnter your name: ";
chomp(my $player_name = <>);

my $restart;
my $player_bet;
my $player_guess;
my $cpu_wins = 0;
my $player_wins = 0;

main();

sub main {
    
    # Bet of the player
    playerBet();
    sub playerBet
    {
        print "\n$player_name make your bet between 0 and 3: ";
        chomp($player_bet = <>);
    }
    while ($player_bet < 0 || $player_bet > 3 || !looks_like_number($player_bet)) {
        playerBet();
    }
    
    #Guess of the player
    playerGuess();
    sub playerGuess
    {
        print "\n$player_name make your guess between $player_bet and ", ($player_bet + 3), ": ";
        chomp($player_guess = <>);
    }
    while ($player_guess < $player_bet || $player_guess > ($player_bet + 3) || !looks_like_number($player_guess)) {
        playerGuess();
    }
    
    #CPU bet between 0 and 3
    my $cpu_bet = int(rand(3));
    
    #CPU guess between 0 and 6
    my $cpu_guess = int(rand(3)) + $cpu_bet;
    
    #Number that the guesses have to match to win
    my $winning_number = $player_bet + $cpu_bet;
    
    #Determine the winner
    if($player_guess == $winning_number) {
        print "\n*** Congratulation $player_name. You Win!!! ***\n";
        $player_wins++;
    } elsif ($cpu_guess == $winning_number) {
        print "\nxxx What a shame. CPU win. xxx\n";
        $cpu_wins++;
    } else {
        print "\n--- It's a tie. No one got it right. ---\n";
    }
    
    print "\n$player_name - Bet: $player_bet Guess: $player_guess";
    print "\nCPU - Bet: $cpu_bet Guess: $cpu_guess";
    print "\nWinning bet: $winning_number\n";
    
    print "\nPlayer wins: $player_wins";
    print "\nCPU wins: $cpu_wins\n";
    
    #Restart input
    print "\nPlay again? ";
    chomp($restart = lc <>);
}

#Restart logic
while ($restart eq "y" || $restart eq "yes" || $restart eq "") {
    main();
}



