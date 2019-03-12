## 2019-03-04 Install OpenRefine in reproducible computing environment

### Found requirements for installing OpenRefine 3.1 release

-   OpenRefine home page: [http://openrefine.org/](http://openrefine.org/)
-   Download page: [http://openrefine.org/download.html](http://openrefine.org/download.html)
-   Linux installation instructions: [https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions](https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions)
-   Only installation prerequisite is 64-bit JRE: [https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions#requirements](https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions#requirements)

### Installed JDK 8 in WSL Debian environment

-   Confirmed Java not installed in WSL-Debian:

		   (.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ java -version    
		   -bash: java: command not found
		   
		   (.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ javac -version
		   -bash: javac: command not found

-   Wrote new playbook for installing openjdk-8-jdk:

		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ cat jdk8.yml
		---
		
		- name: install OpenJDK 8 JDK
		  hosts: 127.0.0.1
		  connection: local
		  become: yes
		  tasks:

		  - name: install openjdk-8-jdk
		    apt:
		        name: openjdk-8-jdk
		        update_cache: yes
		        state: latest

-   Installed JDK 8 using ansible:
  
		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ansible-playbook -K jdk8.yml
		SUDO password:
		 [WARNING]: Unable to parse /etc/ansible/hosts as an inventory source
		 [WARNING]: No inventory was parsed, only implicit localhost is available
		 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

		PLAY [install OpenJDK 8 JDK] **************************************************************************************************************************************************************

		TASK [Gathering Facts] **************************************************************************************************************************************************************
		ok: [127.0.0.1]

		TASK [install openjdk-8-jdk] **************************************************************************************************************************************************************
		ok: [127.0.0.1]

		PLAY RECAP **************************************************************************************************************************************************************
		127.0.0.1                  : ok=2    changed=0    unreachable=0    failed=0

-   Confirmed that java and javac are now installed and expected version:

		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ java -version
		openjdk version "1.8.0_181"
		OpenJDK Runtime Environment (build 1.8.0_181-8u181-b13-2~deb9u1-b13)
		OpenJDK 64-Bit Server VM (build 25.181-b13, mixed mode)

		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ javac -version
		javac 1.8.0_181

### Installed OpenRefine

-   Found download link for Linux tarball: [https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz](https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz)

-   Created playbook for installing OpenRefine under home directory:

		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ cat openrefine.yml
		---

		- name: install OpenRefine 3.1
		  hosts: 127.0.0.1
		  connection: local
		  tasks:

		  - name: download and expand openrefine release
		    unarchive:
		        remote_src: yes
		        src: https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz
		        dest: ${HOME}
-   Ran playbook:
  
		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ansible-playbook openrefine.yml
		 [WARNING]: Unable to parse /etc/ansible/hosts as an inventory source
		 [WARNING]: No inventory was parsed, only implicit localhost is available
		 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

		PLAY [install OpenRefine 3.1] **************************************************************************************************************************************************************

		TASK [Gathering Facts] *********************************************************************************************************************************************************************
		ok: [127.0.0.1]

		TASK [download and expand openrefine release] **********************************************************************************************************************************************
		changed: [127.0.0.1]

		PLAY RECAP ************************************************************************************************************************************************
		127.0.0.1                  : ok=2    changed=1    unreachable=0    failed=0

		(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ls ~
		bashrc_d  bootstrap.sh  GitRepos  openrefine-3.1

-   Printed OpenRefine help:
		
		tmcphill@circe-win10:openrefine-3.1$ ./refine -h
		Usage: ./refine [options] <action>
		where [options] include:

		  -h print this message and exit

		  -p <port> the port that OpenRefine will listen to
		     default: 3333

		  -i <interface> the host interface OpenRefine should bind to
		     default: 127.0.0.1

		  -w <path> path to the webapp
		     default: main/webapp

		  -d <path> path to the data directory
		     default: OS dependent

		  -m <memory> max memory heap size to use
		     default: 1024M

		  -k <google api key> a server API key for calling Google APIs

		  -v <level> verbosity level [from low to high: error,warn,info,debug,trace]
		     default: info

		  -x <name=value> additional configuration parameters to pass to OpenRefine
		     default: [none]

		  --debug enable JVM debugging (on port 8000)

		  --jmx enable JMX monitoring (for jconsole and jvisualvm)

		and <action> is one of

		   build ............................... Build OpenRefine
		   run ................................. Run OpenRefine [default]

		   test ................................ Run all OpenRefine tests
		   server_test ......................... Run only the server tests
		   ui_test ............................. Run only the UI tests
		   extensions_test ..................... Run only the extensions tests

		   broker .............................. Run OpenRefine Broker

		   broker_appengine_run <id> <ver> ..... Run OpenRefine Broker for Google App Engine in local server
		   broker_appengine_upload <id> <ver> .. Upload OpenRefine to Google App Engine

		   findbugs ............................ Run Findbugs against OpenRefine
		   pmd ................................. Run PMD against OpenRefine
		   cpd ................................. Run Copy/Paste Detection against OpenRefine
		   jslint .............................. Run JSlint against OpenRefine

		   whitespace <extension> .............. Normalize whitespace in files with the given extension

		   mac_dist <version> .................. Make MacOSX binary distribution
		   windows_dist <version> .............. Make Windows binary distribution
		   linux_dist <version> ................ Make Linux binary distribution
		   dist <version> ...................... Make all distributions

		   clean ............................... Clean compiled classes
		   distclean ........................... Remove all generated files

 
### Ran OpenRefine and viewed in Firefox

-   Started openrefine from the ~/openrefine-3.1 directory:
		
		tmcphill@circe-win10:openrefine-3.1$ ./refine
		You have 16308M of free memory.
		Your current configuration is set to use 1400M of memory.
		OpenRefine can run better when given more memory. Read our FAQ on how to allocate more memory here:
		https://github.com/OpenRefine/OpenRefine/wiki/FAQ:-Allocate-More-Memory
		/usr/bin/java -cp server/classes:server/target/lib/*   -Xms1400M -Xmx1400M -Drefine.memory=1400M -Drefine.max_form_content_size=1048576 -Drefine.verbosity=info -Dpython.path=main/webapp/WEB-INF/lib/jython -Dpython.cachedir=/home/tmcphill/.local/share/google/refine/cachedir -Drefine.webapp=main/webapp -Drefine.port=3333 -Drefine.host=127.0.0.1 com.google.refine.Refine
		Starting OpenRefine at 'http://127.0.0.1:3333/'

		23:41:08.163 [            refine_server] Starting Server bound to '127.0.0.1:3333' (0ms)
		23:41:08.166 [            refine_server] refine.memory size: 1400M JVM Max heap: 1407188992 (3ms)
		23:41:08.178 [            refine_server] Initializing context: '/' from '/home/tmcphill/openrefine-3.1/webapp' (12ms)
		SLF4J: Class path contains multiple SLF4J bindings.
		SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/server/target/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
		SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/webapp/WEB-INF/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]
		SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
		SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
		23:41:08.794 [                   refine] Starting OpenRefine 3.1 [b90e413]... (616ms)
		23:41:08.795 [                   refine] initializing FileProjectManager with dir (1ms)
		23:41:08.795 [                   refine] /home/tmcphill/.local/share/openrefine (0ms)
		23:41:09.892 [       database-extension] Initializing OpenRefine Database... (1097ms)
		23:41:09.896 [       database-extension] Database Extension Mount point /extension/database/ [*] (4ms)
		23:41:09.896 [       database-extension] Registering Database Extension Commands...... (0ms)
		23:41:09.910 [       database-extension] Database Extension Command Registeration done!! (14ms)
		23:41:09.910 [       database-extension] Database Operations Registered successfully... (0ms)
		23:41:09.911 [       database-extension] Database Functions Registered successfully... (1ms)
		23:41:09.920 [       DatabaseModuleImpl] *** Database Extension Module Initialization Completed!!*** (9ms)
		23:41:12.551 [                   refine] Sorry, some error prevented us from launching the browser for you.

		 Point your browser to http://127.0.0.1:3333/ to start using Refine. (2631ms)

-   Loaded interface in Firebox by navigating to 127.0.0.1:3333

	![](https://lh3.googleusercontent.com/bQWFd-zBDZsggFFflCeV0u9xGYm6swnblVA3ZM5RXc9EN1wUMXMm9J-91gC5eCkBV9za4poY4WLAFqOKyZc47XwB5LhEYAsy1K4O5WTN5qFVGTmfuzX8I0tOyfXhSaKl60hFxIT3)







