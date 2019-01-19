; http://www.rosettacode.org/wiki/Create_an_HTML_table

Red []

result: func[][simple-tag "table" trs]

trs: func [][rejoin [
        first-tr
        rand-tr 1
        rand-tr 2
        rand-tr 3
        rand-tr 4
        rand-tr 5
    ]]


table-data: func [][999 + (random 9000)]
rand-td: func [][simple-tag "td" table-data]
rand-tr: func [i][rejoin [
        (simple-tag "tr"
            rejoin [(simple-tag "td" i) rand-td rand-td rand-td]
        )
    ]]
first-tr: func[][rejoin [
        simple-tag "tr" rejoin [
            (simple-tag "th" "")
            (simple-tag "th" "X")
            (simple-tag "th" "Y")
            (simple-tag "th" "Z")
            ]
    ]]

simple-tag: func [tag contents][rejoin
    ["<" tag ">" newline contents newline "</" tag ">"]]