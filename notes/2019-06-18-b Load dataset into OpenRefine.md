## 2019-06-18-b Load dataset into OpenRefine

### Background

- The python program `clean_data_using_worms.py` in the `demos/04_paper_demo/python` is used to clean the data originally in the `demo_input.csv` file in the same directory.  See previous notes.

- We would like to reproduce this data cleaning workflow in OpenRefine and confirm that we can produce an output data file identical to the `demo_cleaned.csv` file produced by the Python program, and ideally the `demo_rejected.csv` file as well.

- We will not try to automate the interactions with the WoRMS service, and instead perform the lookups manually through the WoRMS web site, and then make the necessary changes manually in OpenRefine.

### Loaded the demo dataset into OpenRefine

- Started OpenRefine using the new (and initially empty) `openrefine-provenance/demos/04_paper_demo/openrefine` directory as the root of the project workspace so that it is under Git version control:
    ```console
    tmcphill@circe-win10:~/GitRepos/openrefine-provenance/demos/04_paper_demo/openrefine$ ls -al
    total 0
    drwxrwxrwx 1 tmcphill tmcphill 4096 Jun 18 22:10 .
    drwxrwxrwx 1 tmcphill tmcphill 4096 Jun 18 21:47 ..
    
    $ ~/openrefine-3.1/refine -d $(pwd)
    You have 16308M of free memory.
    Your current configuration is set to use 1400M of memory.
    OpenRefine can run better when given more memory. Read our FAQ on how to allocate more memory here:
    https://github.com/OpenRefine/OpenRefine/wiki/FAQ:-Allocate-More-Memory
    /usr/bin/java -cp server/classes:server/target/lib/*   -Xms1400M -Xmx1400M -Drefine.memory=1400M -Drefine.max_form_content_size=1048576 -Drefine.verbosity=info -Dpython.path=main/webapp/WEB-INF/lib/jython -Dpython.cachedir=/home/tmcphill/.local/share/google/refine/cachedir -Drefine.data_dir=/home/tmcphill/GitRepos/openrefine-provenance/demos/04_paper_demo/openrefine -Drefine.webapp=main/webapp -Drefine.port=3333 -Drefine.host=127.0.0.1 com.google.refine.Refine
    Starting OpenRefine at 'http://127.0.0.1:3333/'
    
    05:19:55.081 [            refine_server] Starting Server bound to '127.0.0.1:3333' (0ms)
    05:19:55.086 [            refine_server] refine.memory size: 1400M JVM Max heap: 1407188992 (5ms)
    05:19:55.109 [            refine_server] Initializing context: '/' from '/home/tmcphill/openrefine-3.1/webapp' (23ms)
    SLF4J: Class path contains multiple SLF4J bindings.
    SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/server/target/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
    SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/webapp/WEB-INF/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
    SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
    SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
    05:19:56.333 [                   refine] Starting OpenRefine 3.1 [b90e413]... (1224ms)
    05:19:56.334 [                   refine] initializing FileProjectManager with dir (1ms)
    05:19:56.338 [                   refine] /home/tmcphill/GitRepos/openrefine-provenance/demos/04_paper_demo/openrefine (4ms)
    05:19:56.365 [       FileProjectManager] Failed to load workspace from any attempted alternatives. (27ms)
    05:19:58.372 [       database-extension] Initializing OpenRefine Database... (2007ms)
    05:19:58.379 [       database-extension] Database Extension Mount point /extension/database/ [*] (7ms)
    05:19:58.380 [       database-extension] Registering Database Extension Commands...... (1ms)
    05:19:58.406 [       database-extension] Database Extension Command Registeration done!! (26ms)
    05:19:58.407 [       database-extension] Database Operations Registered successfully... (1ms)
    05:19:58.415 [       database-extension] Database Functions Registered successfully... (8ms)
    05:19:58.434 [       DatabaseModuleImpl] *** Database Extension Module Initialization Completed!!*** (19ms)
    ```

- Loaded the data file  `demo_input.csv` into a new OpenRefine project, accepting default parsing options.

- After several minutes noted that the working directory contains:

    ```console
    tmcphill@circe-win10:~/GitRepos/openrefine-provenance/demos/04_paper_demo/openrefine$ tree
    .
    ├── 2333511138787.project
    │   ├── data.zip
    │   └── metadata.json
    ├── dbextension
    ├── workspace.json
    └── workspace.old.json
    
    2 directories, 4 files 
    ```

