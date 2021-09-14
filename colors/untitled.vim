set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="untitled"

if has("gui_running") || &t_Co == 256
    fun <SID>grey_number(x)
          if a:x < 14
              return 0
          else
              let l:n = (a:x - 8) / 10
              let l:m = (a:x - 8) % 10
              if l:m < 5
                  return l:n
              else
                  return l:n + 1
              endif
        endif
    endfun

    fun <SID>grey_level(n)
          if a:n == 0
              return 0
          else
              return 8 + (a:n * 10)
          endif
    endfun

    fun <SID>grey_color(n)
          if a:n == 0
              return 16
          elseif a:n == 25
              return 231
          else
              return 231 + a:n
          endif
    endfun

    fun <SID>rgb_number(x)
          if a:x < 75
              return 0
          else
              let l:n = (a:x - 55) / 40
              let l:m = (a:x - 55) % 40
              if l:m < 20
                  return l:n
              else
                  return l:n + 1
              endif
        endif
    endfun

    fun <SID>rgb_level(n)
          if a:n == 0
              return 0
          else
              return 55 + (a:n * 40)
        endif
    endfun

    fun <SID>rgb_color(x, y, z)
          return 16 + (a:x * 36) + (a:y * 6) + a:z
    endfun

    fun <SID>color(r, g, b)
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                return <SID>grey_color(l:gx)
            else
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun

    call <SID>X("Normal", "ccb18f", "202020", "")
    call <SID>X("NonText", "ccb18f", "202020", "")

    call <SID>X("Search", "3080a0", "404040", "")
    call <SID>X("IncSearch", "3080a0", "404040", "")

    call <SID>X("StatusLine", "000000", "888888", "bold")
    call <SID>X("StatusLineNC", "000000", "888888", "")
    call <SID>X("VertSplit", "202020", "202020", "")
    call <SID>X("Folded", "3c78a2", "c3daea", "")
    call <SID>X("IncSearch", "3080a0", "404040", "")
    call <SID>X("Pmenu", "ffffff", "cb2f27", "")
    call <SID>X("SignColumn", "", "", "")
    call <SID>X("CursorLine", "", "c0d9eb", "")
    call <SID>X("LineNr", "E67700", "202020", "bold")
    call <SID>X("MatchParen", "", "", "")

    call <SID>X("Todo", "e080e0", "202020", "bold")
    call <SID>X("Title", "000000", "", "")
    call <SID>X("Special", "fd8900", "", "")

    call <SID>X("String", "a0ff70", "", "")
    call <SID>X("Constant", "a0ff70", "", "")
    call <SID>X("Number", "a0ff70", "", "")
    call <SID>X("Statement", "cc2000", "", "")
    call <SID>X("Function", "ccb18f", "", "")
    call <SID>X("PreProc", "ccb18f", "", "")
    call <SID>X("Comment", "888888", "", "")
    call <SID>X("Type", "cc2000", "", "")
    call <SID>X("Error", "ffffff", "d40000", "")
    call <SID>X("Identifier", "ccb18f", "", "")
    call <SID>X("Label", "e5ed15", "", "")

    delf <SID>X
    delf <SID>rgb
    delf <SID>color
    delf <SID>rgb_color
    delf <SID>rgb_level
    delf <SID>rgb_number
    delf <SID>grey_color
    delf <SID>grey_level
    delf <SID>grey_number
endif

" vim: set fdl=0 fdm=marker:
