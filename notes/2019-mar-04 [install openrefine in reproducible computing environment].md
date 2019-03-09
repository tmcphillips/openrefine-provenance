---


---

<h3 id="mar-04-install-openrefine-in-reproducible-computing-environment">2019-mar-04 Install OpenRefine in reproducible computing environment</h3>
<h4 id="found-requirements-for-installing-openrefine-3.1-release">Found requirements for installing OpenRefine 3.1 release</h4>
<ul>
<li>OpenRefine home page: <a href="http://openrefine.org/">http://openrefine.org/</a></li>
<li>Download page: <a href="http://openrefine.org/download.html">http://openrefine.org/download.html</a></li>
<li>Linux installation instructions: <a href="https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions">https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions</a></li>
<li>Only installation prerequisite is 64-bit JRE: <a href="https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions#requirements">https://github.com/OpenRefine/OpenRefine/wiki/Installation-Instructions#requirements</a></li>
</ul>
<h4 id="installed-jdk-8-in-wsl-debian-environment">Installed JDK 8 in WSL Debian environment</h4>
<ul>
<li>
<p>Confirmed Java not installed in WSL-Debian:</p>
<pre><code>   (.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ java -version    
   -bash: java: command not found
   
   (.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ javac -version
   -bash: javac: command not found
</code></pre>
</li>
<li>
<p>Wrote new playbook for installing openjdk-8-jdk:</p>
<pre><code>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ cat jdk8.yml
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
</code></pre>
</li>
<li>
<p>Installed JDK 8 using ansible:</p>
<pre><code>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ansible-playbook -K jdk8.yml
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
</code></pre>
</li>
<li>
<p>Confirmed that java and javac are now installed and expected version:</p>
<pre><code>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ java -version
openjdk version "1.8.0_181"
OpenJDK Runtime Environment (build 1.8.0_181-8u181-b13-2~deb9u1-b13)
OpenJDK 64-Bit Server VM (build 25.181-b13, mixed mode)

(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ javac -version
javac 1.8.0_181
</code></pre>
</li>
</ul>
<h4 id="installed-openrefine">Installed OpenRefine</h4>
<ul>
<li>
<p>Found download link for Linux tarball: <a href="https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz">https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz</a></p>
</li>
<li>
<p>Created playbook for installing OpenRefine under home directory:</p>
</li>
</ul>
<p>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ cat openrefine.yml</p>
<hr>
<ul>
<li>name: install OpenRefine 3.1</li>
</ul>
<p>hosts: 127.0.0.1</p>
<p>connection: local</p>
<p>tasks:</p>
<ul>
<li>name: download and expand openrefine release</li>
</ul>
<p>unarchive:</p>
<p>remote_src: yes</p>
<p>src: <a href="https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz">https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz</a></p>
<p>dest: ${HOME}</p>
<ul>
<li>Ran playbook:</li>
</ul>
<p>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ansible-playbook openrefine.yml</p>
<p>[WARNING]: Unable to parse /etc/ansible/hosts as an inventory source</p>
<p>[WARNING]: No inventory was parsed, only implicit localhost is available</p>
<p>[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match ‘all’</p>
<p>PLAY [install OpenRefine 3.1] **************************************************************************************************************************************************************</p>
<p>TASK [Gathering Facts] *********************************************************************************************************************************************************************</p>
<p>ok: [127.0.0.1]</p>
<p>TASK [download and expand openrefine release] **********************************************************************************************************************************************</p>
<p>changed: [127.0.0.1]</p>
<p>PLAY RECAP ************************************************************************************************************************************************</p>
<p>127.0.0.1 : ok=2  changed=1  unreachable=0  failed=0</p>
<p>(.venv-ansible-playbooks) tmcphill@circe-win10:wsl-debian$ ls ~</p>
<p>bashrc_d <a href="http://bootstrap.sh">bootstrap.sh</a> GitRepos openrefine-3.1</p>
<ul>
<li>Printed openrefine help:</li>
</ul>
<p>tmcphill@circe-win10:openrefine-3.1$ ./refine -h</p>
<p>Usage: ./refine [options] </p>
<p>where [options] include:</p>
<p>-h print this message and exit</p>
<p>-p  the port that OpenRefine will listen to</p>
<p>default: 3333</p>
<p>-i  the host interface OpenRefine should bind to</p>
<p>default: 127.0.0.1</p>
<p>-w <path> path to the webapp</path></p>
<p>default: main/webapp</p>
<p>-d <path> path to the data directory</path></p>
<p>default: OS dependent</p>
<p>-m  max memory heap size to use</p>
<p>default: 1024M</p>
<p>-k  a server API key for calling Google APIs</p>
<p>-v  verbosity level [from low to high: error,warn,info,debug,trace]</p>
<p>default: info</p>
<p>-x &lt;name=value&gt; additional configuration parameters to pass to OpenRefine</p>
<p>default: [none]</p>
<p>–debug enable JVM debugging (on port 8000)</p>
<p>–jmx enable JMX monitoring (for jconsole and jvisualvm)</p>
<p>and  is one of</p>
<p>build … Build OpenRefine</p>
<p>run … Run OpenRefine [default]</p>
<p>test … Run all OpenRefine tests</p>
<p>server_test … Run only the server tests</p>
<p>ui_test … Run only the UI tests</p>
<p>extensions_test … Run only the extensions tests</p>
<p>broker … Run OpenRefine Broker</p>
<p>broker_appengine_run   … Run OpenRefine Broker for Google App Engine in local server</p>
<p>broker_appengine_upload   … Upload OpenRefine to Google App Engine</p>
<p>findbugs … Run Findbugs against OpenRefine</p>
<p>pmd … Run PMD against OpenRefine</p>
<p>cpd … Run Copy/Paste Detection against OpenRefine</p>
<p>jslint … Run JSlint against OpenRefine</p>
<p>whitespace  … Normalize whitespace in files with the given extension</p>
<p>mac_dist  … Make MacOSX binary distribution</p>
<p>windows_dist  … Make Windows binary distribution</p>
<p>linux_dist  … Make Linux binary distribution</p>
<p>dist  … Make all distributions</p>
<p>clean … Clean compiled classes</p>
<p>distclean … Remove all generated files</p>
<p>Ran OpenRefine and viewed in Firebox</p>
<ul>
<li>Started openrefine from the ~/openrefine-3.1 directory:</li>
</ul>
<p>tmcphill@circe-win10:openrefine-3.1$ ./refine</p>
<p>You have 16308M of free memory.</p>
<p>Your current configuration is set to use 1400M of memory.</p>
<p>OpenRefine can run better when given more memory. Read our FAQ on how to allocate more memory here:</p>
<p><a href="https://github.com/OpenRefine/OpenRefine/wiki/FAQ:-Allocate-More-Memory">https://github.com/OpenRefine/OpenRefine/wiki/FAQ:-Allocate-More-Memory</a></p>
<p>/usr/bin/java -cp server/classes:server/target/lib/* -Xms1400M -Xmx1400M -Drefine.memory=1400M -Drefine.max_form_content_size=1048576 -Drefine.verbosity=info -Dpython.path=main/webapp/WEB-INF/lib/jython -Dpython.cachedir=/home/tmcphill/.local/share/google/refine/cachedir -Drefine.webapp=main/webapp -Drefine.port=3333 -Drefine.host=127.0.0.1 com.google.refine.Refine</p>
<p>Starting OpenRefine at ‘<a href="http://127.0.0.1:3333/">http://127.0.0.1:3333/</a>’</p>
<p>23:41:08.163 [ refine_server] Starting Server bound to ‘127.0.0.1:3333’ (0ms)</p>
<p>23:41:08.166 [ refine_server] refine.memory size: 1400M JVM Max heap: 1407188992 (3ms)</p>
<p>23:41:08.178 [ refine_server] Initializing context: ‘/’ from ‘/home/tmcphill/openrefine-3.1/webapp’ (12ms)</p>
<p>SLF4J: Class path contains multiple SLF4J bindings.</p>
<p>SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/server/target/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]</p>
<p>SLF4J: Found binding in [jar:file:/home/tmcphill/openrefine-3.1/webapp/WEB-INF/lib/slf4j-log4j12-1.7.18.jar!/org/slf4j/impl/StaticLoggerBinder.class]</p>
<p>SLF4J: See <a href="http://www.slf4j.org/codes.html#multiple_bindings">http://www.slf4j.org/codes.html#multiple_bindings</a> for an explanation.</p>
<p>SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]</p>
<p>23:41:08.794 [ refine] Starting OpenRefine 3.1 [b90e413]… (616ms)</p>
<p>23:41:08.795 [ refine] initializing FileProjectManager with dir (1ms)</p>
<p>23:41:08.795 [ refine] /home/tmcphill/.local/share/openrefine (0ms)</p>
<p>23:41:09.892 [ database-extension] Initializing OpenRefine Database… (1097ms)</p>
<p>23:41:09.896 [ database-extension] Database Extension Mount point /extension/database/ [*] (4ms)</p>
<p>23:41:09.896 [ database-extension] Registering Database Extension Commands… (0ms)</p>
<p>23:41:09.910 [ database-extension] Database Extension Command Registeration done!! (14ms)</p>
<p>23:41:09.910 [ database-extension] Database Operations Registered successfully… (0ms)</p>
<p>23:41:09.911 [ database-extension] Database Functions Registered successfully… (1ms)</p>
<p>23:41:09.920 [ DatabaseModuleImpl] *** Database Extension Module Initialization Completed!!*** (9ms)</p>
<p>23:41:12.551 [ refine] Sorry, some error prevented us from launching the browser for you.</p>
<p>Point your browser to <a href="http://127.0.0.1:3333/">http://127.0.0.1:3333/</a> to start using Refine. (2631ms)</p>
<ul>
<li>Loaded interface in Firebox by navigating to 127.0.0.1:3333</li>
</ul>
<p><img src="https://lh3.googleusercontent.com/bQWFd-zBDZsggFFflCeV0u9xGYm6swnblVA3ZM5RXc9EN1wUMXMm9J-91gC5eCkBV9za4poY4WLAFqOKyZc47XwB5LhEYAsy1K4O5WTN5qFVGTmfuzX8I0tOyfXhSaKl60hFxIT3" alt=""></p>

