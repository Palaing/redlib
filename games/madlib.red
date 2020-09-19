Red []

t: {<name> went for a walk in the park. <he or she> found a <noun>. <name> decided to take it home.}

phrase: ask "Enter phrase, leave line empty to terminate:^/"
while [not empty? line: input] [append phrase rejoin ["^/" line]]
words: parse phrase [collect [any [to "<" copy b thru ">" keep (b)]]]
foreach w unique words [replace/all phrase w ask rejoin [w ": "]]
print phrase