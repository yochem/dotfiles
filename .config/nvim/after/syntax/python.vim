syn region  pythonString matchgroup=pythonTripleQuotes 
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend fold
      \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
