## 2019-03-05 Explore project storage for a data set newly imported into OpenRefine

### Objectives
- Load a data set into OpenRefine.
- Find where it stores project state and history information.
- Try to understand how it represents and organizes project history.

### Started OpenRefine and located default workspace directory

- Listed home directory before running OpenRefine:
	```console
	tmcphill@circe-win10:~$ ls -alrt
	total 12
	drwxr-xr-x 1 root     root     4096 Mar  3 16:17 ..
	-rw-r--r-- 1 tmcphill tmcphill  220 Mar  3 16:17 .bash_logout
	-rw-r--r-- 1 tmcphill tmcphill  675 Mar  3 16:17 .profile
	-rw-rw-rw- 1 tmcphill tmcphill  180 Mar  3 16:18 .wget-hsts
	drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  3 16:21 .venv-ansible-playbooks
	drwx------ 1 tmcphill tmcphill 4096 Mar  3 16:21 .cache
	lrwxrwxrwx 1 tmcphill tmcphill   26 Mar  3 16:23 .ssh -> /mnt/c/Users/tmcphill/.ssh
	lrwxrwxrwx 1 tmcphill tmcphill   30 Mar  3 16:23 GitRepos -> /mnt/c/Users/tmcphill/GitRepos
	-rw-rw-rw- 1 tmcphill tmcphill 2004 Mar  3 16:35 bootstrap.sh
	lrwxrwxrwx 1 tmcphill tmcphill   68 Mar  3 16:36 bashrc_d -> /mnt/c/Users/tmcphill/GitRepos/ansible-playbooks/wsl-debian/bashrc_d
	lrwxrwxrwx 1 tmcphill tmcphill   31 Mar  3 16:36 .bashrc -> /home/tmcphill/bashrc_d/.bashrc
	drwx------ 1 tmcphill tmcphill 4096 Mar  4 10:32 .ansible
	-rw-rw-rw- 1 tmcphill tmcphill  125 Mar  4 11:47 .gitconfig
	-rw------- 1 tmcphill tmcphill 1879 Mar  4 14:04 .bash_history
	drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  4 15:44 openrefine-3.1
	drwxr-xr-x 1 tmcphill tmcphill 4096 Mar  5 16:10 .
	 ```
  
- Started OpenRefine in WSL Debian environment and found in log messages possible location of project workspace (/home/tmcphill/.local/share/openrefine):

	 ```console
	tmcphill@circe-win10:~$ ./openrefine-3.1/refine
	You have 16308M of free memory.
	Your current configuration is set to use 1400M of memory.
	OpenRefine can run better when given more memory. Read our FAQ on how to allocate more memory here:
	https://github.com/OpenRefine/OpenRefine/wiki/FAQ:-Allocate-More-Memory
	/usr/bin/java -cp server/classes:server/target/lib/*   -Xms1400M -Xmx1400M -Drefine.memory=1400M -Drefine.max_form_content_size=1048576 -Drefine.verbosity=info -Dpython.path=main/webapp/WEB-INF/lib/jython -Dpython.cachedir=/home/tmcphill/.local/share/google/refine/cachedir -Drefine.webapp=main/webapp -Drefine.port=3333 -Drefine.host=127.0.0.1 com.google.refine.Refine
	Starting OpenRefine at 'http://127.0.0.1:3333/'

	00:11:47.779 [            refine_server] Starting Server bound to '127.0.0.1:3333' (0ms)
	00:11:47.782 [            refine_server] refine.memory size: 1400M JVM Max heap: 1407188992 (3ms)
	00:11:47.794 [            refine_server] Initializing context: '/' from '/home/tmcphill/openrefine-3.1/webapp' (12ms)
	00:11:48.207 [            refine_server] Creating new workspace directory /home/tmcphill/.local/share/openrefine (413ms)
	SLF4J: Class path contains multiple SLF4J bindings.
	SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/server/target/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
	SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/webapp/WEB-INF/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
	SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
	SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
	00:11:48.437 [                   refine] Starting OpenRefine 3.1 [b90e413]... (230ms)
	00:11:48.438 [                   refine] initializing FileProjectManager with dir (1ms)
	00:11:48.440 [                   refine] /home/tmcphill/.local/share/openrefine (2ms)
	00:11:48.449 [       FileProjectManager] Failed to load workspace from any attempted alternatives. (9ms)
	00:11:49.513 [       database-extension] Initializing OpenRefine Database... (1064ms)
	00:11:49.517 [       database-extension] Database Extension Mount point /extension/database/ [*] (4ms)
	00:11:49.518 [       database-extension] Registering Database Extension Commands...... (1ms)
	00:11:49.533 [       database-extension] Database Extension Command Registeration done!! (15ms)
	00:11:49.533 [       database-extension] Database Operations Registered successfully... (0ms)
	00:11:49.534 [       database-extension] Database Functions Registered successfully... (1ms)
	00:11:49.544 [       DatabaseModuleImpl] *** Database Extension Module Initialization Completed!!*** (10ms)
	00:11:52.094 [                   refine] Sorry, some error prevented us from launching the browser for you.

		 Point your browser to http://127.0.0.1:3333/ to start using Refine. (2550ms)
	 ```
  	
- Confirmed that a new directory tree rooted at .local is now present in my home directory and contains a workspace.json file:

	```console
	tmcphill@circe-win10:~$ ls -alrt
	total 12
	drwxr-xr-x 1 root     root     4096 Mar  3 16:17 ..
	-rw-r--r-- 1 tmcphill tmcphill  220 Mar  3 16:17 .bash_logout
	-rw-r--r-- 1 tmcphill tmcphill  675 Mar  3 16:17 .profile
	-rw-rw-rw- 1 tmcphill tmcphill  180 Mar  3 16:18 .wget-hsts
	drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  3 16:21 .venv-ansible-playbooks
	drwx------ 1 tmcphill tmcphill 4096 Mar  3 16:21 .cache
	lrwxrwxrwx 1 tmcphill tmcphill   26 Mar  3 16:23 .ssh -> /mnt/c/Users/tmcphill/.ssh
	lrwxrwxrwx 1 tmcphill tmcphill   30 Mar  3 16:23 GitRepos -> /mnt/c/Users/tmcphill/GitRepos
	-rw-rw-rw- 1 tmcphill tmcphill 2004 Mar  3 16:35 bootstrap.sh
	lrwxrwxrwx 1 tmcphill tmcphill   68 Mar  3 16:36 bashrc_d -> /mnt/c/Users/tmcphill/GitRepos/ansible-playbooks/wsl-debian/bashrc_d
	lrwxrwxrwx 1 tmcphill tmcphill   31 Mar  3 16:36 .bashrc -> /home/tmcphill/bashrc_d/.bashrc
	drwx------ 1 tmcphill tmcphill 4096 Mar  4 10:32 .ansible
	-rw-rw-rw- 1 tmcphill tmcphill  125 Mar  4 11:47 .gitconfig
	-rw------- 1 tmcphill tmcphill 1879 Mar  4 14:04 .bash_history
	drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  4 15:44 openrefine-3.1
	drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  5 16:11 .local
	drwxr-xr-x 1 tmcphill tmcphill 4096 Mar  5 16:11 .

	tmcphill@circe-win10:~$ tree .local/
	.local/
	└── share
	    └── openrefine
	        └── workspace.json

	2 directories, 1 file
	```

- Printed contents of initial workspace.json file, formatting using jq (https://stedolan.github.io/jq/):

	```console
	tmcphill@circe-win10:~$ jq . .local/share/openrefine/workspace.json
	{
	  "projectIDs": [],
	  "preferences": {
	    "entries": {
	      "scripting.starred-expressions": {
	        "class": "com.google.refine.preference.TopList",
	        "top": 2147483647,
	        "list": []
	      },
	      "scripting.expressions": {
	        "class": "com.google.refine.preference.TopList",
	        "top": 100,
	        "list": []
	      }
	    }
	  }
	}    
	```

### Started first OpenRefine project and noted new project directory and files in workspace

- Obtained zip file with sample data sets (code files) for the book Using Open Refine:

	```console
	tmcphill@circe-win10:~$ tree /mnt/c/Users/tmcphill/OneDrive/Datasets/Using OpenRefine/
	├── 9781783289080_code.zip
	├── chapter1
	│   └── phm-collection-tsv-chapter1-latin1
	│       └── phm-collection.tsv
	├── chapter2
	│   └── openrefine-project-chapter2.tar.gz
	├── chapter3
	│   └── openrefine-project-chapter3.tar.gz
	└── chapter4
	    └── openrefine-project-chapter4.tar.gz

	5 directories, 5 files
	```

- Loaded chapter1 dataset phm-collection.tsv into OpenRefine.  Parsing parameters were taken from Chapter 1 of the book Using Open Refine :

	![](https://lh4.googleusercontent.com/pK04FK1giHrIgUOWhjclAVGzaa2aTSxeHpks6wXijZheGGqmL1vzY-V-SeA2soq7zRbSrPRMwzQuU2V7e3XgtEkOMZROv30oYGJNDLNsB4v38UrDksaa7wzzMMuGIK_5DBhe29AT)			

- After creating project for this data set examined workspace directory noting new project directory and files:

	```console
	tmcphill@circe-win10:~$ tree .local/
	.local/
	└── share
	    └── openrefine
	        ├── 2548854995375.project
	        │   ├── data.zip
	        │   └── metadata.json
	        ├── dbextension
	        ├── workspace.json
	        └── workspace.old.json

	4 directories, 4 files

	3 directories, 2 files
	```

- Found the import options I chose when creating the project recorded in the metdata.json file:

	 ```console
	tmcphill@circe-win10:~$ jq . .local/share/openrefine/2548854995375.project/metadata.json
	{
	  "name": "phm collection tsv",
	  "tags": [],
	  "created": "2019-03-06T01:55:32Z",
	  "modified": "2019-03-06T01:56:51Z",
	  "creator": "",
	  "contributors": "",
	  "subject": "",
	  "description": "",
	  "rowCount": 75814,
	  "title": "",
	  "homepage": "",
	  "image": "",
	  "license": "",
	  "version": "",
	  "customMetadata": {},
	  "importOptionMetadata": [
	    {
	      "guessCellValueTypes": true,
	      "projectTags": [
	        ""
	      ],
	      "ignoreLines": -1,
	      "processQuotes": false,
	      "fileSource": "phm-collection.tsv",
	      "encoding": "",
	      "separator": "\\t",
	      "storeBlankCellsAsNulls": true,
	      "storeBlankRows": true,
	      "skipDataLines": 0,
	      "includeFileSources": false,
	      "headerLines": 1,
	      "limit": -1,
	      "projectName": "phm collection tsv"
	    }
	  ],
	  "password": "",
	  "encoding": "UTF-8",
	  "encodingConfidence": 0,
	  "preferences": {
	    "entries": {
	      "scripting.starred-expressions": {
	        "class": "com.google.refine.preference.TopList",
	        "top": 2147483647,
	        "list": []
	      },
	      "scripting.expressions": {
	        "class": "com.google.refine.preference.TopList",
	        "top": 100,
	        "list": []
	      }
	    }
	  }
	}
	```
- Found that the data.zip file comprises two files, data.txt and pool.txt:

	```console
	tmcphill@circe-win10:~$ unzip .local/share/openrefine/2548854995375.project/data.zip
	Archive:  .local/share/openrefine/2548854995375.project/data.zip
	  inflating: data.txt
	  inflating: pool.txt
	```

- The data.txt file appears to contain the metadata (e..g column count, column names and types) followed by each successive row of the data cell values themselves (one line per row of data). Note that the IDs of the two rows (in bold) match the first two rows  displayed when importing the data set.

	```console
	tmcphill@circe-win10:~$ head -30 data.txt
	3.1
	columnModel=
	maxCellIndex=15
	keyColumnIndex=0
	columnCount=16
	{"cellIndex":0,"originalName":"Record ID","name":"Record ID","type":"integer","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":1,"originalName":"Object Title","name":"Object Title","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":2,"originalName":"Registration Number","name":"Registration Number","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":3,"originalName":"Description.","name":"Description.","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":4,"originalName":"Marks","name":"Marks","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":5,"originalName":"Production Date","name":"Production Date","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":6,"originalName":"Provenance (Production)","name":"Provenance (Production)","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":7,"originalName":"Provenance (History)","name":"Provenance (History)","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":8,"originalName":"Categories","name":"Categories","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":9,"originalName":"Persistent Link","name":"Persistent Link","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":10,"originalName":"Height","name":"Height","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":11,"originalName":"Width","name":"Width","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":12,"originalName":"Depth","name":"Depth","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":13,"originalName":"Diameter","name":"Diameter","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":14,"originalName":"Weight","name":"Weight","type":"string","format":"","title":"","description":"","constraints":"{}"}
	{"cellIndex":15,"originalName":"License info","name":"License info","type":"string","format":"","title":"","description":"","constraints":"{}"}
	columnGroupCount=0
	/e/
	history=
	pastEntryCount=0
	futureEntryCount=0
	/e/
	rowCount=75814
	{"flagged":false,"starred":false,"cells":[{"v":267220},{"v":"Rocket motor on loan from Roswell Museum and Art Center, USA"},{"v":"L2106-3/1"},{"v":"Rocket motor, liquid fuelled combustion chamber, steel / aluminium wrapped tubes with insulation, included in flight of Dec 26 1928, Robert H Goddard, USA, 1928 (Roswell Acc No: 1958-28-12)"},null,null,null,null,null,{"v":"http://www.powerhousemuseum.com/collection/database/?irn=267220"},{"v":"990 mm"},{"v":"380 mm"},{"v":"350 mm"},null,null,{"v":"This text content licensed under<a href=\"http://creativecommons.org/licenses/by-sa/2.5/au/\" rel=\"license\" about=\"http://www.powerhousemuseum.com/collection/database/?irn=267220#_cc-by-sa_content\">CC BY-SA<\/a>."}]}
	{"flagged":false,"starred":false,"cells":[{"v":346260},{"v":"Fragment of moon rock on loan from National Aeronautics and Space Administration (NASA), USA"},{"v":"L4115/1"},{"v":"Fragment of lunar sample (moon rock), NASA No.61016.116 (011) and box, weight of rock 89 grams, collected by Apollo 16 crewmember Charles Duke on the east rim of Plum Crater 30 meters west north of the landing site, 1972. This fragment is 3.9 billion years old. This is older than most of the surface rock on earth. The rock is beccia, fragments held together by a cementing substance."},null,null,null,null,{"v":"Mineral Samples-Geological"},{"v":"http://www.powerhousemuseum.com/collection/database/?irn=346260"},null,null,null,null,null,{"v":"This text content licensed under<a href=\"http://creativecommons.org/licenses/by-sa/2.5/au/\" rel=\"license\" about=\"http://www.powerhousemuseum.com/collection/database/?irn=346260#_cc-by-sa_content\">CC BY-SA<\/a>."}]}

	tmcphill@circe-win10:~$ tail -2 data.txt
	{"flagged":false,"starred":false,"cells":[{"v":7},{"v":"10002 [Timber] Samples (two in sections, polished on one side and hinged):- ... (SB)."},{"v":10002},{"v":"[Timber] Samples (two in sections, polished on one side and hinged):- ... (SB)."},null,null,null,null,{"v":"Botanical specimens|Numismatics"},{"v":"http://www.powerhousemuseum.com/collection/database/?irn=7"},null,null,null,null,null,{"v":"This text content licensed under<a href=\"http://creativecommons.org/licenses/by-sa/2.5/au/\" rel=\"license\" about=\"http://www.powerhousemuseum.com/collection/database/?irn=7#_cc-by-sa_content\">CC BY-SA<\/a>."}]}
	{"flagged":false,"starred":false,"cells":[{"v":93375},{"v":"Mambo poster designed by Reg Mombassa"},{"v":"89/1682"},{"v":"Poster, '100% Mambo / More a Part of the Landscape than a Pair of Trousers', process print, designed by Chris O'Doherty (also known as Reg Mombassa), Mambo Graphics, Sydney, New South Wales, 1988 Figure, wearing Mambo shorts, standing in alien landscape holding a microphone to a howling dog."},{"v":"Included in design on front, bottom right corner, artist's signature, 'REG MOMBASSA'."},null,{"v":"Designer: Mombassa, Reg|Maker: Mambo Graphics Pty Ltd; Sydney; 1988|"},null,{"v":"Posters|Pictorials"},{"v":"http://www.powerhousemuseum.com/collection/database/?irn=93375"},{"v":"640 mm"},{"v":"465 mm"},null,null,null,{"v":"This text content licensed under<a href=\"http://creativecommons.org/licenses/by-sa/2.5/au/\" rel=\"license\" about=\"http://www.powerhousemuseum.com/collection/database/?irn=93375#_cc-by-sa_content\">CC BY-SA<\/a>."}]}
	```

- Noted that while the data.txt file as a whole is not JSON, each individual row of data is formatted as JSON, with top-level properties flagged, starred, and cells:  The first row:

	```json
	{
	  "flagged": false,
	  "starred": false,
	  "cells": [
	    {
	      "v": 267220
	    },
	    {
	      "v": "Rocket motor on loan from Roswell Museum and Art Center, USA"
	    },
	    {
	      "v": "L2106-3/1"
	    },
	    {
	      "v": "Rocket motor, liquid fuelled combustion chamber, steel / aluminium wrapped tubes with insulation, included in flight of Dec 26 1928, ... "
	    },
	    null,
	    null,
	    null,
	    null,
	    null,
	    {
	      "v": "http://www.powerhousemuseum.com/collection/database/?irn=267220"
	    },
	    {
	      "v": "990 mm"
	    },
	    {
	      "v": "380 mm"
	    },
	    {
	      "v": "350 mm"
	    },
	    null,
	    null,
	    {
	      "v": "This text content licensed under<a href=\"http://creativecommons.org/licenses/by-sa/2.5/au/\" rel=\"license\" ...    
	    }
	  ]
	}
	```

- It is not obvious what the pool.txt file represents:

	```console
	 tmcphill@circe-win10:~$ cat pool.txt
	 3.1
	 reconCount=0
	```

- Closed browser window and stopped refine at the command prompt without making changes to the data set.

- Noted that the data.zip file is unchanged and still has a timestamp corresponding to the project-creation time above. The timestamp on metdata.json is earlier, likely the time of selecting the datafile for import but before creating the project.

	```console
	 tmcphill@circe-win10:~$ ls -al .local/share/openrefine/2548854995375.project
	 total 9860
	 drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 18:01 .
	 drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 18:31 ..
	 -rw-rw-rw- 1 tmcphill tmcphill 10018592 Mar  5 18:01 data.zip
	 -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  5 17:56 metadata.json
	```
  	
- Copied the project files, zipped and unzipped into another directory (~/or1) for later comparison:

	```console
	tmcphill@circe-win10:~$ ls -al or1/
	total 79888
	drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 18:42 .
	drwxr-xr-x 1 tmcphill tmcphill     4096 Mar  5 18:35 ..
	-rw-rw-rw- 1 tmcphill tmcphill 70264173 Mar  6  2019 data.txt
	-rw-rw-rw- 1 tmcphill tmcphill 10018592 Mar  5 18:42 data.zip
	-rw-rw-rw- 1 tmcphill tmcphill      888 Mar  5 18:42 metadata.json
	-rw-rw-rw- 1 tmcphill tmcphill       17 Mar  6  2019 pool.txt
	```

