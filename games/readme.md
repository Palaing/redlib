A few games written in Red, esp. to contribute to http://rosettacode.org

* 24game.red and 24gamesolver.red allow respectively to play and to solve the "24 game", see http://rosettacode.org/wiki/24_game and http://rosettacode.org/wiki/24_game/Solve
* noconnexion.red and noconnexionVis.red both solve the "no connection puzzle", see http://rosettacode.org/wiki/Solve_the_no_connection_puzzle; the second version adds a graphical display of the solution
* bof.red demonstrates a way to emulate ternary logic, see http://www.rosettacode.org/wiki/Ternary_logic.
* fractran.red is a demo implementation of the FRACTRAN programming language of John Conway, see http://rosettacode.org/wiki/Fractran.
* afterc.red challenges the rule "I before E except after C" of English language, see http://rosettacode.org/wiki/I_before_E_except_after_C; it tests the rule on 2 word lists, unixdict.txt and 1_2_all_freq.txt. The first one can be read directly from the web. The second was downloaded and manually converted from ANSI to UTF-8, as the /as refinement of Red's *read* action is not yet implemented.
* fractaltree.red draws a fractal tree according to http://rosettacode.org/wiki/Fractal_tree - with some color, size and angle variations to improve visual effect.

Writing both 24game.red and bof.red challenged me about parsing and evaluating arithmetic expressions with or without parentheses. I report this experience and learnings in the wiki.
