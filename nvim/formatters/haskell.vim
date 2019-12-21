function! neoformat#formatters#haskell#enabled() abort
    return ['ormolu']
endfunction

function! neoformat#formatters#haskell#ormolu() abort
    return {
        \ 'exe': 'ormolu',
        \ 'stdin': 1
        \ }
endfunction
