table-data: func [][999 + (random 9000)]
td: func [][rejoin [ "<td>" table-data "</td>" ]]

simple-tag: func [tag contents][rejoin ["<" tag ">" contents "</" tag ">"]]