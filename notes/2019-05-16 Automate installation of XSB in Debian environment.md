## 2019-05-16 Automate installation of XSB in Debian environment

### Background
- Will be using XSB to implement provenance queries of data cleaning histories modeled on or collected from OpenRefine.
- XSB needs to be installed in the shareable computing environment for this project.

### Downloaded the XSB 3.8 source package for Linux
- Found downloads for XSB 3.8 (latest release) at:
  https://sourceforge.net/projects/xsb/files/xsb/3.8%20Three-Buck%20Chuck/
- Downloaded XSB38.tar.gz through Firefox, noting that SourceForge orchestrates the download from a different URL.
- Examined Firefox history to find where the tarball was actually downloaded from: https://managedway.dl.sourceforge.net/project/xsb/xsb/3.8%20Three-Buck%20Chuck/XSB38.tar.gz
- Successfully downloaded the file directly using curl:

    ```console
    tmcphill@circe-win10:~$ curl https://managedway.dl.sourceforge.net/project/xsb/xsb/3.8%20Three-Buck%20Chuck/XSB38.tar.gz -o XSB38.tar.gz
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 13.1M  100 13.1M    0     0  1282k      0  0:00:10  0:00:10 --:--:-- 2182k
    
    tmcphill@circe-win10:~$ ls -al XSB38.tar.gz
    -rw-rw-rw- 1 tmcphill tmcphill 13830570 May 16 18:48 XSB38.tar.gz
    ```

### Manually installed XSB 3.8 in WSL Debian environment

- Expanded the source archive:

    ```console
    tmcphill@circe-win10:~$ ls -al XSB38.tar.gz
    -rw-rw-rw- 1 tmcphill tmcphill 13830570 May 16 18:48 XSB38.tar.gz
    tmcphill@circe-win10:~$ tar -xvzf XSB38.tar.gz
    ./XSB/LICENSE
    ./XSB/README
    ./XSB/FAQ
    ./XSB/Makefile
    ./XSB/admin/TarAll.sh
    ./XSB/admin/TarBin.sh
    ./XSB/admin/TarCore.sh
    ./XSB/admin/TarNT.sh
    ./XSB/admin/TarRelease.sh
    ./XSB/admin/cleandist.sh
    ./XSB/admin/configure_release.sh
    ./XSB/build/acconfig.h
    ./XSB/build/banner.in
    ./XSB/build/chr_pp.in
    ./XSB/build/configure.in
    ./XSB/build/def_config.in
    ./XSB/build/def_config_mnoc.in
    ./XSB/build/def_debug.in
    ./XSB/build/emuMakefile.in
    ./XSB/build/gppMakefile.in
    ./XSB/build/makedef.sh.in
    ./XSB/build/makexsb.in
    ./XSB/build/modMakefile.in
    ./XSB/build/private_builtin.in
    ./XSB/build/smoMakefile.in
    ./XSB/build/topMakefile.in
    ./XSB/build/xmc-gui.in
    ./XSB/build/xmc.in
    ./XSB/build/xsb.in
    ./XSB/build/xsb_configuration.in
    ./XSB/build/config.guess
    ./XSB/build/config.sub
    ./XSB/build/MSVC.sh
    ./XSB/build/clean_pkgs.sh
    ./XSB/build/copysubdirs.sh
    ./XSB/build/install-sh
    ./XSB/build/pkg_config.sh
    ./XSB/build/register.sh
    ./XSB/build/strip.sh
    ./XSB/build/touch.sh
    ./XSB/build/version.sh
    ./XSB/build/registration.msg
    ./XSB/build/sendlog.msg
    ./XSB/build/configure
    ./XSB/build/README
    ./XSB/build/makexsb.bat
    ./XSB/build/makexsb64.bat
    ./XSB/build/MSVC.dep
    ./XSB/build/MSVC.sed
    ./XSB/build/MSVC.sh
    . . .
    ./XSB/examples/c_calling_XSB/cfixedstring.c
    ./XSB/examples/c_calling_XSB/cmain.c
    ./XSB/examples/c_calling_XSB/cmain.mak
    ./XSB/examples/c_calling_XSB/cmain2.c
    ./XSB/examples/c_calling_XSB/cregs.c
    ./XSB/examples/c_calling_XSB/cregs_thread.c
    ./XSB/examples/c_calling_XSB/cregs_thread2.c
    ./XSB/examples/c_calling_XSB/ctest.P
    ./XSB/examples/c_calling_XSB/cvarstring.c
    ./XSB/examples/c_calling_XSB/cvarstring_thread.c
    ./XSB/examples/c_calling_XSB/cvarstring_thread2.c
    ./XSB/examples/c_calling_XSB/edb.P
    ./XSB/examples/c_calling_XSB/make.P
    ./XSB/examples/c_calling_XSB/make_thread.P
    ./XSB/examples/c_calling_XSB/make_thread2.P
    ./XSB/examples/c_calling_XSB/makealt.P
    ./XSB/examples/c_calling_XSB/Makefile
    ./XSB/examples/c_calling_XSB/README

    tmcphill@circe-win10:~$ ls -al XSB
    total 88
    drwxrwxrwx 1 tmcphill tmcphill  4096 May 16 18:51 .
    drwxr-xr-x 1 tmcphill tmcphill  4096 May 16 18:50 ..
    drwxrwxrwx 1 tmcphill tmcphill  4096 May 16 18:50 admin
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 bin
    drwxrwxrwx 1 tmcphill tmcphill  4096 May 16 18:50 build
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 cmplib
    drwxrwxrwx 1 tmcphill tmcphill  4096 May 16 18:51 docs
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 emu
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 etc
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 examples
    -rw-r--r-- 1 tmcphill tmcphill   616 Oct 29  2017 FAQ
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 gpp
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 installer
    -rwxr-xr-x 1 tmcphill tmcphill 46532 Oct 29  2017 InstallXSB.jar
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 lib
    -rw-r--r-- 1 tmcphill tmcphill 23983 Oct 29  2017 LICENSE
    -rw-r--r-- 1 tmcphill tmcphill  1406 Oct 29  2017 Makefile
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 packages
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 prolog-commons
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 prolog_includes
    -rw-r--r-- 1 tmcphill tmcphill  2319 Oct 29  2017 README
    drwxr-xr-x 1 tmcphill tmcphill  4096 Oct 29  2017 syslib

    ```

- Followed instructions in [XSB Programmer's Manual](http://xsb.sourceforge.net/manual1/manual1.pdf), section 2.1 to install XSB below.
- Configured the XSB build in my Debian WSL environment:

    ```
    tmcphill@circe-win10:~/XSB/build$ ./configure
    
    Building XSB Version 3.8.0 (Three-Buck Chuck) of 2017-10-28
    
    checking build system type... x86_64-unknown-linux-gnu
    checking host system type... x86_64-unknown-linux-gnu
    configure: checking host system type... x86_64-unknown-linux-gnu
    creating cache /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/config.cache
    Checking installation directories...
    checking /home/tmcphill/XSB/lib... OK
    checking /home/tmcphill/XSB/syslib... OK
    checking /home/tmcphill/XSB/cmplib... OK
    checking /home/tmcphill/XSB/bin... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/bin... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/lib... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/saved.o... OK
    checking /home/tmcphill/XSB/site/lib... OK
    checking /home/tmcphill/XSB/site/config/x86_64-unknown-linux-gnu/lib... OK
    checking /home/tmcphill/XSB/emu... OK
    checking /home/tmcphill/XSB/lib... OK
    checking /home/tmcphill/XSB/syslib... OK
    checking /home/tmcphill/XSB/cmplib... OK
    checking /home/tmcphill/XSB/bin... OK
    checking /home/tmcphill/XSB/build... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/bin... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/lib... OK
    checking /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/saved.o... OK
    checking /home/tmcphill/XSB/etc... OK
    checking /home/tmcphill/XSB/packages... OK
    checking /home/tmcphill/XSB/packages/xmc... OK
    checking /home/tmcphill/XSB/examples... OK
    checking /home/tmcphill/XSB/prolog_includes... OK
    Checking installation directories ... Done
    checking for gcc... gcc
    checking whether the C compiler works... yes
    checking for C compiler default output file name... a.out
    checking for suffix of executables...
    checking whether we are cross compiling... no
    checking for suffix of object files... o
    checking whether we are using the GNU C compiler... yes
    checking whether gcc accepts -g... yes
    checking for gcc option to accept ISO C89... none needed
    checking how to run the C preprocessor... gcc -E
    checking for a BSD-compatible install... /usr/bin/install -c
    checking for grep that handles long lines and -e... /bin/grep
    checking for egrep... /bin/grep -E
    checking for ANSI C header files... yes
    checking for sys/types.h... yes
    checking for sys/stat.h... yes
    checking for stdlib.h... yes
    checking for string.h... yes
    checking for memory.h... yes
    checking for strings.h... yes
    checking for inttypes.h... yes
    checking for stdint.h... yes
    checking for unistd.h... yes
    checking minix/config.h usability... no
    checking minix/config.h presence... no
    checking for minix/config.h... no
    checking whether it is safe to define __EXTENSIONS__... yes
    checking for gcc... yes
    checking whether we are using SunPro C... no
    ***Configuring Curl (WWW protocol library)
    configure: WARNING:  ****Your system is missing curl/curl.h, which is required
        for Curl to function.
    ****Curl support will be disabled. To use Curl, please install the packages
        libcurl and libcurl-dev.
    ***Configuring XPath support
    ***Configuring PCRE (Perl pattern matching library)
    configure: WARNING:  ****Your system is missing pcre.h, which is required
        for PCRE (Perl pattern matching library) to function.
    ****PCRE support will be disabled. To use PCRE, please install the packages
        libpcre and libpcre-dev.
    checking whether make sets $(MAKE)... yes
    checking size of long int... 8
    
        Configuring XSB for a 64 bit machine
    
    checking for main in -lm... yes
    checking for main in -ldl... yes
    checking for main in -lnsl... yes
    checking for main in -lpthread... yes
    checking for main in -lsocket... no
    checking for readline in -lreadline... no
    checking for sched_get_priority_max... yes
    checking stdarg.h usability... yes
    checking stdarg.h presence... yes
    checking for stdarg.h... yes
    checking sys/time.h usability... yes
    checking sys/time.h presence... yes
    checking for sys/time.h... yes
    checking whether time.h and sys/time.h may both be included... yes
    checking sys/resource.h usability... yes
    checking sys/resource.h presence... yes
    checking for sys/resource.h... yes
    checking for malloc... yes
    checking for unistd.h... (cached) yes
    checking for string.h... (cached) yes
    checking for stdlib.h... (cached) yes
    checking for an ANSI C-conforming const... yes
    checking return type of signal handlers... void
    checking for strdup... yes
    checking for mkdir... yes
    checking for gethostbyname... yes
    checking for gettimeofday... yes
    checking for socket... yes
    checking for snprintf... yes
    checking for regexec... yes
    checking for regerror... yes
    checking for regcomp... yes
    checking for fnmatch... yes
    checking for glob... yes
    checking for globfree... yes
    checking for execvp... yes
    checking for itkwish... no
    XMC GUI not supported due to failure to find Incr Tcl/Tk
    checking whether loader understands -Wl,-export-dynamic... yes
    checking for inline... inline
        Not using SMODELS
    checking for javac... /usr/bin/javac
    ls: cannot access '/usr/include/*/jni_md.h': No such file or directory
    ls: cannot access '/usr/include/jni_md.h': No such file or directory
    checking jni.h usability... no
    checking jni.h presence... no
    checking for jni.h... no
    checking jni_md.h usability... no
    checking jni_md.h presence... no
    checking for jni_md.h... no
    configure: updating cache /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/config.cache
    configure: creating ./config.status
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/topMakefile
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/emuMakefile
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/modMakefile
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/gppMakefile
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/smoMakefile
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/makedef.sh
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/lib/xsb_configuration.P
    config.status: creating windows/xsb_configuration.P
    config.status: creating windows64/xsb_configuration.P
    config.status: creating makexsb
    config.status: creating /home/tmcphill/XSB/bin/chr_pp
    config.status: creating /home/tmcphill/XSB/bin/xsb
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/banner.msg
    config.status: creating windows/banner.msg
    config.status: creating windows64/banner.msg
    config.status: creating windows/MSVC_mkfile.mak
    config.status: creating windows64/MSVC_mkfile.mak
    config.status: creating /home/tmcphill/XSB/packages/xmc/xmc-gui
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/xsb_config.h
    config.status: creating windows/xsb_config.h
    config.status: creating windows/xsb_debug.h
    config.status: creating windows64/xsb_config.h
    config.status: creating windows64/xsb_debug.h
    config.status: creating /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/xsb_debug.h
    
    
                INSTALLATION SUMMARY
                --------------------
    
    XSB Version:       3.8.0
    Code name:         Three-Buck Chuck
    Release date:      2017-10-28
    Configuration:     x86_64-unknown-linux-gnu
    Installation date: Thu May 16 18:59:55 DST 2019
    
      Build process is looking for XSB sources in:    /home/tmcphill/XSB
      XSB should be installed in:                     /home/tmcphill/XSB
      Configuration-specific executables go in:       /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/bin
      Configuration-specific libraries go in:         /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/lib
      Object code goes in:                            /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/saved.o
      Site-specific code goes in:                     /home/tmcphill/XSB/site
      Site configuration-specific code goes in:       /home/tmcphill/XSB/site/config/x86_64-unknown-linux-gnu
      XSB will be built with:                         gcc   -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
      builtin.c will be built with:                   gcc  -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
      loader_xsb.c will be built with:                gcc  -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
      emuloop.c will be built with:                   gcc  -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
      tr_utils.c will be built with:                  gcc  -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
      Loader flags:                                   -lm -ldl -Wl,-export-dynamic -lpthread
      Compilation mode:                               optimal
      XSB abstract machine:                           slg-wam
      XSB scheduling strategy:                        local
      Garbage Collection Stress-Test:                 no
      Jumptable-based emulator loop:                  yes
      Demand support:                                 no
    
      Support for modular database drivers:           no
      -- These drivers can also be configured later.
      Native support for Oracle:                      no
      Support for the old ODBC driver:                no
    
      Java compiler:                                  /usr/bin/javac
      Support for InterProlog's native engine:        no
      -- JDK may not have been installed or
      -- JAVA_HOME not set. You will still be able
      -- to use InterProlog's subprocess engine.
    
      POSIX regexp matching libraries:                yes
      POSIX wildcard matching libraries:              yes
    
      Curl support (HTTP protocol library):           no
      XPath support:                                  yes
      XPath C flags:                                  -I/usr/include/libxml2
      XPath loader flags:                             -L/usr/lib -lxml2
    
      PCRE support (Perl pattern matching):           no
    
    
    *** Warning: The command 'makedepend' is not installed.
    ***          Install it to speed up compilation of XSB.
    *** Warning: The commands 'todos' and 'unix2dos' are not installed.
    ***          Install one of these to speed up compilation of XSB in Windows
    ***          Due to this, always run 'makexsb clean' before every 'makexsb'
    
    XSB is configured for installation in /home/tmcphill/XSB
    Site libraries are to be found in /home/tmcphill/XSB/site
    Configuration report is saved in ./Installation_summary
    
    ***Now compile XSB with:   `./makexsb'
    ```
- Built XSB 3.8.0:

    ```console
    tmcphill@circe-win10:~/XSB/build$ ./makexsb
    
    make -f ../config/x86_64-unknown-linux-gnu/topMakefile
    
    
    Preparing...
    
    Making emulator...
    make[1]: Entering directory '/home/tmcphill/XSB/emu'
    Makefile:201: recipe for target 'depend' failed
    make[1]: Leaving directory '/home/tmcphill/XSB/emu'
    *** Warning: The command 'makedepend' is not installed. Install it to speed up compilation of XSB.
    make[1]: Entering directory '/home/tmcphill/XSB/emu'
    -e
    Compiling XSB with gcc using -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
    
    -e      [gcc] main_xsb.c
    -e      [gcc] auxlry.c
    -e      [gcc] biassert.c
    biassert.c: In function ‘dbgen_printinst3’:
    biassert.c:158:20: warning: type of ‘Opcode’ defaults to ‘int’ [-Wimplicit-int]
     static inline void dbgen_printinst3(Opcode, Arg1, Arg2, Arg3)
                        ^~~~~~~~~~~~~~~~
    biassert.c:158:20: warning: type of ‘Arg1’ defaults to ‘int’ [-Wimplicit-int]
    biassert.c:158:20: warning: type of ‘Arg2’ defaults to ‘int’ [-Wimplicit-int]
    biassert.c:158:20: warning: type of ‘Arg3’ defaults to ‘int’ [-Wimplicit-int]
    biassert.c: In function ‘dbgen_printinst’:
    biassert.c:181:20: warning: type of ‘Opcode’ defaults to ‘int’ [-Wimplicit-int]
     static inline void dbgen_printinst(Opcode, Arg1, Arg2)
                        ^~~~~~~~~~~~~~~
    biassert.c:181:20: warning: type of ‘Arg1’ defaults to ‘int’ [-Wimplicit-int]
    biassert.c:181:20: warning: type of ‘Arg2’ defaults to ‘int’ [-Wimplicit-int]
    -e      [gcc] builtin.c using -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
    In file included from builtin.c:1410:0:
    io_builtins_xsb_i.h: In function ‘file_function’:
    io_builtins_xsb_i.h:1075:33: warning: ‘charset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
         open_files[io_port].charset = charset;
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
    -e      [gcc] call_xsb.c
    -e      [gcc] cinterf.c
    -e      [gcc] conc_compl.c
    -e      [gcc] debug_xsb.c
    debug_xsb.c: In function ‘sprint_registers’:
    debug_xsb.c:724:3: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
       if (arity != 0) sprintf(buffer+size, "(");size++;
       ^~
    debug_xsb.c:724:45: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ‘if’
       if (arity != 0) sprintf(buffer+size, "(");size++;
                                                 ^~~~
    debug_xsb.c: In function ‘sprint_cyclic_registers’:
    debug_xsb.c:745:3: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
       if (arity != 0) sprintf(buffer+size, "(");size++;
       ^~
    debug_xsb.c:745:45: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ‘if’
       if (arity != 0) sprintf(buffer+size, "(");size++;
                                                 ^~~~
    debug_xsb.c: In function ‘quick_print_trail’:
    debug_xsb.c:2046:5: warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
         if ( i == trreg ) printf("trreg");if ( i == trfreg ) printf("trfreg ");
         ^~
    debug_xsb.c:2046:39: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ‘if’
         if ( i == trreg ) printf("trreg");if ( i == trfreg ) printf("trfreg ");
                                           ^~
    -e      [gcc] dis.c
    -e      [gcc] dynload.c
    -e      [gcc] dynamic_stack.c
    -e      [gcc] deadlock.c
    -e      [gcc] emuloop.c using -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
    -e      [gcc] error_xsb.c
    -e      [gcc] findall.c
    -e      [gcc] function.c
    -e      [gcc] hash_xsb.c
    -e      [gcc] hashtable_xsb.c
    -e      [gcc] heap_xsb.c
    -e      [gcc] init_xsb.c
    -e      [gcc] inst_xsb.c
    -e      [gcc] io_builtins_xsb.c
    -e      [gcc] loader_xsb.c using -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
    -e      [gcc] memory_xsb.c
    -e      [gcc] orient_xsb.c
    -e      [gcc] pathname_xsb.c
    -e      [gcc] psc_xsb.c
    -e      [gcc] random_xsb.c
    -e      [gcc] remove_unf.c
    -e      [gcc] residual.c
    -e      [gcc] rw_lock.c
    -e      [gcc] scc_xsb.c
    -e      [gcc] slgdelay.c
    -e      [gcc] socket_xsb.c
    -e      [gcc] string_xsb.c
    -e      [gcc] storage_xsb.c
    -e      [gcc] struct_manager.c
    -e      [gcc] struct_intern.c
    -e      [gcc] sub_delete.c
    -e      [gcc] subp.c
    -e      [gcc] system_xsb.c
    -e      [gcc] table_stats.c
    -e      [gcc] tables.c
    -e      [gcc] thread_xsb.c
    thread_xsb.c: In function ‘init_message_queue’:
    thread_xsb.c:2010:9: warning: variable ‘pos’ set but not used [-Wunused-but-set-variable]
       { int pos;
             ^~~
    -e      [gcc] timer_xsb.c
    -e      [gcc] token_xsb.c
    -e      [gcc] tr_utils.c using -O3 -fno-strict-aliasing   -fPIC -Wall -pipe
    -e      [gcc] trace_xsb.c
    -e      [gcc] trie_lookup.c
    -e      [gcc] trie_search.c
    -e      [gcc] tries.c
    -e      [gcc] tst_insert.c
    -e      [gcc] tst_retrv.c
    -e      [gcc] tst_unify.c
    -e      [gcc] tst_utils.c
    -e      [gcc] varstring.c
    -e      [gcc] ubi_BinTree.c
    -e      [gcc] ubi_SplayTree.c
    -e      [gcc] hashtable.c
    -e      [gcc] hashtable_itr.c
    -e      [gcc] sha1.c
    -e      [gcc] md5.c
    -e      [gcc] url_encode.c
    -e      [gcc] getMemorySize.c
    -e      [gcc] incr_xsb.c
    -e      [gcc] call_graph_xsb.c
    
    Making XSB executable /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/bin/xsb
    
    -e      [gcc] -o /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/bin/xsb -lm -ldl -Wl,-export-dynamic -lpthread
    system_xsb.o: In function `sys_system':
    system_xsb.c:(.text+0xcca): warning: the use of `tempnam' is dangerous, better use `mkstemp'
    make[1]: Leaving directory '/home/tmcphill/XSB/emu'
    
    Making XSB module...
    make[1]: Entering directory '/home/tmcphill/XSB/emu'
    
    Making a C-callable XSB module
    gcc  -o xsb.o -nodefaultlibs -nostartfiles  -r auxlry.o biassert.o builtin.o call_xsb.o cinterf.o conc_compl.o debug_xsb.o dis.o dynload.o dynamic_stack.o deadlock.o emuloop.o error_xsb.o findall.o function.o hash_xsb.o  hashtable_xsb.o heap_xsb.o init_xsb.o inst_xsb.o io_builtins_xsb.o loader_xsb.o memory_xsb.o orient_xsb.o pathname_xsb.o psc_xsb.o random_xsb.o remove_unf.o residual.o rw_lock.o scc_xsb.o slgdelay.o socket_xsb.o string_xsb.o storage_xsb.o struct_manager.o struct_intern.o sub_delete.o subp.o system_xsb.o table_stats.o tables.o thread_xsb.o timer_xsb.o token_xsb.o tr_utils.o trace_xsb.o trie_lookup.o trie_search.o tries.o tst_insert.o tst_retrv.o tst_unify.o tst_utils.o varstring.o ubi_BinTree.o ubi_SplayTree.o hashtable.o hashtable_itr.o sha1.o md5.o url_encode.o getMemorySize.o incr_xsb.o call_graph_xsb.o
    
    make[1]: Leaving directory '/home/tmcphill/XSB/emu'
    
    Making DLL... (if Cygwin)
    make[1]: Entering directory '/home/tmcphill/XSB/emu'
    make[1]: Nothing to be done for 'dll'.
    make[1]: Leaving directory '/home/tmcphill/XSB/emu'
    
    Making gpp
    make[1]: Entering directory '/home/tmcphill/XSB/gpp'
    
    -e      [gcc] gpp.c using
    -e      [gcc] -o gpp
    
    make[1]: Leaving directory '/home/tmcphill/XSB/gpp'
    make[1]: Entering directory '/home/tmcphill/XSB'
    
    cd cmplib; make
    make[2]: Entering directory '/home/tmcphill/XSB/cmplib'
    rm -f 'cmd...'
    rm -f '../build/.xsb_cmplib_warn.tmp'
    /home/tmcphill/XSB/bin/xsb -e "segfault_handler(warn)." < 'cmd...'
    [Compiling /home/tmcphill/XSB/config/x86_64-unknown-linux-gnu/lib/xsb_configuration]
    % Specialising partially instantiated calls to xsb_configuration/2
    [Module xsb_configuration compiled, cpu time used: 0.0160 seconds]
    [xsb_configuration loaded]
    [sysinitrc loaded]
    [xsbbrat loaded]
    
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    
    Evaluating command line goal:
    | ?-  segfault_handler(warn).
    
    | ?-
    yes
    | ?-
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    End XSB (cputime 0.05 secs, elapsetime 0.88 secs)
    /bin/rm 'cmd...'
    ----------------- Warnings ------------------------
    While compiling XSB/cmplib:
    -------------------- End --------------------------
    make[2]: Leaving directory '/home/tmcphill/XSB/cmplib'
    
    cd syslib; make
    make[2]: Entering directory '/home/tmcphill/XSB/syslib'
    rm -f '../build/.xsb_syslib_warn.tmp'
    ./CompileChangedFiles.sh /home/tmcphill/XSB/bin/xsb -e "segfault_handler(warn)."
    [xsb_configuration loaded]
    [sysinitrc loaded]
    [xsbbrat loaded, cpu time used: 0.0160 seconds]
    
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    End XSB (cputime 0.03 secs, elapsetime 0.45 secs)
    ----------------- Warnings ------------------------
    While compiling XSB/syslib:
    -------------------- End --------------------------
    
    make[2]: Leaving directory '/home/tmcphill/XSB/syslib'
    
    cd lib; make
    make[2]: Entering directory '/home/tmcphill/XSB/lib'
    /bin/rm -f '../build/.xsb_lib_warn.tmp'
    /home/tmcphill/XSB/bin/xsb -e "segfault_handler(warn)." < cmd...
    [xsb_configuration loaded]
    [sysinitrc loaded]
    [xsbbrat loaded]
    
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    
    Evaluating command line goal:
    | ?-  segfault_handler(warn).
    
    | ?-
    yes
    | ?-
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    yes
    | ?-
    End XSB (cputime 0.02 secs, elapsetime 0.50 secs)
    /bin/rm -f cmd...
    ----------------- Warnings ------------------------
    While compiling XSB/lib:
    -------------------- End --------------------------
    make[2]: Leaving directory '/home/tmcphill/XSB/lib'
    make[1]: Leaving directory '/home/tmcphill/XSB'
    
    ----------------- Warnings ------------------------
    While compiling XSB/cmplib:
    -------------------- End --------------------------
    ----------------- Warnings ------------------------
    While compiling XSB/lib:
    -------------------- End --------------------------
    ----------------- Warnings ------------------------
    While compiling XSB/syslib:
    -------------------- End --------------------------
    
    
    Now you can run XSB using the shell script:
           /home/tmcphill/XSB/bin/xsb
    ```
- Confirmed that xsb now works:

    ```console
    tmcphill@circe-win10:~/XSB/build$ ../bin/xsb --version
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    XSB is licensed under the GNU Library General Public License.
    You can change it and/or distribute copies of it under certain conditions.
    You should have received the License with this distribution of XSB.
    If not, see:  http://www.gnu.org/copyleft/lgpl.html
    XSB comes without warranty of any kind.
    
    tmcphill@circe-win10:~/XSB/build$ ../bin/xsb
    [xsb_configuration loaded]
    [sysinitrc loaded]
    [xsbbrat loaded]
    
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    | ?-
    <CTRL-D>
    End XSB (cputime 0.02 secs, elapsetime 3.61 secs)
    ```
### Created an Ansible role for installing XSB

- Created file `~\GitRepos\ansible-playbooks\debian\playbooks\roles\xsb\tasks\main.yml` with the following contents:

    ```yaml
    ---
    
    - name: download and expand XSB 3.8
      unarchive:
          remote_src: yes
          src: https://managedway.dl.sourceforge.net/project/xsb/xsb/3.8%20Three-Buck%20Chuck/XSB38.tar.gz
          dest: ${HOME}
    
    - name: configure and build XSB
      shell: |
        cd ${HOME}/XSB/build
        ./configure
        ./makexsb
    
    - name: create and set contents of script adding XSB bin directory to $PATH at loginn
      copy:
          dest:  ~/.bashrc.d/xsb.sh
          content: |
              export XSB_DIR=~/XSB
              export PATH="$PATH:$XSB_DIR/bin
          mode: 0644
    ```
- Added xsb role to the openrefine-prov playbook and temporarily commented out the the other roles:

    ```yaml
    - name: work with OpenRefine provenance project
      hosts: 127.0.0.1
      connection: local
      roles:
        # - git
        # - jdk8
        # - json-cli-tools
        # - openrefine
        # - python3
        # - golang-1.9
        # - lgo
        # - openrefine-prov-repo
        - xsb
    ```
- Deleted the manually installed version of XSB and ran the updated playbook:

    ```console
    tmcphill@circe-win10:~/GitRepos/ansible-playbooks/debian$ rm -rf ~/XSB
    tmcphill@circe-win10:~/GitRepos/ansible-playbooks/debian$ . ../.venv-ansible-playbooks/bin/activate
    (.venv-ansible-playbooks) tmcphill@circe-win10:~/GitRepos/ansible-playbooks/debian$ ansible-playbook playbooks/openrefine-prov.yml
     [WARNING]: Unable to parse /etc/ansible/hosts as an inventory source
    
     [WARNING]: No inventory was parsed, only implicit localhost is available
    
     [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'
    
    
    PLAY [work with OpenRefine provenance project] ******************************************************************************************************************************************************************************************************************************************************************************
    
    TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************************************************
    ok: [127.0.0.1]
    
    TASK [xsb : download and expand XSB 3.8] ************************************************************************************************************************************************************************************************************************************************************************************
    changed: [127.0.0.1]
    
    TASK [xsb : configure and build XSB] ****************************************************************************************************************************************************************************************************************************************************************************************
    changed: [127.0.0.1]
    
    TASK [xsb : create and set contents of script adding XSB bin directory to $PATH at loginn] **********************************************************************************************************************************************************************************************************************************
    changed: [127.0.0.1]
    
    PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************************************************
    127.0.0.1                  : ok=4    changed=3    unreachable=0    failed=0
    ```
- Started new terminal and confirmed xsb is now in my PATH:

    ```console
    tmcphill@circe-win10:~$ which xsb
    /home/tmcphill/XSB/bin/xsb
    tmcphill@circe-win10:~$ xsb --version
    XSB Version 3.8.0 (Three-Buck Chuck) of October 28, 2017
    [x86_64-unknown-linux-gnu 64 bits; mode: optimal; engine: slg-wam; scheduling: local]
    [Build date: 2019-05-16]
    
    XSB is licensed under the GNU Library General Public License.
    You can change it and/or distribute copies of it under certain conditions.
    You should have received the License with this distribution of XSB.
    If not, see:  http://www.gnu.org/copyleft/lgpl.html
    XSB comes without warranty of any kind.
    ```

