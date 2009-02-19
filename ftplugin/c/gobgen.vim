" Vim GObject generator plugin
" Last Change: 2007 Nov 6
" Maintainer: Andrey Dubravin <daa84@inbox.ru>
" License: This file is placed in the public domain.

if exists("loaded_gobgen")
    finish
endif
let loaded_gobgen = 1

function! GOBGetPrefix()
    let prefix = expand("%:t:r")
    return input("Enter object prefix name (e.g. flybird-directory):", prefix)
endfunction

function! s:GOBGenerateCConstAndDest(prefix, typeName, typeNamePrivate, defineName)
    normal o
    exec "normal ostruct _" . a:typeNamePrivate "{"
    normal o};

    normal 2o

    " dispose
    normal ostatic void
    exec "normal o" . a:prefix . "_dispose (" . a:typeName "*self)"
    normal o{
    normal o}
    normal o

    " finalize
    normal ostatic void
    exec "normal o" . a:prefix . "_finalize (" . a:typeName "*self)"
    normal o{
    normal o}
    normal o

    " init
    normal ostatic void
    exec "normal o" . a:prefix . "_init (" . a:typeName "*self)"
    normal o{
    exec "normal o" . a:typeNamePrivate "*priv;"
    normal o
    exec "normal opriv =" a:defineName . "_GET_PRIVATE (self);"
    normal o}
    normal o

    " class init
    normal ostatic void
    exec "normal o" . a:prefix . "_class_init (" . a:typeName . "Class *self_class)"
    normal o{

    normal oGObjectClass *object_class = G_OBJECT_CLASS (self_class);
    normal o
    exec "normal og_type_class_add_private (self_class, sizeof (" . a:typeNamePrivate . "));"

    exec "normal oobject_class->dispose = (void (*) (GObject *object))" a:prefix . "_dispose;"
    exec "normal oobject_class->finalize = (void (*) (GObject *object))" a:prefix . "_finalize;"

    normal o}
    normal o
endfunction

function! GOBGenerateCModule()
    let prefix = GOBGetPrefix()

    if prefix == ""
	echohl ErrorMsg
	echo "Can't create class without prefix"
	echohl None
	return
    endif

    let prefix = substitute(prefix, "-", "_", "g")

    let typeName = substitute(prefix, "_\\(.\\)\\|^\\(.\\)", "\\U\\1\\U\\2", "g")
    let typeNamePrivate = typeName . "Private"

    let defineName = toupper(prefix)

    exec "normal ostatic GType" prefix . "_type = 0;"
    normal o

    call s:GOBGenerateCConstAndDest (prefix, typeName, typeNamePrivate, defineName)

    normal ovoid
    exec "normal o" . prefix . "_register_type (GTypeModule *module)"
    normal o{
    normal ostatic const GTypeInfo info = {
    exec "normal osizeof (" . typeName . "Class),"
    normal oNULL,
    normal oNULL,
    exec "normal o(GClassInitFunc)" prefix . "_class_init,"
    normal oNULL,
    normal oNULL,
    exec "normal osizeof (" . typeName . "),"
    normal o0,
    exec "normal o(GInstanceInitFunc)" prefix . "_init,"
    normal o};
    normal o

    exec "normal o" . prefix . "_type = g_type_module_register_type (module,"
    normal oG_TYPE_OBJECT,
    exec "normal o\"" . typeName . "\","
    normal o&info, 0);

    normal o}
    normal o

    normal oGType
    exec "normal o" . prefix . "_get_type ()"
    normal o{
    exec "normal oreturn" prefix . "_type;"
    normal o}
    normal o
endfunction


function! GOBGenerateC()
    let prefix = GOBGetPrefix()

    if prefix == ""
	echohl ErrorMsg
	echo "Can't create class without prefix"
	echohl None
	return
    endif

    let prefix = substitute(prefix, "-", "_", "g")

    let typeName = substitute(prefix, "_\\(.\\)\\|^\\(.\\)", "\\U\\1\\U\\2", "g")
    let typeNamePrivate = typeName . "Private"

    let defineName = toupper(prefix)

    exec "normal oG_DEFINE_TYPE (" . typeName . "," prefix . ", <ENTER_TYPE_HERE>);"
    normal o
    exec "normal o#define" defineName . "_GET_PRIVATE(o)\\"
    exec "normal o(G_TYPE_INSTANCE_GET_PRIVATE ((o)," defineName . "_TYPE," typeNamePrivate . "))"

    call s:GOBGenerateCConstAndDest (prefix, typeName, typeNamePrivate, defineName)
endfunction

function! GOBGenerateIC()
    let prefix = GOBGetPrefix()

    if prefix == ""
	echohl ErrorMsg
	echo "Can't create class without prefix"
	echohl None
	return
    endif

    let prefix = substitute(prefix, "-", "_", "g")
    let typeName = substitute(prefix, "_\\(i.\\)\\|^\\(.\\)\\|_\\(.\\)\\", "\\U\\1\\U\\2", "g")

    normal oGType
    exec "normal o" . prefix . "_get_type ()"
    normal o{
    normal ostatic GType type = 0;
    normal o
    normal oif (!type)
    normal o{
    normal ostatic const GTypeInfo info =
    normal o{
    exec "normal osizeof (" . typeName . "Interface), /*class_size*/"
    normal oNULL,		/* base_init */
    normal oNULL,		/* base_finalize */
    normal oNULL,
    normal oNULL,		/* class_finalize */
    normal oNULL,		/* class_data */
    normal o0,
    normal o0,              /* n_preallocs */
    normal oNULL
    normal o};
    normal o

    exec "normal otype = g_type_register_static (G_TYPE_INTERFACE, \"" . typeName . "\", &info, 0);"
    normal o}
    normal o
    normal oreturn type;
    normal o}

endfunction

function! GOBGenerateH()
    let prefix = GOBGetPrefix()

    if prefix == ""
	echohl ErrorMsg
	echo "Can't create class without prefix"
	echohl None
	return
    endif

    let parentName = input("Enter parent class name (Default GObject):")
    if parentName == ""
	let parentName = "GObject"
    endif

    let prefix = substitute(prefix, "-", "_", "g")

    let typeName = substitute(prefix, "_\\(.\\)\\|^\\(.\\)", "\\U\\1\\U\\2", "g")
    let typeNamePrivate = typeName . "Private"

    let defineName = toupper(prefix)

    normal IG_BEGIN_DECLS
    normal o
    exec "normal otypedef struct _" . typeNamePrivate typeNamePrivate . ";"
    normal o

    " Variable memeber structure
    normal otypedef struct {
    exec "normal o" . parentName "parent;"
    normal o
    exec "normal o" . typeNamePrivate "*priv;"
    exec "normal o}" typeName . ";"
    normal o

    normal otypedef struct {
    exec "normal o" . parentName . "Class parent;"
    exec "normal o}" typeName . "Class;"
    normal o

    " setup needed defines
    exec "normal o#define" defineName . "_TYPE (" . prefix . "_get_type ())"
    exec "normal o#define" defineName . "(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), " . defineName . "_TYPE," typeName . "))"
    exec "normal o#define" defineName . "_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), " . defineName . "_TYPE," typeName . "Class))"
    exec "normal o#define IS_" . defineName . "(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), " . defineName . "_TYPE))"
    exec "normal o#define IS_" . defineName . "_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), " . defineName . "_TYPE))"
    exec "normal o#define" defineName . "_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), " . defineName . "_TYPE," typeName . "Class))"

    normal 3o

    normal oG_END_DECLS
endfunction

function! GOBGenerateIH()
    let prefix = GOBGetPrefix()

    if prefix == ""
	echohl ErrorMsg
	echo "Can't create class without prefix"
	echohl None
	return
    endif


    let prefix = substitute(prefix, "-", "_", "g")
    let typeName = substitute(prefix, "_\\(i.\\)\\|^\\(.\\)\\|_\\(.\\)\\", "\\U\\1\\U\\2", "g")
    let defineName = toupper(prefix)

    normal IG_BEGIN_DECLS
    normal o
    exec "normal otypedef struct _" . typeName typeName . ";"
    normal o

    normal otypedef struct {
    normal oGTypeInterface parent;
    exec "normal o}" typeName . "Interface;"
    normal o

    " setup needed defines
    exec "normal o#define" defineName . "_TYPE (" . prefix . "_get_type ())"
    exec "normal o#define" defineName . "(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), " . defineName . "_TYPE," typeName . "))"
    exec "normal o#define IS_" . defineName . "(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), " . defineName . "_TYPE))"
    exec "normal o#define" defineName . "_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), " . defineName . "_TYPE," typeName . "Class))"

    normal 3o

    normal oG_END_DECLS
endfunction

command! GOBGenerateC call GOBGenerateC()
command! GOBGenerateH call GOBGenerateH()
command! GOBGenerateCModule call GOBGenerateCModule()
command! GOBGenerateIH call GOBGenerateIH()
command! GOBGenerateIC call GOBGenerateIC()

