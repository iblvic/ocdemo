; ModuleID = 'ViewController.m'
source_filename = "ViewController.m"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-ios16.1.0"

%0 = type opaque
%1 = type opaque
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._objc_cache = type opaque
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i32*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }
%struct.__NSConstantString_tag = type { i32*, i32, i8*, i64 }
%struct._objc_super = type { i8*, i8* }
%struct.__block_descriptor = type { i64, i64 }
%struct.__block_literal_generic = type { i8*, i32, i32, i8*, %struct.__block_descriptor* }

@"OBJC_CLASS_$_ViewController" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_ViewController", %struct._class_t* @"OBJC_CLASS_$_UIViewController", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"_OBJC_CLASS_RO_$_ViewController" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_" = private global %struct._class_t* @"OBJC_CLASS_$_ViewController", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [12 x i8] c"viewDidLoad\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_ = internal externally_initialized global i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@__CFConstantStringClassReference = external global [0 x i32]
@.str = private unnamed_addr constant [9 x i8] c"array:%@\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_ = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i64 8 }, section "__DATA,__cfstring", align 8 #0
@_NSConcreteStackBlock = external global i8*
@.str.1 = private unnamed_addr constant [6 x i8] c"v8@?0\00", align 1
@"__block_descriptor_40_e8_32s_e5_v8\01?0l" = linkonce_odr hidden unnamed_addr constant { i64, i64, i8*, i8*, i8*, i64 } { i64 0, i64 40, i8* bitcast (void (i8*, i8*)* @__copy_helper_block_e8_32s to i8*), i8* bitcast (void (i8*)* @__destroy_helper_block_e8_32s to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0), i64 256 }, align 8
@"OBJC_IVAR_$_ViewController._array" = hidden global i32 8, section "__DATA, __objc_ivar", align 4
@"OBJC_IVAR_$_ViewController._completion" = hidden global i32 16, section "__DATA, __objc_ivar", align 4
@_objc_empty_cache = external global %struct._objc_cache
@"OBJC_METACLASS_$_NSObject" = external global %struct._class_t
@"OBJC_METACLASS_$_UIViewController" = external global %struct._class_t
@OBJC_CLASS_NAME_ = private unnamed_addr constant [15 x i8] c"ViewController\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@"_OBJC_METACLASS_RO_$_ViewController" = internal global %struct._class_ro_t { i32 389, i32 40, i32 40, i8* null, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* null, %struct._objc_protocol_list* null, %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_METACLASS_$_ViewController" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._class_t* @"OBJC_METACLASS_$_UIViewController", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"_OBJC_METACLASS_RO_$_ViewController" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASS_$_UIViewController" = external global %struct._class_t
@OBJC_CLASS_NAME_.2 = private unnamed_addr constant [2 x i8] c"\02\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_ = private unnamed_addr constant [8 x i8] c"v16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.3 = private unnamed_addr constant [23 x i8] c"requestWithCompletion:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.4 = private unnamed_addr constant [12 x i8] c"v24@0:8@?16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.5 = private unnamed_addr constant [6 x i8] c"array\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.6 = private unnamed_addr constant [8 x i8] c"@16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.7 = private unnamed_addr constant [10 x i8] c"setArray:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.8 = private unnamed_addr constant [11 x i8] c"v24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.9 = private unnamed_addr constant [11 x i8] c"completion\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.10 = private unnamed_addr constant [9 x i8] c"@?16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.11 = private unnamed_addr constant [15 x i8] c"setCompletion:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.12 = private unnamed_addr constant [14 x i8] c".cxx_destruct\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@"_OBJC_$_INSTANCE_METHODS_ViewController" = internal global { i32, i32, [7 x %struct._objc_method] } { i32 24, i32 7, [7 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[ViewController viewDidLoad]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.4, i32 0, i32 0), i8* bitcast (void (%0*, i8*, void ()*)* @"\01-[ViewController requestWithCompletion:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.5, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.6, i32 0, i32 0), i8* bitcast (%1* (%0*, i8*)* @"\01-[ViewController array]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @OBJC_METH_VAR_NAME_.7, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.8, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %1*)* @"\01-[ViewController setArray:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.9, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_TYPE_.10, i32 0, i32 0), i8* bitcast (void ()* (%0*, i8*)* @"\01-[ViewController completion]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.4, i32 0, i32 0), i8* bitcast (void (%0*, i8*, void ()*)* @"\01-[ViewController setCompletion:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_NAME_.12, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[ViewController .cxx_destruct]" to i8*) }] }, section "__DATA, __objc_const", align 8
@OBJC_METH_VAR_NAME_.13 = private unnamed_addr constant [7 x i8] c"_array\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.14 = private unnamed_addr constant [18 x i8] c"@\22NSMutableArray\22\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.15 = private unnamed_addr constant [12 x i8] c"_completion\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.16 = private unnamed_addr constant [3 x i8] c"@?\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_INSTANCE_VARIABLES_ViewController" = internal global { i32, i32, [2 x %struct._ivar_t] } { i32 32, i32 2, [2 x %struct._ivar_t] [%struct._ivar_t { i32* @"OBJC_IVAR_$_ViewController._array", i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.13, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_TYPE_.14, i32 0, i32 0), i32 3, i32 8 }, %struct._ivar_t { i32* @"OBJC_IVAR_$_ViewController._completion", i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @OBJC_METH_VAR_TYPE_.16, i32 0, i32 0), i32 3, i32 8 }] }, section "__DATA, __objc_const", align 8
@OBJC_PROP_NAME_ATTR_ = private unnamed_addr constant [6 x i8] c"array\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.17 = private unnamed_addr constant [31 x i8] c"T@\22NSMutableArray\22,&,N,V_array\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.18 = private unnamed_addr constant [11 x i8] c"completion\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.19 = private unnamed_addr constant [21 x i8] c"T@?,C,N,V_completion\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@"_OBJC_$_PROP_LIST_ViewController" = internal global { i32, i32, [2 x %struct._prop_t] } { i32 16, i32 2, [2 x %struct._prop_t] [%struct._prop_t { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @OBJC_PROP_NAME_ATTR_.17, i32 0, i32 0) }, %struct._prop_t { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_PROP_NAME_ATTR_.18, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @OBJC_PROP_NAME_ATTR_.19, i32 0, i32 0) }] }, section "__DATA, __objc_const", align 8
@"_OBJC_CLASS_RO_$_ViewController" = internal global %struct._class_ro_t { i32 388, i32 8, i32 24, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_CLASS_NAME_.2, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [7 x %struct._objc_method] }* @"_OBJC_$_INSTANCE_METHODS_ViewController" to %struct.__method_list_t*), %struct._objc_protocol_list* null, %struct._ivar_list_t* bitcast ({ i32, i32, [2 x %struct._ivar_t] }* @"_OBJC_$_INSTANCE_VARIABLES_ViewController" to %struct._ivar_list_t*), i8* null, %struct._prop_list_t* bitcast ({ i32, i32, [2 x %struct._prop_t] }* @"_OBJC_$_PROP_LIST_ViewController" to %struct._prop_list_t*) }, section "__DATA, __objc_const", align 8
@"OBJC_LABEL_CLASS_$" = private global [1 x i8*] [i8* bitcast (%struct._class_t* @"OBJC_CLASS_$_ViewController" to i8*)], section "__DATA,__objc_classlist,regular,no_dead_strip", align 8
@llvm.compiler.used = appending global [28 x i8*] [i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_" to i8*), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_ to i8*), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_CLASS_NAME_.2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.3, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.4, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.5, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.6, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @OBJC_METH_VAR_NAME_.7, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.8, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.9, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_TYPE_.10, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_NAME_.12, i32 0, i32 0), i8* bitcast ({ i32, i32, [7 x %struct._objc_method] }* @"_OBJC_$_INSTANCE_METHODS_ViewController" to i8*), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.13, i32 0, i32 0), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_TYPE_.14, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @OBJC_METH_VAR_TYPE_.16, i32 0, i32 0), i8* bitcast ({ i32, i32, [2 x %struct._ivar_t] }* @"_OBJC_$_INSTANCE_VARIABLES_ViewController" to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @OBJC_PROP_NAME_ATTR_.17, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_PROP_NAME_ATTR_.18, i32 0, i32 0), i8* getelementptr inbounds ([21 x i8], [21 x i8]* @OBJC_PROP_NAME_ATTR_.19, i32 0, i32 0), i8* bitcast ({ i32, i32, [2 x %struct._prop_t] }* @"_OBJC_$_PROP_LIST_ViewController" to i8*), i8* bitcast ([1 x i8*]* @"OBJC_LABEL_CLASS_$" to i8*)], section "llvm.metadata"

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[ViewController viewDidLoad]"(%0* %0, i8* %1) #1 personality i8* bitcast (i32 (...)* @__objc_personality_v0 to i8*) {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %struct._objc_super, align 8
  %6 = alloca %0*, align 8
  %7 = alloca <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %10 = load %0*, %0** %3, align 8
  %11 = bitcast %0* %10 to i8*
  %12 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %5, i32 0, i32 0
  store i8* %11, i8** %12, align 8
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %14 = bitcast %struct._class_t* %13 to i8*
  %15 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %5, i32 0, i32 1
  store i8* %14, i8** %15, align 8
  %16 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !16
  call void bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to void (%struct._objc_super*, i8*)*)(%struct._objc_super* %5, i8* %16)
  %17 = load %0*, %0** %3, align 8
  %18 = bitcast %0** %6 to i8**
  %19 = bitcast %0* %17 to i8*
  %20 = call i8* @llvm.objc.initWeak(i8** %18, i8* %19) #2
  %21 = load %0*, %0** %3, align 8
  %22 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 0
  store i8* bitcast (i8** @_NSConcreteStackBlock to i8*), i8** %22, align 8
  %23 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 1
  store i32 -1040187392, i32* %23, align 8
  %24 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 2
  store i32 0, i32* %24, align 4
  %25 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 3
  store i8* bitcast (void (i8*)* @"__29-[ViewController viewDidLoad]_block_invoke" to i8*), i8** %25, align 8
  %26 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 4
  store %struct.__block_descriptor* bitcast ({ i64, i64, i8*, i8*, i8*, i64 }* @"__block_descriptor_40_e8_32s_e5_v8\01?0l" to %struct.__block_descriptor*), %struct.__block_descriptor** %26, align 8
  %27 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7, i32 0, i32 5
  %28 = load %0*, %0** %3, align 8
  %29 = bitcast %0* %28 to i8*
  %30 = call i8* @llvm.objc.retain(i8* %29) #2
  %31 = bitcast i8* %30 to %0*
  store %0* %31, %0** %27, align 8
  %32 = bitcast <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %7 to void ()*
  %33 = bitcast %0* %21 to i8*
  invoke void bitcast (i8* (i8*, i8*, ...)* @"objc_msgSend$requestWithCompletion:" to void (i8*, i8*, void ()*)*)(i8* %33, i8* undef, void ()* %32)
          to label %34 unwind label %37

34:                                               ; preds = %2
  %35 = bitcast %0** %27 to i8**
  call void @llvm.objc.storeStrong(i8** %35, i8* null) #2
  %36 = bitcast %0** %6 to i8**
  call void @llvm.objc.destroyWeak(i8** %36) #2
  ret void

37:                                               ; preds = %2
  %38 = landingpad { i8*, i32 }
          cleanup
  %39 = extractvalue { i8*, i32 } %38, 0
  store i8* %39, i8** %8, align 8
  %40 = extractvalue { i8*, i32 } %38, 1
  store i32 %40, i32* %9, align 4
  %41 = bitcast %0** %6 to i8**
  call void @llvm.objc.destroyWeak(i8** %41) #2
  br label %42

42:                                               ; preds = %37
  %43 = load i8*, i8** %8, align 8
  %44 = load i32, i32* %9, align 4
  %45 = insertvalue { i8*, i32 } undef, i8* %43, 0
  %46 = insertvalue { i8*, i32 } %45, i32 %44, 1
  resume { i8*, i32 } %46
}

declare i8* @objc_msgSendSuper2(%struct._objc_super*, i8*, ...)

; Function Attrs: nounwind
declare i8* @llvm.objc.initWeak(i8**, i8*) #2

; Function Attrs: noinline optnone ssp uwtable
define internal void @"__29-[ViewController viewDidLoad]_block_invoke"(i8* %0) #1 {
  %2 = alloca i8*, align 8
  %3 = alloca <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>*, align 8
  store i8* %0, i8** %2, align 8
  %4 = bitcast i8* %0 to <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>*
  store <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %4, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>** %3, align 8
  %5 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %4, i32 0, i32 5
  %6 = load %0*, %0** %5, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_ to i8*), %0* %6)
  ret void
}

declare void @NSLog(i8*, ...) #3

; Function Attrs: noinline ssp uwtable
define linkonce_odr hidden void @__copy_helper_block_e8_32s(i8* %0, i8* %1) unnamed_addr #4 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = bitcast i8* %5 to <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>*
  %7 = load i8*, i8** %3, align 8
  %8 = bitcast i8* %7 to <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>*
  %9 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %6, i32 0, i32 5
  %10 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %8, i32 0, i32 5
  %11 = load %0*, %0** %9, align 8
  store %0* null, %0** %10, align 8
  %12 = bitcast %0** %10 to i8**
  %13 = bitcast %0* %11 to i8*
  call void @llvm.objc.storeStrong(i8** %12, i8* %13) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.objc.storeStrong(i8**, i8*) #2

; Function Attrs: noinline ssp uwtable
define linkonce_odr hidden void @__destroy_helper_block_e8_32s(i8* %0) unnamed_addr #4 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = bitcast i8* %3 to <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>*
  %5 = getelementptr inbounds <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>, <{ i8*, i32, i32, i8*, %struct.__block_descriptor*, %0* }>* %4, i32 0, i32 5
  %6 = bitcast %0** %5 to i8**
  call void @llvm.objc.storeStrong(i8** %6, i8* null) #2
  ret void
}

; Function Attrs: nounwind
declare i8* @llvm.objc.retain(i8*) #2

declare i8* @"objc_msgSend$requestWithCompletion:"(i8*, i8*, ...)

declare i32 @__objc_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.objc.destroyWeak(i8**) #2

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[ViewController requestWithCompletion:]"(%0* %0, i8* %1, void ()* %2) #1 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca void ()*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store void ()* null, void ()** %6, align 8
  %7 = bitcast void ()** %6 to i8**
  %8 = bitcast void ()* %2 to i8*
  call void @llvm.objc.storeStrong(i8** %7, i8* %8) #2
  %9 = load void ()*, void ()** %6, align 8
  %10 = load %0*, %0** %4, align 8
  %11 = bitcast %0* %10 to i8*
  call void bitcast (i8* (i8*, i8*, ...)* @"objc_msgSend$setCompletion:" to void (i8*, i8*, void ()*)*)(i8* %11, i8* undef, void ()* %9)
  %12 = load %0*, %0** %4, align 8
  %13 = bitcast %0* %12 to i8*
  %14 = call void ()* bitcast (i8* (i8*, i8*, ...)* @"objc_msgSend$completion" to void ()* (i8*, i8*)*)(i8* %13, i8* undef)
  call void asm sideeffect "mov\09fp, fp\09\09// marker for objc_retainAutoreleaseReturnValue", ""()
  %15 = bitcast void ()* %14 to i8*
  %16 = call i8* @llvm.objc.retainAutoreleasedReturnValue(i8* %15) #2
  %17 = bitcast i8* %16 to void ()*
  %18 = bitcast void ()* %17 to i8*
  call void @llvm.objc.release(i8* %18) #2, !clang.imprecise_release !16
  %19 = icmp ne void ()* %17, null
  br i1 %19, label %20, label %33

20:                                               ; preds = %3
  %21 = load %0*, %0** %4, align 8
  %22 = bitcast %0* %21 to i8*
  %23 = call void ()* bitcast (i8* (i8*, i8*, ...)* @"objc_msgSend$completion" to void ()* (i8*, i8*)*)(i8* %22, i8* undef)
  call void asm sideeffect "mov\09fp, fp\09\09// marker for objc_retainAutoreleaseReturnValue", ""()
  %24 = bitcast void ()* %23 to i8*
  %25 = call i8* @llvm.objc.retainAutoreleasedReturnValue(i8* %24) #2
  %26 = bitcast i8* %25 to void ()*
  %27 = bitcast void ()* %26 to %struct.__block_literal_generic*
  %28 = getelementptr inbounds %struct.__block_literal_generic, %struct.__block_literal_generic* %27, i32 0, i32 3
  %29 = bitcast %struct.__block_literal_generic* %27 to i8*
  %30 = load i8*, i8** %28, align 8
  %31 = bitcast i8* %30 to void (i8*)*
  call void %31(i8* %29)
  %32 = bitcast void ()* %26 to i8*
  call void @llvm.objc.release(i8* %32) #2, !clang.imprecise_release !16
  br label %33

33:                                               ; preds = %20, %3
  %34 = bitcast void ()** %6 to i8**
  call void @llvm.objc.storeStrong(i8** %34, i8* null) #2
  ret void
}

declare i8* @"objc_msgSend$setCompletion:"(i8*, i8*, ...)

declare i8* @"objc_msgSend$completion"(i8*, i8*, ...)

; Function Attrs: nounwind
declare i8* @llvm.objc.retainAutoreleasedReturnValue(i8*) #2

; Function Attrs: nounwind
declare void @llvm.objc.release(i8*) #2

; Function Attrs: noinline optnone ssp uwtable
define internal %1* @"\01-[ViewController array]"(%0* %0, i8* %1) #1 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = load i32, i32* @"OBJC_IVAR_$_ViewController._array", align 8, !invariant.load !16
  %7 = sext i32 %6 to i64
  %8 = bitcast %0* %5 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 %7
  %10 = bitcast i8* %9 to %1**
  %11 = load %1*, %1** %10, align 8
  ret %1* %11
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[ViewController setArray:]"(%0* %0, i8* %1, %1* %2) #1 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %1*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %1* %2, %1** %6, align 8
  %7 = load %1*, %1** %6, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = load i32, i32* @"OBJC_IVAR_$_ViewController._array", align 8, !invariant.load !16
  %10 = sext i32 %9 to i64
  %11 = bitcast %0* %8 to i8*
  %12 = getelementptr inbounds i8, i8* %11, i64 %10
  %13 = bitcast i8* %12 to %1**
  %14 = bitcast %1** %13 to i8**
  %15 = bitcast %1* %7 to i8*
  call void @llvm.objc.storeStrong(i8** %14, i8* %15) #2
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal void ()* @"\01-[ViewController completion]"(%0* %0, i8* %1) #1 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = load i32, i32* @"OBJC_IVAR_$_ViewController._completion", align 8, !invariant.load !16
  %7 = sext i32 %6 to i64
  %8 = bitcast %0* %5 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 %7
  %10 = bitcast i8* %9 to void ()**
  %11 = load void ()*, void ()** %10, align 8
  ret void ()* %11
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[ViewController setCompletion:]"(%0* %0, i8* %1, void ()* %2) #1 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca void ()*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store void ()* %2, void ()** %6, align 8
  %7 = load i8*, i8** %5, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = load i32, i32* @"OBJC_IVAR_$_ViewController._completion", align 8, !invariant.load !16
  %11 = sext i32 %10 to i64
  %12 = load void ()*, void ()** %6, align 8
  %13 = bitcast void ()* %12 to i8*
  call void @objc_setProperty_nonatomic_copy(i8* %9, i8* %7, i8* %13, i64 %11)
  ret void
}

declare void @objc_setProperty_nonatomic_copy(i8*, i8*, i8*, i64)

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[ViewController .cxx_destruct]"(%0* %0, i8* %1) #1 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = load i32, i32* @"OBJC_IVAR_$_ViewController._completion", align 8, !invariant.load !16
  %7 = sext i32 %6 to i64
  %8 = bitcast %0* %5 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 %7
  %10 = bitcast i8* %9 to void ()**
  %11 = bitcast void ()** %10 to i8**
  call void @llvm.objc.storeStrong(i8** %11, i8* null) #2
  %12 = load i32, i32* @"OBJC_IVAR_$_ViewController._array", align 8, !invariant.load !16
  %13 = sext i32 %12 to i64
  %14 = bitcast %0* %5 to i8*
  %15 = getelementptr inbounds i8, i8* %14, i64 %13
  %16 = bitcast i8* %15 to %1**
  %17 = bitcast %1** %16 to i8**
  call void @llvm.objc.storeStrong(i8** %17, i8* null) #2
  ret void
}

attributes #0 = { "objc_arc_inert" }
attributes #1 = { noinline optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a7" "target-features"="+aes,+crypto,+fp-armv8,+neon,+sha2,+zcm,+zcz" }
attributes #2 = { nounwind }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-a7" "target-features"="+aes,+crypto,+fp-armv8,+neon,+sha2,+zcm,+zcz" }
attributes #4 = { noinline ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a7" "target-features"="+aes,+crypto,+fp-armv8,+neon,+sha2,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 16, i32 1]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 1, !"Objective-C Garbage Collection", i8 0}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"Objective-C Enforce ClassRO Pointer Signing", i8 0}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 1, !"branch-target-enforcement", i32 0}
!9 = !{i32 1, !"sign-return-address", i32 0}
!10 = !{i32 1, !"sign-return-address-all", i32 0}
!11 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!12 = !{i32 7, !"PIC Level", i32 2}
!13 = !{i32 7, !"uwtable", i32 1}
!14 = !{i32 7, !"frame-pointer", i32 1}
!15 = !{!"Apple clang version 14.0.0 (clang-1400.0.29.202)"}
!16 = !{}