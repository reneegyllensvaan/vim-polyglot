" Vim support file to detect file types
"
" Maintainer:	Adam Stankiewicz <sheerun@sher.pl>
" URL: https://github.com/sheerun/vim-polyglot

" We are not supporting non-compatible mode
if &compatible
  finish
endif

" Listen very carefully, I will say this only once
if exists("did_load_polyglot")
  finish
endif

let did_load_polyglot = 1

" It can happen vim filetype.vim loads first, then we need a reset
if exists("did_load_filetypes")
  au! filetypedetect
endif

" Prevent filetype.vim of vim from loading again
let did_load_filetypes = 1

" Line continuation is used here, remove 'C' from 'cpoptions'
let s:cpo_save = &cpo
set cpo&vim

func! s:Observe(fn)
  let b:polyglot_observe = a:fn
  augroup polyglot-observer
    au! CursorHold,CursorHoldI,BufWritePost <buffer>
      \ execute('if polyglot#' . b:polyglot_observe . '() | au! polyglot-observer | endif')
  augroup END
endfunc

let s:disabled_packages = {}
let s:new_polyglot_disabled = []

if exists('g:polyglot_disabled')
  for pkg in g:polyglot_disabled
    let base = split(pkg, '\.')
    if len(base) > 0
      let s:disabled_packages[pkg] = 1
      call add(s:new_polyglot_disabled, base[0])
    endif
  endfor
else
  let g:polyglot_disabled_not_set = 1
endif

function! s:SetDefault(name, value)
  if !exists(a:name)
    let {a:name} = a:value
  endif
endfunction

call s:SetDefault('g:markdown_enable_spell_checking', 0)
call s:SetDefault('g:markdown_enable_input_abbreviations', 0)
call s:SetDefault('g:markdown_enable_mappings', 0)

" Enable jsx syntax by default
call s:SetDefault('g:jsx_ext_required', 0)

" Needed for sql highlighting
call s:SetDefault('g:javascript_sql_dialect', 'sql')

" Make csv loading faster
call s:SetDefault('g:csv_start', 1)
call s:SetDefault('g:csv_end', 2)
call s:SetDefault('g:csv_default_delim', ',')

" Disable json concealing by default
call s:SetDefault('g:vim_json_syntax_conceal', 0)

call s:SetDefault('g:filetype_euphoria', 'elixir')

if !exists('g:python_highlight_all')
  call s:SetDefault('g:python_highlight_builtins', 1)
  call s:SetDefault('g:python_highlight_builtin_objs', 1)
  call s:SetDefault('g:python_highlight_builtin_types', 1)
  call s:SetDefault('g:python_highlight_builtin_funcs', 1)
  call s:SetDefault('g:python_highlight_builtin_funcs_kwarg', 1)
  call s:SetDefault('g:python_highlight_exceptions', 1)
  call s:SetDefault('g:python_highlight_string_formatting', 1)
  call s:SetDefault('g:python_highlight_string_format', 1)
  call s:SetDefault('g:python_highlight_string_templates', 1)
  call s:SetDefault('g:python_highlight_indent_errors', 1)
  call s:SetDefault('g:python_highlight_space_errors', 1)
  call s:SetDefault('g:python_highlight_doctests', 1)
  call s:SetDefault('g:python_highlight_func_calls', 1)
  call s:SetDefault('g:python_highlight_class_vars', 1)
  call s:SetDefault('g:python_highlight_operators', 1)
  call s:SetDefault('g:python_highlight_file_headers_as_comments', 1)
  call s:SetDefault('g:python_slow_sync', 1)
endif

" We need it because scripts.vim in vim uses "set ft=" which cannot be
" overridden with setf (and we can't use set ft= so our scripts.vim work)
func! s:Setf(ft)
  if &filetype !~# '\<'.a:ft.'\>'
    let &filetype = a:ft
  endif
endfunc

" Function used for patterns that end in a star: don't set the filetype if the
" file name matches ft_ignore_pat.
" When using this, the entry should probably be further down below with the
" other StarSetf() calls.
func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc

augroup filetypedetect

  " DO NOT EDIT CODE BELOW, IT IS GENERATED WITH MAKEFILE

au! BufNewFile,BufRead,BufWritePost *.html call polyglot#detect#Html()
au BufNewFile,BufRead *.htm,*.html.hl,*.inc,*.st,*.xht,*.xhtml setf html
au BufNewFile,BufRead PULLREQ_EDITMSG setf pullrequest
au BufNewFile,BufRead *.text,README setf text
au BufNewFile,BufRead crontab setf crontab
au BufNewFile,BufRead crontab.* call s:StarSetf('crontab')
au BufNewFile,BufRead */etc/cron.d/* call s:StarSetf('crontab')
au BufNewFile,BufRead *Xmodmap setf xmodmap
au BufNewFile,BufRead *xmodmap* call s:StarSetf('xmodmap')
au BufNewFile,BufRead *.ad,{.,}Xdefaults,{.,}Xpdefaults,{.,}Xresources,xdm-config setf xdefaults
au BufNewFile,BufRead Xresources* call s:StarSetf('xdefaults')
au BufNewFile,BufRead */app-defaults/* call s:StarSetf('xdefaults')
au BufNewFile,BufRead */Xresources/* call s:StarSetf('xdefaults')
au BufNewFile,BufRead {.,}viminfo,_viminfo setf viminfo
au BufNewFile,BufRead *.vba,*.vim,{.,}exrc,_exrc setf vim
au BufNewFile,BufRead *vimrc* call s:StarSetf('vim')
au BufNewFile,BufRead */etc/udev/permissions.d/*.permissions setf udevperm
au BufNewFile,BufRead */etc/udev/udev.conf setf udevconf
au BufNewFile,BufRead *.ti setf terminfo
au BufNewFile,BufRead */etc/ssh/sshd_config.d/*.conf,sshd_config setf sshdconfig
au BufNewFile,BufRead */.ssh/config,*/etc/ssh/ssh_config.d/*.conf,ssh_config setf sshconfig
au BufNewFile,BufRead {.,}screenrc,screenrc setf screen
au BufNewFile,BufRead *.sass setf sass
au BufNewFile,BufRead {.,}inputrc,inputrc setf readline
au BufNewFile,BufRead */etc/passwd,*/etc/passwd-,*/etc/passwd.edit,*/etc/shadow,*/etc/shadow-,*/etc/shadow.edit,*/var/backups/passwd.bak,*/var/backups/shadow.bak setf passwd
au BufNewFile,BufRead {.,}netrc setf netrc
au BufNewFile,BufRead Neomuttrc setf neomuttrc
au BufNewFile,BufRead neomuttrc* call s:StarSetf('neomuttrc')
au BufNewFile,BufRead Neomuttrc* call s:StarSetf('neomuttrc')
au BufNewFile,BufRead .neomuttrc* call s:StarSetf('neomuttrc')
au BufNewFile,BufRead */.neomutt/neomuttrc* call s:StarSetf('neomuttrc')
au BufNewFile,BufRead */log/{auth,cron,daemon,debug,kern,lpr,mail,messages,news/news,syslog,user}{,.log,.err,.info,.warn,.crit,.notice}{,.[0-9]*,-[0-9]*} setf messages
au BufNewFile,BufRead {.,}mailcap,mailcap setf mailcap
au BufNewFile,BufRead */etc/aliases,*/etc/mail/aliases setf mailaliases
au BufNewFile,BufRead *.eml,{.,}article,{.,}article.\d\+,{.,}followup,{.,}letter,{.,}letter.\d\+,/tmp/SLRN[0-9A-Z.]\+,ae\d\+.txt,mutt[[:alnum:]_-]\\\{6\},mutt{ng,}-*-\w\+,neomutt-*-\w\+,neomutt[[:alnum:]_-]\\\{6\},pico.\d\+,snd.\d\+,{neo,}mutt[[:alnum:]._-]\\\{6\} setf mail
au BufNewFile,BufRead reportbug-* call s:StarSetf('mail')
au BufNewFile,BufRead */etc/login.defs setf logindefs
au BufNewFile,BufRead */etc/login.access setf loginaccess
au BufNewFile,BufRead *.ld setf ld
au BufNewFile,BufRead *.ldif setf ldif
au BufNewFile,BufRead {.,}gdbinit setf gdb
au BufNewFile,BufRead *.dot,*.gv setf dot
au BufNewFile,BufRead *.diff,*.rej setf diff
au BufNewFile,BufRead Pipfile,configure.ac,configure.in setf config
au BufNewFile,BufRead /etc/hostname.* call s:StarSetf('config')
au BufNewFile,BufRead named*.conf,rndc*.conf,rndc*.key setf named
au BufNewFile,BufRead *.bdy,*.ddl,*.fnc,*.pck,*.pkb,*.pks,*.plb,*.pls,*.plsql,*.prc,*.spc,*.sql,*.tpb,*.tps,*.trg,*.tyb,*.tyc,*.typ,*.vw setf sql
au BufNewFile,BufRead *.git/info/exclude,*/.config/git/ignore,{.,}gitignore setf gitignore
au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt setf help
au BufNewFile,BufRead *.adml,*.admx,*.ant,*.axml,*.builds,*.ccproj,*.ccxml,*.cdxml,*.clixml,*.cproject,*.cscfg,*.csdef,*.csl,*.csproj,*.csproj.user,*.ct,*.depproj,*.dita,*.ditamap,*.ditaval,*.dll.config,*.dotsettings,*.filters,*.fsproj,*.fxml,*.glade,*.gml,*.gmx,*.grxml,*.gst,*.iml,*.ivy,*.jelly,*.jsproj,*.kml,*.launch,*.mdpolicy,*.mjml,*.mm,*.mod,*.mxml,*.natvis,*.ncl,*.ndproj,*.nproj,*.nuspec,*.odd,*.osm,*.pkgproj,*.pluginspec,*.proj,*.props,*.psc1,*.pt,*.rdf,*.resx,*.rss,*.sch,*.scxml,*.sfproj,*.shproj,*.srdf,*.storyboard,*.sublime-snippet,*.targets,*.tml,*.tpm,*.ui,*.urdf,*.ux,*.vbproj,*.vcxproj,*.vsixmanifest,*.vssettings,*.vstemplate,*.vxml,*.wixproj,*.workflow,*.wpl,*.wsdl,*.wsf,*.wxi,*.wxl,*.wxs,*.x3d,*.xacro,*.xaml,*.xib,*.xlf,*.xliff,*.xmi,*.xml,*.xml.dist,*.xproj,*.xsd,*.xspec,*.xul,*.zcml,*/etc/blkid.tab,*/etc/blkid.tab.old,*/etc/xdg/menus/*.menu,*fglrxrc,{.,}classpath,{.,}cproject,{.,}project,App.config,NuGet.config,Settings.StyleCop,Web.Debug.config,Web.Release.config,Web.config,packages.config setf xml
au BufNewFile,BufRead *.ts setf typescript

au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead {.,}tmux*.conf setf tmux
au BufNewFile,BufRead *.bash,*.bats,*.cgi,*.command,*.env,*.fcgi,*.ksh,*.sh,*.sh.in,*.tmux,*.tool,*/etc/udev/cdsymlinks.conf,{.,}bash_aliases,{.,}bash_history,{.,}bash_logout,{.,}bash_profile,{.,}bashrc,{.,}cshrc,{.,}env,{.,}env.example,{.,}flaskenv,{.,}login,{.,}profile,9fs,PKGBUILD,bash_aliases,bash_logout,bash_profile,bashrc,cshrc,gradlew,login,man,profile,zlogin,zlogout,zprofile,zshenv,zshrc setf sh

au BufNewFile,BufRead *.zsh,{.,}zfbfmarks,{.,}zlogin,{.,}zlogout,{.,}zprofile,{.,}zshenv,{.,}zshrc setf zsh
au BufNewFile,BufRead .zsh* call s:StarSetf('zsh')
au BufNewFile,BufRead .zlog* call s:StarSetf('zsh')
au BufNewFile,BufRead .zcompdump* call s:StarSetf('zsh')
au BufNewFile,BufRead *.conf,auto.master,config setf conf
au BufNewFile,BufRead *.rs,*.rs.in setf rust
au BufNewFile,BufRead *.rest,*.rest.txt,*.rst,*.rst.txt setf rst
au! BufNewFile,BufRead,BufWritePost *.re call polyglot#detect#Re()
au BufNewFile,BufRead *.rei setf reason
au BufNewFile,BufRead *.pri,*.pro setf qmake
au BufNewFile,BufRead *.pip,*require.{txt,in},*requirements.{txt,in},constraints.{txt,in} setf requirements
au BufNewFile,BufRead *.cgi,*.fcgi,*.gyp,*.gypi,*.lmi,*.ptl,*.py,*.py3,*.pyde,*.pyi,*.pyp,*.pyt,*.pyw,*.rpy,*.smk,*.spec,*.tac,*.wsgi,*.xpy,{.,}gclient,{.,}pythonrc,{.,}pythonstartup,DEPS,SConscript,SConstruct,Snakefile,wscript setf python
au! BufNewFile,BufRead,BufWritePost *.t call polyglot#detect#T()
au! BufNewFile,BufRead,BufWritePost *.pm call polyglot#detect#Pm()
au! BufNewFile,BufRead,BufWritePost *.pl call polyglot#detect#Pl()
au BufNewFile,BufRead *.al,*.cgi,*.fcgi,*.perl,*.ph,*.plx,*.psgi,{.,}gitolite.rc,Makefile.PL,Rexfile,ack,cpanfile,example.gitolite.rc setf perl

au BufNewFile,BufRead *.pod setf pod

au BufNewFile,BufRead *.comp,*.mason,*.mhtml setf mason

au! BufNewFile,BufRead,BufWritePost *.tt2 call polyglot#detect#Tt2()

au! BufNewFile,BufRead,BufWritePost *.tt2 call polyglot#detect#Tt2()

au BufNewFile,BufRead *.xs setf xs
au BufNewFile,BufRead *.rc,*.rch setf rc
au BufNewFile,BufRead *.eliom,*.eliomi,*.ml,*.ml.cppo,*.ml4,*.mli,*.mli.cppo,*.mlip,*.mll,*.mlp,*.mlt,*.mly,{.,}ocamlinit setf ocaml

au BufNewFile,BufRead *.om,OMakefile,OMakeroot,OMakeroot.in setf omake

au BufNewFile,BufRead *.opam,*.opam.template,opam setf opam

au BufNewFile,BufRead _oasis setf oasis

au BufNewFile,BufRead dune,dune-project,dune-workspace,jbuild setf dune

au BufNewFile,BufRead _tags setf ocamlbuild_tags

au BufNewFile,BufRead *.ocp setf ocpbuild

au BufNewFile,BufRead *.root setf ocpbuildroot

au BufNewFile,BufRead *.sexp setf sexplib
au! BufNewFile,BufRead,BufWritePost *.m call polyglot#detect#M()
au! BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
au BufNewFile,BufRead *.nim,*.nim.cfg,*.nimble,*.nimrod,*.nims,nim.cfg setf nim
au BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mdwn,*.mkd,*.mkdn,*.mkdown,*.ronn,*.workbook,contents.lr setf markdown
au BufNewFile,BufRead *.fcgi,*.lua,*.nse,*.p8,*.pd_lua,*.rbxs,*.rockspec,*.wlua,{.,}luacheckrc setf lua
au BufNewFile,BufRead *.ll setf llvm

au BufNewFile,BufRead *.td setf tablegen
au BufNewFile,BufRead *.ect,*.ejs,*.jst setf jst
au BufNewFile,BufRead *.jsonnet,*.libsonnet setf jsonnet
au BufNewFile,BufRead *.JSON-tmLanguage,*.avsc,*.geojson,*.gltf,*.har,*.ice,*.json,*.jsonl,*.jsonp,*.mcmeta,*.template,*.tfstate,*.tfstate.backup,*.topojson,*.webapp,*.webmanifest,*.yy,*.yyp,{.,}arcconfig,{.,}htmlhintrc,{.,}tern-config,{.,}tern-project,{.,}watchmanconfig,Pipfile.lock,composer.lock,mcmod.info setf json
au BufNewFile,BufRead *.json5 setf json5
au BufNewFile,BufRead *.Jenkinsfile,*.jenkinsfile,Jenkinsfile setf Jenkinsfile
au BufNewFile,BufRead Jenkinsfile* call s:StarSetf('Jenkinsfile')
au BufNewFile,BufRead *.i3.config,*.i3config,{.,}i3.config,{.,}i3config,i3.config,i3config setf i3config
au BufNewFile,BufRead *.gradle,*.groovy,*.grt,*.gtpl,*.gvy,Jenkinsfile setf groovy
au BufNewFile,BufRead *.gql,*.graphql,*.graphqls setf graphql
au BufNewFile,BufRead *.jsx setf javascriptreact
au BufNewFile,BufRead *._js,*.bones,*.cjs,*.es,*.es6,*.frag,*.gs,*.jake,*.javascript,*.js,*.jsb,*.jscad,*.jsfl,*.jsm,*.jss,*.mjs,*.njs,*.pac,*.sjs,*.ssjs,*.xsjs,*.xsjslib,Jakefile setf javascript

au BufNewFile,BufRead *.flow setf flow
au BufNewFile,BufRead *.gitconfig,*.git/config,*.git/modules/*/config,*/.config/git/config,*/git/config,{.,}gitconfig,{.,}gitmodules setf gitconfig
au BufNewFile,BufRead */{.,}gitconfig.d/* call s:StarSetf('gitconfig')

au BufNewFile,BufRead git-rebase-todo setf gitrebase

au BufNewFile,BufRead .gitsendemail.* call s:StarSetf('gitsendemail')

au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG setf gitcommit
au BufNewFile,BufRead *.fish setf fish
au BufNewFile,BufRead *.Dockerfile,*.dock,*.dockerfile,Dockerfile,dockerfile setf Dockerfile
au BufNewFile,BufRead Dockerfile* call s:StarSetf('Dockerfile')

au BufNewFile,BufRead docker-compose*.yaml,docker-compose*.yml setf yaml.docker-compose
au BufNewFile,BufRead *.mir,*.reek,*.rviz,*.sublime-syntax,*.syntax,*.yaml,*.yaml-tmlanguage,*.yaml.sed,*.yml,*.yml.mysql,{.,}clang-format,{.,}clang-tidy,{.,}gemrc,fish_history,fish_read_history,glide.lock,yarn.lock setf yaml
au BufNewFile,BufRead *.cmake,*.cmake.in,CMakeLists.txt setf cmake
au! BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
au BufNewFile,BufRead *.c++,*.cc,*.cp,*.cpp,*.cxx,*.h++,*.hh,*.hpp,*.hxx,*.inc,*.inl,*.ipp,*.moc,*.tcc,*.tlh,*.tpp setf cpp

au! BufNewFile,BufRead,BufWritePost *.h call polyglot#detect#H()
au BufNewFile,BufRead *.c,*.cats,*.idc,*.qc,*enlightenment/*.cfg setf c
au BufNewFile,BufRead *.cfg,*.hgrc,*hgrc setf cfg
au BufNewFile,BufRead *.awk,*.gawk setf awk
au BufNewFile,BufRead *.dsp,*.mak,*.mk,GNUmakefile.am,Makefile.am,makefile.am setf automake

" DO NOT EDIT CODE ABOVE, IT IS GENERATED WITH MAKEFILE

  au! BufNewFile,BufRead,StdinReadPost * if expand("<afile>:e") == "" |
        \ call polyglot#shebang#Detect() | endif

  au BufEnter * if &ft == "" && expand("<afile>:e") == ""  |
        \ call s:Observe('shebang#Detect') | endif

augroup END

if !has_key(s:disabled_packages, 'autoindent')
  " Code below re-implements sleuth for vim-polyglot
  let g:loaded_sleuth = 1
  let g:loaded_foobar = 1

  " Makes shiftwidth to be synchronized with tabstop by default
  if &shiftwidth == &tabstop
    let &shiftwidth = 0
  endif

  function! s:guess(lines) abort
    let options = {}
    let ccomment = 0
    let podcomment = 0
    let triplequote = 0
    let backtick = 0
    let xmlcomment = 0
    let heredoc = ''
    let minindent = 10
    let spaces_minus_tabs = 0
    let i = 0

    for line in a:lines
      let i += 1

      if !len(line) || line =~# '^\W*$'
        continue
      endif

      if line =~# '^\s*/\*'
        let ccomment = 1
      endif
      if ccomment
        if line =~# '\*/'
          let ccomment = 0
        endif
        continue
      endif

      if line =~# '^=\w'
        let podcomment = 1
      endif
      if podcomment
        if line =~# '^=\%(end\|cut\)\>'
          let podcomment = 0
        endif
        continue
      endif

      if triplequote
        if line =~# '^[^"]*"""[^"]*$'
          let triplequote = 0
        endif
        continue
      elseif line =~# '^[^"]*"""[^"]*$'
        let triplequote = 1
      endif

      if backtick
        if line =~# '^[^`]*`[^`]*$'
          let backtick = 0
        endif
        continue
      elseif &filetype ==# 'go' && line =~# '^[^`]*`[^`]*$'
        let backtick = 1
      endif

      if line =~# '^\s*<\!--'
        let xmlcomment = 1
      endif
      if xmlcomment
        if line =~# '-->'
          let xmlcomment = 0
        endif
        continue
      endif

      " This is correct order because both "<<EOF" and "EOF" matches end
      if heredoc != ''
        if line =~# heredoc
          let heredoc = ''
        endif
        continue
      endif
      let herematch = matchlist(line, '\C<<\W*\([A-Z]\+\)\s*$')
      if len(herematch) > 0
        let heredoc = herematch[1] . '$'
      endif

      let spaces_minus_tabs += line[0] == "\t" ? 1 : -1

      if line[0] == "\t"
        setlocal noexpandtab
        let &l:shiftwidth=&tabstop
        let b:sleuth_culprit .= ':' . i
        return 1
      elseif line[0] == " "
        let indent = len(matchstr(line, '^ *'))
        if (indent % 2 == 0 || indent % 3 == 0) && indent < minindent
          let minindent = indent
        endif
      endif
    endfor

    if minindent < 10
      setlocal expandtab
      let &l:shiftwidth=minindent
      let b:sleuth_culprit .= ':' . i
      return 1
    endif

    return 0
  endfunction

  function! s:detect_indent() abort
    if &buftype ==# 'help'
      return
    endif

    let b:sleuth_culprit = expand("<afile>:p")
    if s:guess(getline(1, 32))
      return
    endif
    let pattern = polyglot#sleuth#GlobForFiletype(&filetype)
    if len(pattern) == 0
      return
    endif
    let pattern = '{' . pattern . ',.git,.svn,.hg}'
    let dir = expand('%:p:h')
    let level = 3
    while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && level > 0
      " Ignore files from homedir and root
      if dir == expand('~') || dir == '/'
        unlet b:sleuth_culprit
        return
      endif
      for neighbor in glob(dir . '/' . pattern, 0, 1)[0:level]
        let b:sleuth_culprit = neighbor
        " Do not consider directories above .git, .svn or .hg
        if fnamemodify(neighbor, ":h:t")[0] == "."
          let level = 0
          continue
        endif
        if neighbor !=# expand('%:p') && filereadable(neighbor)
          if s:guess(readfile(neighbor, '', 32))
            return
          endif
        endif
      endfor

      let dir = fnamemodify(dir, ':h')
      let level -= 1
    endwhile

    unlet b:sleuth_culprit
  endfunction

  setglobal smarttab

  function! SleuthIndicator() abort
    let sw = &shiftwidth ? &shiftwidth : &tabstop
    if &expandtab
      return 'sw='.sw
    elseif &tabstop == sw
      return 'ts='.&tabstop
    else
      return 'sw='.sw.',ts='.&tabstop
    endif
  endfunction

  augroup polyglot-sleuth
    au!
    au FileType * call s:detect_indent()
    au User Flags call Hoist('buffer', 5, 'SleuthIndicator')
  augroup END

  command! -bar -bang Sleuth call s:detect_indent()
endif

func! s:verify()
  if exists("g:polyglot_disabled_not_set")
    if exists("g:polyglot_disabled")
      echohl WarningMsg
      echo "vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot"
      echohl None
    endif

    unlet g:polyglot_disabled_not_set
  endif
endfunc

au VimEnter * call s:verify()

" Save polyglot_disabled without postfixes
if exists('g:polyglot_disabled')
  let g:polyglot_disabled = s:new_polyglot_disabled
endif

augroup filetypedetect

" Ignored extensions
if exists("*fnameescape")
au BufNewFile,BufRead ?\+.orig,?\+.bak,?\+.old,?\+.new,?\+.dpkg-dist,?\+.dpkg-old,?\+.dpkg-new,?\+.dpkg-bak,?\+.rpmsave,?\+.rpmnew,?\+.pacsave,?\+.pacnew
	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))
au BufNewFile,BufRead *~
	\ let s:name = expand("<afile>") |
	\ let s:short = substitute(s:name, '\~$', '', '') |
	\ if s:name != s:short && s:short != "" |
	\   exe "doau filetypedetect BufRead " . fnameescape(s:short) |
	\ endif |
	\ unlet! s:name s:short
au BufNewFile,BufRead ?\+.in
	\ if expand("<afile>:t") != "configure.in" |
	\   exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r")) |
	\ endif
elseif &verbose > 0
  echomsg "Warning: some filetypes will not be recognized because this version of Vim does not have fnameescape()"
endif

" Pattern used to match file names which should not be inspected.
" Currently finds compressed files.
if !exists("g:ft_ignore_pat")
  let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'
endif

" Batch file for MSDOS.
au BufNewFile,BufRead *.bat,*.sys		setf dosbatch
" *.cmd is close to a Batch file, but on OS/2 Rexx files also use *.cmd.
au BufNewFile,BufRead *.cmd
	\ if getline(1) =~ '^/\*' | setf rexx | else | setf dosbatch | endif

" Blkid cache file
au BufNewFile,BufRead */etc/blkid.tab,*/etc/blkid.tab.old   setf xml

" BSDL
au BufNewFile,BufRead *bsd,*.bsdl		setf bsdl

" C or lpc
au BufNewFile,BufRead *.c			call polyglot#ft#FTlpc()
au BufNewFile,BufRead *.lpc,*.ulpc		setf lpc

" Calendar
au BufNewFile,BufRead calendar			setf calendar

" C#
au BufNewFile,BufRead *.cs			setf cs

" C++
au BufNewFile,BufRead *.cxx,*.c++,*.hh,*.hxx,*.hpp,*.ipp,*.moc,*.tcc,*.inl setf cpp
if has("fname_case")
  au BufNewFile,BufRead *.C,*.H setf cpp
endif

" .h files can be C, Ch C++, ObjC or ObjC++.
" Set c_syntax_for_h if you want C, ch_syntax_for_h if you want Ch. ObjC is
" detected automatically.
au BufNewFile,BufRead *.h			call polyglot#ft#FTheader()

" TLH files are C++ headers generated by Visual C++'s #import from typelibs
au BufNewFile,BufRead *.tlh			setf cpp

" Cascading Style Sheets
au BufNewFile,BufRead *.css			setf css

" Changelog
au BufNewFile,BufRead changelog.Debian,changelog.dch,NEWS.Debian,NEWS.dch,*/debian/changelog
					\	setf debchangelog

au BufNewFile,BufRead [cC]hange[lL]og
	\  if getline(1) =~ '; urgency='
	\|   setf debchangelog
	\| else
	\|   setf changelog
	\| endif

" Clojure
au BufNewFile,BufRead *.clj,*.cljs,*.cljx,*.cljc		setf clojure

" Cmake
au BufNewFile,BufRead CMakeLists.txt,*.cmake,*.cmake.in		setf cmake

" Configure scripts
au BufNewFile,BufRead configure.in,configure.ac setf config

" Dockerfile; Podman uses the same syntax with name Containerfile
au BufNewFile,BufRead Containerfile,Dockerfile,*.Dockerfile	setf dockerfile

" Configure files
au BufNewFile,BufRead *.cfg			setf cfg

" dnsmasq(8) configuration files
au BufNewFile,BufRead */etc/dnsmasq.conf	setf dnsmasq

" the D language or dtrace
au BufNewFile,BufRead *.d			call polyglot#ft#DtraceCheck()

" Dict config
au BufNewFile,BufRead dict.conf,.dictrc		setf dictconf

" Dictd config
au BufNewFile,BufRead dictd.conf		setf dictdconf

" Diff files
au BufNewFile,BufRead *.diff,*.rej		setf diff
au BufNewFile,BufRead *.patch
	\ if getline(1) =~ '^From [0-9a-f]\{40\} Mon Sep 17 00:00:00 2001$' |
	\   setf gitsendemail |
	\ else |
	\   setf diff |
	\ endif

" Dircolors
au BufNewFile,BufRead .dir_colors,.dircolors,*/etc/DIR_COLORS	setf dircolors

" DOT
au BufNewFile,BufRead *.dot,*.gv		setf dot

" EditorConfig (close enough to dosini)
au BufNewFile,BufRead .editorconfig		setf dosini

" Expect
au BufNewFile,BufRead *.exp			setf expect

" Exports
au BufNewFile,BufRead exports			setf exports

" FStab
au BufNewFile,BufRead fstab,mtab		setf fstab

" GDB command files
au BufNewFile,BufRead .gdbinit			setf gdb

" Git
au BufNewFile,BufRead COMMIT_EDITMSG,MERGE_MSG,TAG_EDITMSG	setf gitcommit
au BufNewFile,BufRead *.git/config,.gitconfig,/etc/gitconfig	setf gitconfig
au BufNewFile,BufRead */.config/git/config			setf gitconfig
au BufNewFile,BufRead .gitmodules,*.git/modules/*/config	setf gitconfig
if !empty($XDG_CONFIG_HOME)
  au BufNewFile,BufRead $XDG_CONFIG_HOME/git/config		setf gitconfig
endif
au BufNewFile,BufRead git-rebase-todo		setf gitrebase
au BufRead,BufNewFile .gitsendemail.msg.??????	setf gitsendemail
au BufNewFile,BufRead .msg.[0-9]*
      \ if getline(1) =~ '^From.*# This line is ignored.$' |
      \   setf gitsendemail |
      \ endif
au BufNewFile,BufRead *.git/*
      \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
      \   setf git |
      \ endif

" GPG
au BufNewFile,BufRead */.gnupg/options		setf gpg
au BufNewFile,BufRead */.gnupg/gpg.conf		setf gpg
au BufNewFile,BufRead */usr/*/gnupg/options.skel setf gpg
if !empty($GNUPGHOME)
  au BufNewFile,BufRead $GNUPGHOME/options	setf gpg
  au BufNewFile,BufRead $GNUPGHOME/gpg.conf	setf gpg
endif

" Groovy
au BufNewFile,BufRead *.gradle,*.groovy		setf groovy

" Group file
au BufNewFile,BufRead */etc/group,*/etc/group-,*/etc/group.edit,*/etc/gshadow,*/etc/gshadow-,*/etc/gshadow.edit,*/var/backups/group.bak,*/var/backups/gshadow.bak  setf group

" Haskell
au BufNewFile,BufRead *.hs,*.hs-boot		setf haskell
au BufNewFile,BufRead *.lhs			setf lhaskell
au BufNewFile,BufRead *.chs			setf chaskell

" HTML (.shtml and .stm for server side)
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call polyglot#ft#FThtml()

" Host config
au BufNewFile,BufRead */etc/host.conf		setf hostconf

" Hosts access
au BufNewFile,BufRead */etc/hosts.allow,*/etc/hosts.deny  setf hostsaccess

" .INI file for MSDOS
au BufNewFile,BufRead *.ini			setf dosini

" SysV Inittab
au BufNewFile,BufRead inittab			setf inittab

" Java
au BufNewFile,BufRead *.java,*.jav		setf java

" JavaScript, ECMAScript, ES module script, CommonJS script
au BufNewFile,BufRead *.js,*.javascript,*.es,*.mjs,*.cjs   setf javascript

" JavaScript with React
au BufNewFile,BufRead *.jsx			setf javascriptreact

" JSON
au BufNewFile,BufRead *.json,*.jsonp,*.webmanifest	setf json

" Kotlin
au BufNewFile,BufRead *.kt,*.ktm,*.kts		setf kotlin

" Ld loader
au BufNewFile,BufRead *.ld			setf ld

" Lex
au BufNewFile,BufRead *.lex,*.l,*.lxx,*.l++	setf lex

" Lifelines (or Lex for C++!)
au BufNewFile,BufRead *.ll			setf lifelines

" Lisp (*.el = ELisp, *.cl = Common Lisp)
" *.jl was removed, it's also used for Julia, better skip than guess wrong.
if has("fname_case")
  au BufNewFile,BufRead *.lsp,*.lisp,*.el,*.cl,*.L,.emacs,.sawfishrc setf lisp
else
  au BufNewFile,BufRead *.lsp,*.lisp,*.el,*.cl,.emacs,.sawfishrc setf lisp
endif

" SBCL implementation of Common Lisp
au BufNewFile,BufRead sbclrc,.sbclrc		setf lisp

" Lua
au BufNewFile,BufRead *.lua			setf lua

" Mail (for Elm, trn, mutt, muttng, rn, slrn, neomutt)
au BufNewFile,BufRead snd.\d\+,.letter,.letter.\d\+,.followup,.article,.article.\d\+,pico.\d\+,mutt{ng,}-*-\w\+,mutt[[:alnum:]_-]\\\{6\},neomutt-*-\w\+,neomutt[[:alnum:]_-]\\\{6\},ae\d\+.txt,/tmp/SLRN[0-9A-Z.]\+,*.eml setf mail

" Mail aliases
au BufNewFile,BufRead */etc/mail/aliases,*/etc/aliases	setf mailaliases

" Mailcap configuration file
au BufNewFile,BufRead .mailcap,mailcap		setf mailcap

" Manpage
au BufNewFile,BufRead *.man			setf man

" Man config
au BufNewFile,BufRead */etc/man.conf,man.config	setf manconf

" Markdown
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  setf markdown

" Messages (logs mostly)
au BufNewFile,BufRead */log/{auth,cron,daemon,debug,kern,lpr,mail,messages,news/news,syslog,user}{,.log,.err,.info,.warn,.crit,.notice}{,.[0-9]*,-[0-9]*} setf messages

" Noemutt setup file
au BufNewFile,BufRead Neomuttrc			setf neomuttrc

" Netrc
au BufNewFile,BufRead .netrc			setf netrc

" NPM RC file
au BufNewFile,BufRead npmrc,.npmrc		setf dosini

" OCAML
au BufNewFile,BufRead *.ml,*.mli,*.mll,*.mly,.ocamlinit	setf ocaml

" Pacman Config (close enough to dosini)
au BufNewFile,BufRead */etc/pacman.conf		setf dosini

" Password file
au BufNewFile,BufRead */etc/passwd,*/etc/passwd-,*/etc/passwd.edit,*/etc/shadow,*/etc/shadow-,*/etc/shadow.edit,*/var/backups/passwd.bak,*/var/backups/shadow.bak setf passwd

" Perl
if has("fname_case")
  au BufNewFile,BufRead *.pl,*.PL		call polyglot#ft#FTpl()
else
  au BufNewFile,BufRead *.pl			call polyglot#ft#FTpl()
endif
au BufNewFile,BufRead *.plx,*.al,*.psgi		setf perl
au BufNewFile,BufRead *.p6,*.pm6,*.pl6		setf perl6
au BufNewFile,BufRead *.raku,*.rakumod		setf perl6

" Perl, XPM or XPM2
au BufNewFile,BufRead *.pm
	\ if getline(1) =~ "XPM2" |
	\   setf xpm2 |
	\ elseif getline(1) =~ "XPM" |
	\   setf xpm |
	\ else |
	\   setf perl |
	\ endif

" Php, php3, php4, etc.
" Also Phtml (was used for PHP 2 in the past)
" Also .ctp for Cake template file
au BufNewFile,BufRead *.php,*.php\d,*.phtml,*.ctp	setf php

" Pipenv Pipfiles
au BufNewFile,BufRead Pipfile			setf config
au BufNewFile,BufRead Pipfile.lock		setf json

" PostScript (+ font files, encapsulated PostScript, Adobe Illustrator)
au BufNewFile,BufRead *.ps,*.pfa,*.afm,*.eps,*.epsf,*.epsi,*.ai	  setf postscr

" Progress or assembly
au BufNewFile,BufRead *.i			call polyglot#ft#FTprogress_asm()

" Python, Python Shell Startup and Python Stub Files
" Quixote (Python-based web framework)
au BufNewFile,BufRead *.py,*.pyw,.pythonstartup,.pythonrc  setf python
au BufNewFile,BufRead *.ptl,*.pyi,SConstruct		   setf python

" Readline
au BufNewFile,BufRead .inputrc,inputrc		setf readline

" Ruby
au BufNewFile,BufRead *.rb,*.rbw		setf ruby

" Rust
au BufNewFile,BufRead *.rs			setf rust

" Sass
au BufNewFile,BufRead *.sass			setf sass

" Scala
au BufNewFile,BufRead *.scala			setf scala

" SCSS
au BufNewFile,BufRead *.scss			setf scss

" Services
au BufNewFile,BufRead */etc/services		setf services

" Shell scripts (sh, ksh, bash, bash2, csh); Allow .profile_foo etc.
" Gentoo ebuilds and Arch Linux PKGBUILDs are actually bash scripts
" NOTE: Patterns ending in a star are further down, these have lower priority.
au BufNewFile,BufRead .bashrc,bashrc,bash.bashrc,.bash[_-]profile,.bash[_-]logout,.bash[_-]aliases,bash-fc[-.],*.bash,*/{,.}bash[_-]completion{,.d,.sh}{,/*},*.ebuild,*.eclass,PKGBUILD call polyglot#ft#SetFileTypeSH("bash")
au BufNewFile,BufRead .kshrc,*.ksh call polyglot#ft#SetFileTypeSH("ksh")
au BufNewFile,BufRead */etc/profile,.profile,*.sh,*.env call polyglot#ft#SetFileTypeSH(getline(1))

" Z-Shell script (patterns ending in a star further below)
au BufNewFile,BufRead .zprofile,*/etc/zprofile,.zfbfmarks  setf zsh
au BufNewFile,BufRead .zshrc,.zshenv,.zlogin,.zlogout,.zcompdump setf zsh
au BufNewFile,BufRead *.zsh			setf zsh

" Scheme
au BufNewFile,BufRead *.scm,*.ss,*.rkt		setf scheme

" SQL
au BufNewFile,BufRead *.sql			call polyglot#ft#SQL()

" OpenSSH configuration
au BufNewFile,BufRead ssh_config,*/.ssh/config		setf sshconfig
au BufNewFile,BufRead */etc/ssh/ssh_config.d/*.conf	setf sshconfig

" OpenSSH server configuration
au BufNewFile,BufRead sshd_config			setf sshdconfig
au BufNewFile,BufRead */etc/ssh/sshd_config.d/*.conf	setf sshdconfig

" Standard ML
au BufNewFile,BufRead *.sml			setf sml

" Swift
au BufNewFile,BufRead *.swift			setf swift
au BufNewFile,BufRead *.swift.gyb		setf swiftgyb

" Sysctl
au BufNewFile,BufRead */etc/sysctl.conf,*/etc/sysctl.d/*.conf	setf sysctl

" Systemd unit files
au BufNewFile,BufRead */systemd/*.{automount,dnssd,link,mount,netdev,network,nspawn,path,service,slice,socket,swap,target,timer}	setf systemd
" Systemd overrides
au BufNewFile,BufRead */etc/systemd/*.conf.d/*.conf	setf systemd
au BufNewFile,BufRead */etc/systemd/system/*.d/*.conf	setf systemd
au BufNewFile,BufRead */.config/systemd/user/*.d/*.conf	setf systemd
" Systemd temp files
au BufNewFile,BufRead */etc/systemd/system/*.d/.#*	setf systemd
au BufNewFile,BufRead */etc/systemd/system/.#*		setf systemd
au BufNewFile,BufRead */.config/systemd/user/*.d/.#*	setf systemd
au BufNewFile,BufRead */.config/systemd/user/.#*	setf systemd

" SVG (Scalable Vector Graphics)
au BufNewFile,BufRead *.svg			setf svg

" Tags
au BufNewFile,BufRead tags			setf tags

" Terminfo
au BufNewFile,BufRead *.ti			setf terminfo

" tmux configuration
au BufNewFile,BufRead {.,}tmux*.conf		setf tmux

" Typescript
au BufNewFile,BufReadPost *.ts			setf typescript

" TypeScript with React
au BufNewFile,BufRead *.tsx			setf typescriptreact

" Udev conf
au BufNewFile,BufRead */etc/udev/udev.conf	setf udevconf

" Udev permissions
au BufNewFile,BufRead */etc/udev/permissions.d/*.permissions setf udevperm
"
" Udev symlinks config
au BufNewFile,BufRead */etc/udev/cdsymlinks.conf	setf sh

" Vim script
au BufNewFile,BufRead *.vim,*.vba,.exrc,_exrc	setf vim

" Viminfo file
au BufNewFile,BufRead .viminfo,_viminfo		setf viminfo

" XHTML
au BufNewFile,BufRead *.xhtml,*.xht		setf xhtml

" Xorg config
au BufNewFile,BufRead xorg.conf,xorg.conf-4	let b:xf86conf_xfree86_version = 4 | setf xf86conf

" X resources file
au BufNewFile,BufRead .Xdefaults,.Xpdefaults,.Xresources,xdm-config,*.ad setf xdefaults

" XML  specific variants: docbk and xbl
au BufNewFile,BufRead *.xml			call polyglot#ft#FTxml()

" X11 xmodmap (also see below)
au BufNewFile,BufRead *Xmodmap			setf xmodmap

augroup END


" Source the user-specified filetype file, for backwards compatibility with
" Vim 5.x.
if exists("myfiletypefile") && filereadable(expand(myfiletypefile))
  execute "source " . myfiletypefile
endif


" Check for "*" after loading myfiletypefile, so that scripts.vim is only used
" when there are no matching file name extensions.
" Don't do this for compressed files.
augroup filetypedetect
au BufNewFile,BufRead *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat
	\ | runtime! scripts.vim | endif
au StdinReadPost * if !did_filetype() | runtime! scripts.vim | endif


" Extra checks for when no filetype has been detected now.  Mostly used for
" patterns that end in "*".  E.g., "zsh*" matches "zsh.vim", but that's a Vim
" script file.
" Most of these should call s:StarSetf() to avoid names ending in .gz and the
" like are used.

" Bazaar version control
au BufNewFile,BufRead bzr_log.*			setf bzr

" Bazel build file
if !has("fname_case")
  au BufNewFile,BufRead *.BUILD,BUILD			setf bzl
endif

" Changelog
au BufNewFile,BufRead [cC]hange[lL]og*
	\ if getline(1) =~ '; urgency='
	\|  call s:StarSetf('debchangelog')
	\|else
	\|  call s:StarSetf('changelog')
	\|endif

" Crontab
au BufNewFile,BufRead crontab,crontab.*,*/etc/cron.d/*		call s:StarSetf('crontab')

" Git
au BufNewFile,BufRead */.gitconfig.d/*,/etc/gitconfig.d/*	call s:StarSetf('gitconfig')

" Makefile
au BufNewFile,BufRead [mM]akefile*		call s:StarSetf('make')

" Mail (also matches muttrc.vim, so this is below the other checks)
au BufNewFile,BufRead {neo,}mutt[[:alnum:]._-]\\\{6\}	setf mail

au BufNewFile,BufRead reportbug-*		call s:StarSetf('mail')

" Neomutt setup file
au BufNewFile,BufRead .neomuttrc*,*/.neomutt/neomuttrc*	call s:StarSetf('neomuttrc')
au BufNewFile,BufRead neomuttrc*,Neomuttrc*		call s:StarSetf('neomuttrc')

" Shell scripts ending in a star
au BufNewFile,BufRead .bashrc*,.bash[_-]profile*,.bash[_-]logout*,.bash[_-]aliases*,bash-fc[-.]*,,PKGBUILD* call polyglot#ft#SetFileTypeSH("bash")
au BufNewFile,BufRead .profile* call polyglot#ft#SetFileTypeSH(getline(1))

" Vim script
au BufNewFile,BufRead *vimrc*			call s:StarSetf('vim')

" X resources file
au BufNewFile,BufRead Xresources*,*/app-defaults/*,*/Xresources/* call s:StarSetf('xdefaults')

" X11 xmodmap
au BufNewFile,BufRead *xmodmap*			call s:StarSetf('xmodmap')

" Z-Shell script ending in a star
au BufNewFile,BufRead .zsh*,.zlog*,.zcompdump*  call s:StarSetf('zsh')
au BufNewFile,BufRead zsh*,zlog*		call s:StarSetf('zsh')

" Plain text files, needs to be far down to not override others.  This avoids
" the "conf" type being used if there is a line starting with '#'.
au BufNewFile,BufRead *.text,README		setf text

" Help files match *.txt but should have a last line that is a modeline.
au BufNewFile,BufRead *.txt
	\  if getline('$') !~ 'vim:.*ft=help'
	\|   setf text
	\| endif

" NOTE: The above command could have ended the filetypedetect autocmd group
" and started another one. Let's make sure it has ended to get to a consistent
" state.
augroup END


" Restore 'cpoptions'
let &cpo = s:cpo_save
unlet s:cpo_save
