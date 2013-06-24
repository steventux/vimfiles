""" require():
syn match javaScriptStatement   /\W\zsrequire\ze(/

""" common functions:   
syn match javaScriptStatement   /\W\zsX\ze\./

syn match javaScriptType        /\.\zsget\ze(/
syn match javaScriptType        /\.\zswait\ze(/

syn match javaScriptFunction    /\.\zscall\ze(/
syn match javaScriptFunction    /\.\zsonError\ze(/
syn match javaScriptFunction    /\.\zsapply\ze(/
syn match javaScriptFunction    /\.\zsoptions\ze(/

syn match javaScriptSpecial     /^\s\+\zs\w\+\ze:/


