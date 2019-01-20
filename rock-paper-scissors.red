Implement the classic children's game Rock-paper-scissors, as well as
a simple predictive   AI   (artificial intelligence)   player.

Rock Paper Scissors is a two player game.

Each player chooses one of rock, paper or scissors, without knowing
the other player's choice.

The winner is decided by a set of rules:

  Rock beats scissors
  Scissors beat paper
  Paper beats rock

If both players choose the same thing, there is no winner for that round.

For this task, the computer will be one of the players.

The operator will select Rock, Paper or Scissors and the computer will
keep a record of the choice frequency, and use that information to
make a weighted random choice in an attempt to defeat its opponent.

Red [
    Problem: %http://www.rosettacode.org/wiki/Rock-paper-scissors
    Code: %https://github.com/metaperl/red-rosetta/blob/master/rock-paper-scissors.red
]

help1: %https://stackoverflow.com/questions/54272942/how-to-find-the-first-element-of-a-block-of-strings-whose-first-character-matche
help2: %https://stackoverflow.com/questions/54272956/how-to-increment-element-of-block-after-found-element
help3: %https://stackoverflow.com/questions/54273057/two-dimensional-dispatch-table-with-templated-response
help4: %https://stackoverflow.com/questions/54273161/in-red-how-do-i-search-through-a-block-for-a-string-matching-a-pattern/54275072#54275072

games-played: 0

weapons: ["rock" "scissors" "paper"]
matching-weapon: func [abbrev][
    foreach weapon weapons [
        if (first weapon) = first abbrev [
            return weapon
        ]
    ]
]
player-choices: ["rock" 0 "scissors" 0 "paper" 0 ]
player-choice-tally: func [choice][player-choices/(choice): player-choices/(choice) + 1]

player-choice: "x"
valid-choice: func [c][find "rpsq" c]

player-wins: [
    ["rock" "scissors"] "breaks"
    ["paper" "rock"] "covers"
    ["scissors" "paper"] "cut"
]

player-wins?: function [player1 player2] [
    game: reduce [player1 player2]
    winning: player-wins/(game)
]

report-win: func [player1 player2][rejoin [player1 " " (player-wins? player1 player2) " " player2]]


draw: func [player computer][player = computer]

update-stats: func [player-choice][
    player-choice-tally player-choice
    games-played: games-played + 1
]

make-computer-choice: func [][
    either games-played >= 3 [
        tmp: random games-played
        tally: select "rock" player-choices
        either tmp <= tally [return "rock"][
            tally: tally + select "scissors" player-choices
            either tmp <= tally [return "scissors"][
                return "paper"
            ]
        ]
    ][random/only weapons]
]

while [not player-choice = "q"][
    player-choice: ask "(r)ock, (s)cissors, (p)aper or (q)uit? "
    either (player-choice = "q") [][
        if (valid-choice player-choice) [
            computer-choice: random/only weapons
            player-choice: matching-weapon player-choice
            update-stats player-choice
            print rejoin ["Player choice: " player-choice "tally" player-choices "Computer choice:" computer-choice]
            either draw player-choice computer-choice [print "Draw"][
                tmp: player-wins? player-choice computer-choice
                print either tmp [rejoin ["Player wins: " report-win player-choice computer-choice]]
                    [rejoin ["Computer wins: " report-win computer-choice player-choice]]
            ]
        ]
    ]

]

