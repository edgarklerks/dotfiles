#!/usr/bin/env perl
# $Id: tlpkg-ctan-check 32105 2013-11-09 00:55:18Z karl $
# Public domain.  Originally written 2005, Karl Berry.
# Check if a package in TL has any changes on CTAN.

BEGIN {
  chomp ($mydir = `dirname $0`);  # we are in Master/tlpkg/bin
  unshift (@INC, "$mydir/..");
}

use TeXLive::TLConfig qw/$RelocPrefix $RelocTree/;
use TeXLive::TLPOBJ;
use TeXLive::TLPDB;

use File::Basename;

my $tlpdb;
my $Master;
our %OPT;

my @TLP_working = qw(
  12many 2up
  Asana-Math ESIEEcv GS1 HA-prosper IEEEconf IEEEtran
    SIstyle SIunits Tabbing Type1fonts
  a0poster a2ping a4wide a5comb
    aastex abbr abc abntex2 abraces abstract abstyles
    accanthis accfonts achemso
    acmconf acro acronym acroterm
    active-conf actuarialangle
    addlines adfathesis adforn adhocfilelist
    adjmulticol adfsymbols adjustbox adobemapping
    adrconv advdate
    ae aecc aeguill afthesis
    aguplus aiaa aichej akktex akletter
    alg algorithm2e algorithmicx algorithms allrunes alnumsec alterqcm
    altfont ametsoc amiri amsaddr amscls amsfonts amslatex-primer
    amsldoc-it amsldoc-vn
    amsmath amsmath-it amsrefs amstex amsthdoc-it 
    animate anonchap answers antiqua antomega antt anufinalexam
    anyfontsize anysize
    aomart apa apa6 apa6e apacite apalike2
    appendix appendixnumberbeamer apprends-latex apptools
    arabi arabtex arabxetex aramaic-serto arara archaic arcs arev
    around-the-bend arphic arrayjobx arraysort arsclassica
    arydshln articleingud
    asaetr ascelike ascii-chart ascii-font aspectratio assignment astro asyfig
    asymptote-faq-zh-cn asymptote-by-example-zh-cn asymptote-manual-zh-cn
    attachfile
    augie auncial-new aurical autopdf authoraftertitle authorindex
    auto-pst-pdf autoarea automata autonum avantgar
  b1encoding babel
    babel-albanian babel-bahasa babel-basque babel-breton
    babel-bulgarian babel-catalan babel-croatian babel-czech
    babel-danish babel-dutch babel-english babel-esperanto
    babel-estonian babel-finnish babel-french babel-friulan
    babel-galician babel-german babel-georgian babel-greek
    babel-hebrew babel-hungarian
    babel-icelandic babel-interlingua babel-irish babel-italian
    babel-kurmanji babel-latin babel-norsk babel-piedmontese
    babel-polish babel-portuges babel-romanian babel-romansh
    babel-russian babel-samin babel-scottish babel-serbian
    babel-serbianc babel-slovak babel-slovenian babel-sorbian
    babel-spanish babel-swedish babel-thai babel-turkish babel-ukraineb
    babel-vietnamese babel-welsh
    babelbib background backnaur bangtex
    barcodes bardiag barr bartel-chess-fonts bashful baskervald
    basque-book basque-date
    bbcard bbding bbm bbm-macros bbold bbold-type1 bchart bclogo
    beamer beamer2thesis beamer-FUBerlin beamer-tut-pt
    beameraudience beamerposter
    beamersubframe beamertheme-upenn-bc
    beamerthemejltree beamerthemephnompenh beamerthemenirma
    beebe begriff belleek bengali bera berenisadf betababel beton
    bez123 bezos bgreek bgteubner bguq bhcexam
    bib-fr bibarts biber bibhtml
    biblatex biblatex-apa biblatex-bwl
    biblatex-caspervector biblatex-chem biblatex-chicago
    biblatex-dw biblatex-fiwi biblatex-gost biblatex-historian
    biblatex-ieee biblatex-juradiss
    biblatex-luh-ipw
    biblatex-mla biblatex-musuos biblatex-nature biblatex-nejm
    biblatex-philosophy biblatex-phys biblatex-publist
    biblatex-science biblatex-swiss-legal
    biblatex-trad
    bibleref bibleref-french bibleref-german bibleref-lds bibleref-mouth
    bibleref-parse
    biblist bibtex bibtopic
    bibtopicprefix bibexport bibunits 
    bidi bigfoot bigints binomexp biocon bitelist bizcard
    blacklettert1 blindtext blkarray block blockdraw_mp bloques blowup
    bodegraph bohr boisik bold-extra
    boites boldtensors bondgraph bookest bookhands booklet
    booktabs booktabs-de booktabs-fr boolexpr boondox bophook
    borceux bosisio
    boxedminipage boxhandler bpchem bpolynomial
    bracketkey braids braille braket brandeis-dissertation
    breakcites breakurl bropd brushscr
    bullcntr bundledoc burmese bussproofs
    bxbase bxcjkjatype bxdpx-beamer bxeepic bxjscls bytefield 
  c-pascal cabin cachepic calcage calctab calculator
    calligra calligra-type1 calrsfs cals calxxxx-yyyy cancel
    canoniclayout cantarell
    capt-of captcont captdef caption carlisle carolmin-ps
    cascadilla cases casyl
    catchfilebetweentags catcodes catechis catoptions
    cbcoptic cbfonts cbfonts-fd
    cc-pl ccaption ccfonts ccicons cclicenses
    cd cd-cover cdpbundl
    cell cellspace censor cfr-lm
    changebar changelayout changepage changes chappg chapterfolder
    chbibref checkcites chem-journal
    chemarrow chembst chemcompounds chemcono chemexec chemfig chemmacros
    chemnum chemstyle cherokee
    chess chess-problem-diagrams chessboard chessfss chet chextras
    chicago chicago-annote chickenize chkfloat chletter chngcntr chronology
    chronosys chscite
    circ circuitikz
    cite cjhebrew cjk cjk-ko cjkpunct classics classicthesis
    clefval cleveref clipboard
    clock clrscode cm-lgc cm-super cm-unicode
    cmap cmarrows cmbright cmcyr
    cmdstring cmdtrack cmll cmpica cmpj cmsd cmtiup cnltx
    codedoc codepage codicefiscaleitaliano
    collcell collectbox collref colordoc colorinfo colorsep colortab
    colortbl colorwav colorweb colourchange
    combelow combine combinedgraphics comfortaa comma commado commath comment
    compactbib
    complexity components-of-TeX comprehensive computational-complexity
    concepts concmath concmath-fonts concprog concrete confproc constants conteq
    context-account context-algorithmic context-bnf context-chromato 
    context-construction-plan context-cyrillicnumbers
    context-degrade context-filter context-fixme
    context-french context-fullpage
    context-games context-gantt context-gnuplot
    context-letter context-lettrine context-lilypond context-mathsets
    context-notes-zh-cn context-rst context-ruby
    context-simplefonts context-simpleslides
    context-transliterator context-typearea context-typescripts context-vim
    contour contracard convbkmk
    cooking cookingsymbols cool coollist coolstr coolthms cooltooltips
    coordsys copyrightbox coseoul
    countriesofeurope counttexruns courier-scaled courseoutline coursepaper
    coverpage covington
    cprotect
    crbox crop crossreference crossword crosswrd cryst
    cs csbulletin cslatex csplain csquotes csquotes-de csvsimple csvtools cstex
    ctanify ctanupload ctable ctex ctex-faq
    cursolatex cuisine
    currfile currvita curve curve2e curves
    custom-bib cutwin cv cweb-latex cyklop cyrillic cyrplain
  dancers dashbox dashrule dashundergaps datatool
    dateiliste datenumber datetime
    dblfloatfix dcpic de-macro decimal decorule dehyph-exptl dejavu
    delim delimtxt dhua
    diagbox diagmac2 dialogl diagnose dice dichokey dictsym digiconfigs din1505
    dinat dinbrief dingbat directory dirtree dirtytalk disser dk-bib dlfltxb
    dnaseq doc-pictex docmfp docmute documentation doi doipubmed
    dosepsbin dot2texi dotarrow dotseqn dottex
    doublestroke dowith download dox dozenal dpfloat dprogress drac draftcopy
    draftwatermark dramatist dratex drawstack droid droit-fr drs drv
    dtk dtxgallery dtxgen
    dtxtut duerer duerer-latex duotenzor dutchcal
    dvdcoll dvgloss dviasm dviincl dvipdfmx-def
    dvipsconfig dynblocks dyntree
  ean ean13isbn easy easy-todo easyfig easylist
    ebezier ebgaramond ebong ebook ebsthesis
    ec ecc ecclesiastic ecltree eco
    ecv ed edfnotes edmac edmargin ednotes eemeir eepic egameps
    egplot eiad eiad-ltx eijkhout einfuehrung ejpecp
    elbioimp electrum eledform eledmac ellipsis elmath elpres elsarticle
    elteikthesis eltex elvish
    emarks embedall embrac emptypage emulateapj emp
    encxvlna endfloat endheads endiagram endnotes
    engpron engrec engtlc enigma enotez
    enumitem enumitem-zref envbig environ envlab
    epigrafica epigram epigraph epiolmec eplain
    epsdice epsf epsincl epslatex-fr epspdf epspdfconversion epstopdf
    eqell eqlist eqname eqnarray eqparbox errata esami es-tex-faq
    erdc esdiff esint esint-type1 esk eskd eskdx eso-pic esstix esvect
    estcpmm
    etaremune etex-pkg etextools ethiop ethiop-t1 etoc etoolbox etoolbox-de
    euenc eukdate
    euler eulervm euro euro-ce europecv eurosym
    everyhook everypage
    exam examdesign examplep exceltex excludeonly exercise exp-testopt
    expdlist expex export expressg exsheets exsol extarrows exteps
    extpfeil extract extsizes
  facsimile factura facture faktor
    fancybox fancyhdr fancyhdr-it fancynum fancypar
    fancyref fancytabs fancytooltips fancyvrb fandol
    FAQ-en fast-diagram fbb fbithesis fbs fcltxdoc fdsymbol featpost fenixpar
    feupphdteses feyn feynmf feynmp-auto fge
    fifinddo-info fig4latex figbas figbib figflow figsize
    filecontents filedate filehook fileinfo filemod
    findhyph fink finstrut first-latex-doc
    fix2col fixfoot fixlatvian fixltxhyph fixme fixmetodonotes fixpdfmag
    fjodor
    flabels flacards flagderiv flashcards flashmovie flipbook flippdf
    float floatflt floatrow
    flowchart flowfram fltpoint
    fmp fmtcount
    fn2end fnbreak fncychap fncylab fnpara fnpct fntproof fnumprint
    foekfont foilhtml fonetika
    fontawesome font-change fontaxes fontbook fontch fontinst fontools
    fonts-tlwg fontspec fonttable fontwrap
    footbib footmisc footnotebackref footnoterange footnpag
    forarray foreign forest forloop formlett formular 
    fouridx fourier fouriernc
    fp fpl
    fragmaster fragments frame framed francais-bst frankenstein frcursive
    frege frenchle frletter frontespizio ftcap ftnxtra
    fullblck fullwidth functan fundus-calligra fundus-cyr fundus-sueterlin fwlw
  g-brief gaceta galois gamebook garrigues gastex gatech-thesis gates gauss
    gb4e gcard gchords gcite geschichtsfrkl genealogy gene-logic
    genmisc genmpage gentium-tug gentle geometry geometry-de
    german germbib germkorr getfiledate getoptk
    gfsartemisia gfsbaskerville gfsbodoni gfscomplutum gfsdidot gfsneohellenic
    gfsporson gfssolomos
    ghab gillcm gillius gincltex ginpenc gitinfo
    gloss glossaries gmdoc gmdoc-enhance
    gmiflink gmp gmutils gmverb gmverse gnuplottex go gost
    gradientframe grafcet graphics graphics-pln
    graphicx-psmin graphviz greek-fontenc greek-inputenc
    greekdates greektex greenpoint grfpaste
    grid grid-system gridset gtl gtrcrd gu guitar guitarchordschemes guitlogo
  hacm hands hanging hanoi happy4th har2nat hardwrap harmony harnon-cv harpoon
    harvard harveyballs harvmac hatching hausarbeit-jura
    hc he-she hep hepnames
    hepparticles hepthesis hepunits here hexgame hf-tikz hfbright hfoldsty
    hhtensor histogr historische-zeitschrift hitec hletter
    hobby hobete horoscop hpsdiss hrefhide hrlatex hvfloat hvindex
    hypdvips hyper hypernat hyperref hyperxmp hyph-utf8 hyphen-base 
    hyphenat hyphenex hyplain
  ibycus-babel ibygrk icsv idxcmds idxlayout ieeepes
    ifetex ifmslide ifmtarg ifnextok ifoddpage ifplatform ifsym
    iftex ifthenx ifxetex
    iitem ijmart ijqc
    imac image-gallery imakeidx impatient impatient-fr
    impnattypo import imsproc imtekda
    incgraph inconsolata index initials inlinebib inlinedef
    inputtrc insbox installfont
    interactiveworkbook interfaces interpreter interval intro-scientific
    inversepath invoice
    ionumbers iopart-num ipaex ipaex-type1 iso
    iso10303 isodate isodoc isomath isonums isorot isotope issuulinks itnumpar
    iwhdp iwona
  jablantile jamtimes japanese japanese-otf japanese-otf-uptex
    jfontmaps jknapltx jlabels jmlr jneurosci jpsj jsclasses junicode
    jura juraabbrev jurabib juramisc jurarsp js-misc jvlisting
  kantlipsum karnaugh kastrup kdgdocs kerkis kerntest
    keycommand keyreader keystroke keyval2e kix kixfont
    knitting knittingpattern knuth
    koma-moderncvclassic koma-script koma-script-examples koma-script-sfs
    kotex-oblivoir kotex-plain kotex-utf kotex-utils
    kpfonts ksfh_nat
    ktv-texdata kurier
  l2picfaq l2tabu l2tabu-english l2tabu-french l2tabu-italian l2tabu-spanish
    l3kernel l3packages l3experimental
    labbook labelcas labels lambda-lists langcode lapdf lastpage
    latex latex-bib-ex latex-brochure latex-course latex-doc-ptr latex-fonts
    latex-git-log latex-graphics-companion latex-notes-zh-cn
    latex-referenz latex-tabellen
    latex-tds latex-veryshortguide latex-web-companion
    latex2e-help-texinfo latex2e-help-texinfo-spanish latex2man
    latex4wp latex4wp-it
    latexcheat latexcheat-esmx latexcheat-ptbr
    latexdiff latexfileinfo-pkgs latexfileversion latexmk latexmp latexpand
    lato layaureo layouts lazylist
    lcd lcg lcyw leading leaflet lecturer ledmac leftidx leipzig lengthconvert
    lettre lettrine levy lewis lexikon lfb lgreek lh lhcyr lhelp
    libertine
    libgreek librarian librebaskerville librecaslon
    libris lilyglyphs limap linearA linegoal
    lineno linguex
    lipsum lisp-on-tex
    listbib listing listings listings-ext listliketab listofsymbols
    lithuanian liturg lkproof lm lm-math lmake
    locality localloc logbox logical-markup-utils logicpuzzle logpap logreq
    longnamefilelist loops lpic lplfitch lps lsc
    lshort-bulgarian lshort-chinese lshort-czech lshort-dutch lshort-english
    lshort-finnish lshort-french lshort-german lshort-italian
    lshort-japanese lshort-korean lshort-mongol lshort-persian
    lshort-polish lshort-portuguese lshort-russian lshort-slovak
    lshort-slovenian lshort-spanish lshort-thai lshort-turkish lshort-ukr
    lshort-vietnamese lstaddons ltablex ltabptch
    ltxdockit ltxfileinfo ltxindex ltxkeys ltxmisc ltxnew ltxtools
    lua-alt-getopt lua-check-hyphen lua-visual-debug
    lua2dox luabibentry luabidi luacode
    luaindex luainputenc luaintro lualatex-doc lualatex-doc-de
    lualatex-math lualibs
    luamplib luaotfload
    luasseq luatexbase luatexja luatexko luatextra luaxml
    lxfonts ly1
  m-tx macros2e macroswap mafr magaz mailing mailmerge
    makebarcode makebox makecell makecirc makecmds makedtx makeglos makeplot
    makeshape mandi manuscript margbib
    marginfix marginnote marvosym
    matc3 matc3mem match_parens
    math-e mathabx mathabx-type1 mathalfa mathastext
    mathcomp mathdesign mathdots mathexam
    mathmode mathspec mathspic mattens maybemath mbenotes
    mcaption mceinleger mcite mciteplus
    mdframed mdputu mdsymbol mdwtools media9 meetingmins memdesign memexsupp
    memoir MemoirChapStyles memory mentis
    menu menukeys
    metafont-beginners metago metalogo metaobj metaplot
    metapost-examples metatex metauml
    method metre metrix
    mf2pt1 mfnfss mfpic mfpic4ode mftinc mh mhchem
    mhequ microtype microtype-de midnight midpage mil3 miller
    minibox minifp minipage-marginpar miniplot minitoc
    minted mintspirit minutes
    mkgrkindex mkjobtexmf mkpattern
    mla-paper mlist mmap mnotes mnsymbol
    moderncv moderntimeline modiagram modref modroman mongolian-babel
    monofill montex
    moreenum morefloats morehype moresize
    moreverb morewrites movie15 mp3d mparhack mpattern mpcolornames mpgraphics
    mpman-ru mptopdf ms msc msg mslapa msu-thesis mtgreek
    multenum multibbl multibib multibibliography
    multicap multienv multiexpand multirow
    multido multiobjective munich musixguit
    musixtex musixtex-fonts musuos muthesis
    mversion mwcls mwe mweights mxedruli
    mychemistry mycv mylatexformat
  nag nameauth namespc nanumtype1 natbib nath nature navigator
    ncclatex ncctools
    nddiss needspace nestquot neuralnetwork
    newcommand newenviron newfile newlfm newpx newsletr newspaper
    newtx newunicodechar newvbtm
    newverbs nextpage
    nfssext-cfr niceframe nicefilelist nicetext nih nkarta nlctdoc
    noconflict noindentafter noitcrul nolbreaks
    nomencl nomentbl nonfloat nonumonpart nopageno nostarch notes
    notes2bib notoccite nowidow nox
    nrc ntgclass ntheorem ntheorem-vn nuc
    numberedblock numericplots numname numprint
  oberdiek objectz ocg-p ocgx ocherokee ocr-b ocr-b-outline ocr-latex octavo
    odsfile ofs
    ogham oinuit oldlatin oldstandard oldstyle
    onlyamsmath onrannual opcit opensans opteng optional
    ordinalpt orkhun oscola ot-tableau othello othelloboard
    oubraces outline outliner outlines overpic
  pacioli pagecolor pagecont pagenote pagerange pageslts
    paper papercdcase papermas papertex
    paracol paralist parallel paratype
    paresse parnotes parrun parselines parskip passivetex 
    patch patchcmd patgen2-tutorial path pauldoc pawpict pax
    pbox pb-diagram pbsheet
    pdf14
    pdf-trans pdfcomment pdfcprot pdfcrop pdfjam pdfmarginpar
    pdfpages pdfscreen pdfslide pdfsync pdftex-def pdftricks pdftricks2 pdfx
    pecha pedigree-perl perception perltex
    permute persian-bib persian-modern
    petiteannonce petri-nets pfarrei
    pgf pgf-blur pgf-soroban pgf-umlsd pgfgantt pgfkeyx pgfmolbio
    pgfopts pgfplots
    phaistos philex philokalia philosophersimprint
    phonetic phonrule photo physics physymb piano picinpar pict2e
    pictex pictex2 pictexsum piechartmp piff pigpen
    pinlabel pitex pittetd pkfix pkfix-helper pkuthss placeins placeins-plain
    plain-doc plainpkg plari plantslabels plates play plipsum
    plnfss plstmary plweb pmgraph pmx pnas2009
    poemscol poetrytex polski poltawski
    polyglossia polynom polynomial
    polytable postcards poster-mac powerdot powerdot-FUBerlin
    ppr-prv pracjourn preprint prerex present presentations presentations-en
    prettyref preview printlen proba probsoln procIAGssymp
    prodint productbox program
    progress progressbar proposal properties protex protocol przechlewski-book
    psbao pseudocode psfrag psfrag-italian psfragx
    psgo psizzl pslatex psnfss pspicture
    pst-2dplot pst-3d pst-3dplot pst-abspos pst-am pst-asr pst-bar
    pst-barcode pst-bezier pst-blur pst-bspline
    pst-calendar pst-circ pst-coil pst-cox pst-dbicons pst-diffraction
    pst-electricfield pst-eps pst-eucl pst-eucl-translation-bg pst-exa
    pst-fill pst-fit pst-fr3d pst-fractal pst-fun pst-func
    pst-gantt pst-geo pst-gr3d pst-grad pst-graphicx
    pst-infixplot pst-jtree pst-knot pst-labo pst-layout
    pst-lens pst-light3d pst-magneticfield pst-math pst-mirror pst-node
    pst-ob3d pst-ode pst-optexp pst-optic
    pst-osci pst-pad pst-pdgr pst-platon pst-plot pst-poly pst-pdf pst-pulley
    pst-qtree pst-rubans
    pst-sigsys pst-slpe pst-solarsystem pst-solides3d pst-soroban pst-spectra
    pst-stru pst-support pst-text pst-thick pst-tools pst-tree pst-tvz pst-uml
    pst-vectorian pst-vowel pst-vue3d
    pst2pdf pstool pstricks pstricks-add pstricks-examples
    pstricks-examples-en pstricks_calcnotes
    psu-thesis ptex2pdf ptext ptptex punk punk-latex punknova purifyeps pxbase
    pxchfon pxcjkcat pxfonts pxgreeks pxjahyper
    pxpgfmark pxrubrica pxtxalfa python pythontex
  quattrocento qcm qobitree quoting qstest qsymbols qtree quotchap quotmark
  r_und_s raleway ran_toks randbild randomwalk randtext
    rccol rcs rcs-multi rcsinfo
    readarray realboxes realscripts rec-thy recipe recipecard recycle rectopma
    refcheck refman refstyle regcount regexpatch register regstats
    relenc relsize reotex repeatindex resphilosophica
    resumecls resumemac reverxii revtex
    ribbonproofs rjlparshap rlepsf rmpage
    robustcommand robustindex romanbar romande romanneg romannum
    rotating rotfloat rotpages roundbox
    rrgtrees rsc rsfs rsfso
    rterface rtkinenc rtklage ruhyphen russ rviewport rvwrite ryethesis
  sa-tikz sageep sansmath sansmathaccent sansmathfonts
    sapthesis sasnrdisplay sauerj
    sauterfonts savefnmark savesym savetrees
    scale scalebar scalerel schemabloc schemata schulschriften schwalbe-chess
    sciposter screenplay scrjrnl
    sdrt
    secdot section sectionbox sectsty selectp selnolig semantic semaphor
    seminar semioneside sepfootnotes sepnum seqsplit
    serbian-apostrophe serbian-date-lat serbian-def-cyr serbian-lig
    setdeck setspace seuthesis
    sf298 sffms sfg
    sfmath sgame shade shadethm shadow shadowtext shapepar
    shipunov shorttoc
    show2e showcharinbox showdim showexpl showhyphens showlabels showtags
    shuffle
    sidecap sidenotes sides silence
    simplecd simplecv simplewick simplified-latex simurgh
    sitem siunitx
    skak skaknew skb skdoc skeycommand skeyval skmath skrapport skull
    slantsc slideshow smalltableof smartdiagram smartref
    snapshot snotez
    songbook songs sort-by-letters soton soul sourcecodepro sourcesanspro
    spanglish spanish-mx sparklines spath3 spelling spie
    sphack splines splitbib splitindex spot spotcolor spreadtab spverbatim
    srbook-mem srcltx sseq
    stack stackengine stage standalone starfont statistik statex statex2 staves
    stdclsdv stdpage steinmetz
    stellenbosch stex stix stmaryrd storebox storecmd stringstrings struktex
    sttools stubs sty2dtx suanpan subdepth subeqn subeqnarray
    subfig subfigmat subfigure subfiles subfloat substances
    substitutefont substr subsupscripts
    sudoku sudokubundle suftesi sugconf
    superiors supertabular susy svg svg-inkscape svgcolor
    svn svn-multi svn-prov svninfo
    swebib swimgraf syllogism syntax synproof syntrace synttree
    systeme
  t-angles t2
    tabfigures tableaux tablefootnote tablists tableof tablor tabls
    tabriz-thesis tabto-generic tabto-ltx
    tabu tabularborder tabularcalc tabularew
    tabulars-e tabulary tabvar tagging talk tamefloats
    tamethebeast tap tapir tcldoc tcolorbox tdclock tdsfrmath
    technics ted templates-fenn templates-sommer tengwarscript
    tensor termcal termlist teubner
    tex-ewd tex-font-errors-cheatsheet tex-gyre tex-gyre-math
    tex-label tex-overview tex-refs
    texapi texbytopic texcount
    texdef texdiff texdirflatten texdraw texilikechaps texilikecover
    texliveonfly texloganalyser texlogos texmate texments
    texpower texshade
    textcase textfit textglos textgreek textmerg textopo textpath textpos
    tfrupee thalie theoremref thesis-titlepage-fhac
    thinsp thmbox thmtools threadcol threeddice threeparttable threeparttablex
    thumb thumbpdf thumbs thumby thuthesis
    ticket
    tikz-bayesnet tikz-cd tikz-3dplot tikz-dependency tikz-inet
    tikz-qtree tikz-timing
    tikzinclude tikzmark tikzorbital
    tikzpagenodes tikzpfeile tikzposter tikzscale tikzsymbols
    timetable timing-diagrams tipa tipa-de
    titlecaps titlefoot titlepages titlepic titleref titlesec titling
    tkz-base tkz-berge tkz-doc tkz-euclide tkz-fct tkz-graph
    tkz-kiviat tkz-linknodes tkz-orm tkz-tab
    tlc2
    tocbibind tocloft tocvsec2 todo todonotes
    tokenizer toolbox tools topfloat totcount totpages toptesi
    tpslifonts tqft
    trajan tram
    translation-array-fr
    translation-arsclassica-de translation-biblatex-de translation-chemsym-de
    translation-dcolumn-fr
    translation-ecv-de translation-enumitem-de translation-europecv-de
    translation-filecontents-de translation-moreverb-de
    translation-natbib-fr translation-tabbing-fr
    translations
    tree-dvips treetex trfsigns trimspaces trivfloat trsym truncate
    tsemlines
    tucv tufte-latex tugboat tugboat-plain tui turkmen turnstile turnthepage
    twoinone twoup
    txfonts txfontsb txgreeks
    type1cm typeface typehtml typeoutfileinfo typogrid
  uaclasses uadocs uafthesis ucharclasses ucdavisthesis ucs
    ucthesis udesoftec uebungsblatt uestcthesis uiucredborder uiucthesis
    ukrhyph ulem ulqda ulthese
    umich-thesis uml umlaute umoline
    umthesis umtypewriter
    unamthesis underlin underoverlap underscore undolabl
    uni-wtal-ger uni-wtal-lin unicode-math unisugar units unitsdef universa
    unravel unswcover
    uothesis uowthesis uowthesistitlepage upca upmethodology upquote
    uri url urlbst urwchancal usebib ushort uspatent
    ut-thesis uwmslide uwthesis
  vak vancouver variations varindex varisize
    varsfromjobname varwidth vaucanson-g vdmlisting
    velthuis venn venndiagram venturisadf
    verbasef verbatimbox verbatimcopy verbdef
    verbments verse version versions vertbars
    vhistory visualfaq vmargin vntex vocaltract volumes vpe vruler vwcol
  wadalab wallpaper warning warpcol was wasysym webguide
    widetable williams withargs
    wnri wnri-latex wordlike
    wrapfig wsemclassic wsuipa
  xargs xcite xcjk2uni xcolor xcomment xcookybooky xdoc
    xecjk xecolor xecyr xeindex xepersian xesearch
    xetex-def xetex-devanagari xetex-itrans xetex-pstricks xetex-tibetan
    xetexfontinfo xetexko
    xetexref xevlna xfor xgreek xhfill
    xii xifthen xint xits
    xkeyval xlop xltxtra xmpincl xnewcommand
    xoptarg xpatch xpeek xpicture xpinyin xpunctuate
    xq xskak xstring xtab xunicode
    xwatermark xyling xypic xypic-tut-pt xytree
  yafoot yagusylo yannisgr yax ydoc yfonts yhmath
   york-thesis youngtab yplan ytableau
  zed-csp zhnumber ziffer zhmetrics zhspacing zwgetfdate zwpagelayout
    zxjafbfont zxjafont zxjatype
); 


# these packages we do not expect to check.  Once this list is complete,
# we can start working on tlmgr list | grep shortdesc.
my @TLP_no_check = (
  "afm2pl",		# not on CTAN
  "aleph",		# binary
  "asymptote",		# binary
  "bibtex",		# binary
  "bibtex8",		# binary
  "bibtexu",		# binary
  "c90",		# part of cjk
  "chktex",		# binary
  "cjkutils",		# binary
  "cns",		# part of cjk
  "context",		# binary+taco
  "cs",			# multiple .tar.gz, too painful to unpack
  "ctib",		# binary
  "ctie",		# binary
  "cweb",		# binary
  "cyrillic-bin",	# binary
  "detex",		# binary
  "devnag",		# binary
  "dnp",		# part of cjk
  "dtl",		# binary
  "dvi2tty",		# binary
  "dvicopy",		# binary
  "dvidvi",		# binary
  "dviljk",		# binary
  "dvipdfm",		# binary
  "dvipdfmx",		# binary
  "dvipng",		# binary
  "dvipos",		# binary
  "dvips",		# binary
  "dvisvgm",		# binary
  "enctex",		# binary
  "etex",		# binary
  "finbib",		# not on CTAN
  "fontname",		# tl-update-auto
  "fontware",		# binary
  "garuda-c90",		# part of cjk
  "glyphlist",		# not on CTAN, handled in tlpkg/dev/srclist.txt
  "gnu-freefont",	# no files to compare, distributed as tarballs
  "groff",		# binary
  "gsftopk",		# binary
  "gustlib",		# not on CTAN, requested from GUST
  "gustprog",		# not on CTAN, GUST
  "guide-to-latex",	# not on CTAN, book examples, ok
  "hyperref-docsrc",	# not on CTAN, awaiting hyperref doc volunteer
  "ifluatex",		# part of oberdiek
  "jadetex",		# too old to owrry about
  "jmn",		# part of context
  "kluwer",		# not on CTAN, old LPPL, not worth pursuing or removing
  "kpathsea",		# binary
  "lacheck",		# binary
  "lambda",		# not on CTAN, too old to worry about
  "latex-bin",		# binary
  "latexconfig",	# we maintain
  "lcdftypetools",	# binary
  "luatex",		# binary
  "makeindex",		# binary
  "metafont",		# binary
  "metapost",		# binary
  "mex",		# GUST, requested 2013
  "mfware",		# binary
  "mltex",		# binary
  "norasi-c90",		# part of cjk
  "omega",		# binary
  "omegaware",		# binary
  "otibet",		# not on CTAN, too old to worry about
  "patgen",		# binary
  "pdftex",		# binary
  "pdftools",		# binary
  "pdfwin",		# not on CTAN, too old to worry about
  "powerdot",		# stale generated files on CTAN
  "ps2pkm",		# binary
  "pst-ghsb",		# not on CTAN, replaced by pst-slpe, keep for compat
  "pstools",		# binary
  "psutils",		# binary
  "ptex",		# binary
  "qpxqtx",		# GUST, requested feb 2013
  "revtex4",		# APS declines to keep compatibility, but we have to
  "roex",		# GUST, requested 2012
  "seetexk",		# binary
  "synctex",		# binary
  "t1utils",		# binary
  "tetex",		# our sources
  "tex",		# binary
  "tex-virtual-academy-pl",# GUST, requested 2012
  "tex4ht",		# binary
  "texconfig",		# our sources
  "texdoc",		# binary
  "texinfo",		# tl-update-auto
  "texlive.infra",	# binary
  "texsis",		# too old to worry about
  "texware",		# binary
  "texworks",		# binary
  "tie",		# binary
  "ttfutils",		# binary
  "tpic2pdftex",	# CTAN mirrors from us
  "uptex",		# binary
  "vlna",		# binary
  "web",		# binary
  "xdvi",		# binary
  "xetex",		# binary
  "xetexconfig",	# our sources
  "xindy",		# binary
);

exit (&main ());


sub main {
  chomp ($Master = `cd $mydir/../.. && pwd`);
  $tlpdb = TeXLive::TLPDB->new ("root" => $Master);
  die "Cannot find tlpdb in $Master!" unless defined $tlpdb;

  $OPT{"verbose"} = 0;
  if ($ARGV[0] eq "--verbose" || $ARGV[0] eq "-v") {
    $OPT{"verbose"} = 1;
    shift @ARGV;
  }
  
  $OPT{"all"} = 0;
  if ($ARGV[0] eq "--all") {
    $OPT{"all"} = 1;
    shift @ARGV;
  }
  
  $OPT{"no-clean"} = 0;
  if ($ARGV[0] eq "--no-clean") {
    $OPT{"no-clean"} = 1;
    shift @ARGV;
  }
  
  if ($ARGV[0] eq "--list-not-treated") {
    my @not_checked = ();
    for my $b (&normal_tlps ()) {
      if (! grep ($b eq $_, @TLP_working, @TLP_no_check)) {
        push (@not_checked, $b);
      }
    }
    print "" . (@not_checked+0) . " TL packages not checked against CTAN:\n";
    print "@not_checked\n";
    @ARGV = (); # no normal checks

  } elsif ($ARGV[0] eq "--check") {
    # check all/only those packages we have actually run through this mill.
    @ARGV = @TLP_working;
  } elsif ($ARGV[0] eq "--check-all") {
    @ARGV = &normal_tlps ();
  }

  my $errcount = 0;
  for my $tlp (@ARGV) {
    print "checking $tlp..." if $OPT{"verbose"};
    $errcount += &do_tlp ($tlp);
  }
  return $errcount;
}

# gives a list with only the 'normal' packages,
# that is, excluding meta-packages and binary packages
# (and hyphen for the moment)
# 
sub normal_tlps {
  my @normal;
  my $non_normal = `ls $Master/bin`;
  $non_normal =~ s/\n/\$|/g;
  $non_normal .= '^0+texlive|^bin-|^collection-|^scheme-|^texlive-|^hyphen-';
  foreach ($tlpdb->list_packages) {
    push (@normal, $_) unless (/$non_normal/);
  }
  return @normal;
}


# Return 1 if package TLPN needs updating (or error), 0 if ok.
# 
sub do_tlp {
  my ($tlpn) = @_;
  my $needed = 0;
  
  my $tlp = $tlpdb->get_package($tlpn);
  if (!defined($tlp)) {
    warn "$0: no package $tlpn\n";
    return 1;
  }

  chomp (my $ctan_dir = `$mydir/tlpkginfo --prepare '$tlpn'`);
  if (! $ctan_dir) {
    warn "$0: oops, no CTAN directory for $tlpn, fix fix\n";
    return 1;
  }
  # csplain and cslatex have .tar.gz's that need to be unpacked for
  # comparison.  (perhaps this should be done in tlpkginfo.)  but don't
  # do any unpacking inside the ctan hierarchy.
  chomp (my $ctan_root = `$mydir/tlpkginfo --ctan-root`);
  if ($ctan_dir !~ m,^$ctan_root,) {
    for my $tgz (glob ("$ctan_dir/*.tar.gz")) {
      system ("tar -C $ctan_dir -xf $tgz");
    }
  }
  
  # One more total kludge.  We should probably put this into tlpkginfo
  # and factor it out from here and ctan2tds.
  if ($tlpn eq "cs") {
    $TMPDIR = $ENV{"TMPDIR"} || "/tmp";
    my $pkgdir = "$TMPDIR/tl.$pkgname";
    system ("rm -rf $pkgdir");
    mkdir ($pkgdir, 0777) || die "mkdir($pkgdir) failed: $!";
    #
    # unpack the multiple constituent tarballs.
    for my $tarbase ("csfonts-t1", "csfonts", "cspsfonts") {
      system ("tar -C $pkgdir -xf $ctan_dir/$tarbase.tar.gz");
    }
    # look in the new dir we just created.
    $ctan_dir = $pkgdir;
  }

  my @tl_files = ();
  push @tl_files, $tlp->runfiles;
  push @tl_files, $tlp->docfiles;
  push @tl_files, $tlp->srcfiles;
  if ($tlp->relocated) { for (@tl_files) { s:^$RelocPrefix/:$RelocTree/:; } }
  # we don't push bin files.
  my @tl_basefiles = ();  # compare with CTAN after the loop
    
  my @compared = ();
  for my $file (@tl_files) {
    (my $basefile = $file) =~ s,^.*/,,;
    
    # if file exists by multiple names in TL (e.g., README), only check
    # the first one we come across, since we'll only find the first one
    # on CTAN and we don't want to try to match subdir suffixes.
    next if grep { $_ eq $basefile } @tl_basefiles;
#warn "checking tl file $file -> $basefile\n";
    push (@tl_basefiles, $basefile);

    # No point in comparing our pdfs now, too many are different.
    # However, for lshort translations and mathdesign, pdf can be
    # all we have to compare.
    next if $file =~ /\.pdf$/ && $file !~ /short|mathdesign/;
    
    # tlc2.err on CTAN and lb2.err in TL are stale.  I don't understand,
    # but anyway, not worth updating the package just for this.  Get
    # right at the next latex update.  --karl, 27aug12.
    next if $file =~ m,/(lb2|tlc2).err$,;

    # knuth.tds.zip (from latex-tds) is wrong wrt to the actual
    # originals, which we installed by hand.  Don't check them until fixes.
    next if $file =~ m,/(mf84.bug|tex82.bug|errorlog.tex)$,;
    
    # Lowercase readme wrongly matched against uppercase README in musixtex.
    next if $basefile eq "readme";
    
    # Wrong README gets compared.
    next if $basefile eq "README" && $file =~ m,/(pmx|cs)/,;
    
    # We install our own stub, not ConTeXt's.  I guess.
    next if $basefile eq "mptopdf.exe";
    
    my $tl_file = "$Master/$file";
    if (! -e $tl_file) {
      warn "$tl_file: TL file missing\n";
      next;
    }
    
    chomp (my @ctan_files = `find $ctan_dir/ -name $basefile`);
#warn "ctan find $basefile: @ctan_files\n";
    # the trailing / is so we dereference a symlink on CTAN.
    next if @ctan_files > 1; # if more than one file by same name, skip

    my $ctan_file = $ctan_files[0];
#warn "ctan file is $ctan_file\n";
    if (! -e $ctan_file) {
      # maybe it'll be there with a case change in the name
      chomp (@ctan_files = `find $ctan_dir/ -iname $basefile`);
#warn "ctan ifind $basefile: @ctan_files\n";
      next if @ctan_files > 1; # if more than one file by same name, skip
      $ctan_file = $ctan_files[0];
      
      if (! -e $ctan_file) {
        # we generate lots of files, eg perlmacros.sty, so might skip.
        warn "$ctan_file: CTAN file missing\n"
          if $ctan_file && $ctan_file !~ /(cfg|dvi|sty|tex)$/;
        next;
      }
    }

    push (@compared, $basefile);
    if (&files_differ ($tl_file, $ctan_file)) {
      print "# $tlpn\ndiff $ctan_file $tl_file\n";
      $needed = 1;
      last unless $OPT{"all"};
    }
  }
  
  # unfortunately, we cannot do this.  There are many PDF's on CTAN
  # which have no sources or otherwise problematic for TL.  Perhaps one
  # day we could use the %moreclean hash from ctan2tds as an additional
  # filter, i.e., put all those ctan2tds tables in an external file.
  # 
  # # check for PDF files on CTAN that we don't have.
  # my @ctan_pdf_needed = ();
  # chomp (my @ctan_files = `find $ctan_dir -name \*.pdf`);
  # for my $cfile (@ctan_files) {
  #   (my $base_cfile = $cfile) =~ s,^.*/,,;
  #   if (! grep { $_ eq $base_cfile } @tl_basefiles) {
  #     push (@ctan_pdf_needed, $base_cfile);
  #   }
  # }
  # if (@ctan_pdf_needed) {
  #   if (! $needed) {
  #     # if this is the first thing needed (no diffs), print package name.
  #     print "# $tlpn\n";
  #     $needed = 1;
  #   }
  #   print "# new on ctan: @ctan_pdf_needed\n";
  # }
  
  if (@compared == 0) {
    warn "\n$tlpn: no files to compare in $ctan_dir, fixme!\n";
    warn "  (tl_files = @tl_files)\n";
    warn "  (ctan_files = @ctan_files)\n";
  } elsif ($needed == 0) {
    print "ok\n" if $OPT{"verbose"};
  }
  print ((@compared + 0) . " compared (@compared)\n") if $OPT{"verbose"};

  # clean up the tmpdir possibly created from tlpkginfo --prepare.
  chomp (my $ctan_root = `$mydir/tlpkginfo --ctan-root`);
  if ($ctan_dir !~ m,^$ctan_root, && ! $OPT{"no-clean"}) {
    system ("rm -rf $ctan_dir");
  }

  return $needed;
}



# 0 if files are the same, 1 if they are different.
# 
sub files_differ {
  my ($tl_file,$ctan_file) = @_;
#warn "comparing $ctan_file $tl_file\n";
  return system ("$mydir/cmp-textfiles $ctan_file $tl_file");
}

# vim: set ts=8 sw=2 expandtab:
