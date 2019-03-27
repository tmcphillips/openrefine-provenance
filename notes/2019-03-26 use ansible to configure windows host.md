## 2019-03-26 Use Ansible to configure Windows host

### Background

- I want to be able to quickly reproduce the computing environment I am using for this project on multiple desktop, laptop, and tablet systems running Windows.
- Ansible is convenient for configuring the Linux environment (within WSL or in a Vagrant-managed VM) running on these systems, but I also would like to reproduce key elements of the rest of the host computing environment, including Windows configuration and applications, using the same configuration management system.
- Examples include the process of installing Vagrant in the first place; ensuring Hyper-V is enabled before installing Vagrant; installing Chrome and StackEdit for note-taking; installing and configuring Docker; and installing Visual Studio Code and plugins.
- Ansible can be used to configure Windows systems using native PowerShell  remoting via the [WinRM](https://docs.microsoft.com/en-us/windows/desktop/WinRM/portal) (Windows Remote Management) protocol rather than SSH, and launched by Ansible running in a Linux environment: [Ansible Windows Support](https://docs.ansible.com/ansible/2.4/intro_windows.html).
- I will try to configure the Windows system hosting the WSL Debian environment using Ansible in that WSL environment.

### Enabled Ansible access to circe-win10 over WinRM

- Followed instructions at [Ansible Windows System Prep](https://docs.ansible.com/ansible/2.4/intro_windows.html#windows-system-prep) downloaded the PowerShell script for enabling WinRM access for Ansible:

    ```console
    PS C:\Temp> wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -O ConfigureRemotingForAnsible.ps1
    ```

- Ran the script as Administrator:

    ```console
    PS C:\Temp> .\ConfigureRemotingForAnsible.ps1
    Self-signed SSL certificate generated; thumbprint: E25829742C6550AE04218F521A601376FAD5B177
    
    
    wxf                 : http://schemas.xmlsoap.org/ws/2004/09/transfer
    a                   : http://schemas.xmlsoap.org/ws/2004/08/addressing
    w                   : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
    lang                : en-US
    Address             : http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous
    ReferenceParameters : ReferenceParameters
    
    Ok.
    ```
- Ran script again with verbose output, noting that everything looks good:

    ```console
    PS C:\Temp> .\ConfigureRemotingForAnsible.ps1 -Verbose
    VERBOSE: Verifying WinRM service.
    VERBOSE: PS Remoting is already enabled.
    VERBOSE: SSL listener is already active.
    VERBOSE: Basic auth is already enabled.
    VERBOSE: Firewall rule already exists to allow WinRM HTTPS.
    VERBOSE: HTTP: Disabled | HTTPS: Enabled
    VERBOSE: PS Remoting has been successfully configured for Ansible.
    ```
### Enabled and tested Ansible access to Windows host from WSL Debian environment
 
- Activated the ansible virtual environment and installed the pywinrm package:

    ```console
     tmcphill@circe-win10:~$ . /tmp/bootstrap_ansible_xIa6Xm/ansible-venv/bin/activate
     
    (ansible-venv) tmcphill@circe-win10:~$ pip install pywinrm
    DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
    Collecting pywinrm
      Downloading https://files.pythonhosted.org/packages/0d/12/13a3117bbd2230043aa32dcfa2198c33269665eaa1a8fa26174ce49b338f/pywinrm-0.3.0-py2.py3-none-any.whl
    Collecting xmltodict (from pywinrm)
      Downloading https://files.pythonhosted.org/packages/28/fd/30d5c1d3ac29ce229f6bdc40bbc20b28f716e8b363140c26eff19122d8a5/xmltodict-0.12.0-py2.py3-none-any.whl
    Collecting requests-ntlm>=0.3.0 (from pywinrm)
      Downloading https://files.pythonhosted.org/packages/03/4b/8b9a1afde8072c4d5710d9fa91433d504325821b038e00237dc8d6d833dc/requests_ntlm-1.1.0-py2.py3-none-any.whl
    Requirement already satisfied: six in /usr/lib/python2.7/dist-packages (from pywinrm) (1.10.0)
    Collecting requests>=2.9.1 (from pywinrm)
      Downloading https://files.pythonhosted.org/packages/7d/e3/20f3d364d6c8e5d2353c72a67778eb189176f08e873c9900e10c0287b84b/requests-2.21.0-py2.py3-none-any.whl (57kB)
        100% |████████████████████████████████| 61kB 651kB/s
    Collecting ntlm-auth>=1.0.2 (from requests-ntlm>=0.3.0->pywinrm)
      Downloading https://files.pythonhosted.org/packages/8e/5b/4047779fb456b0de503c4acb7b166becf2567efb772abb53998440791d3c/ntlm_auth-1.2.0-py2.py3-none-any.whl
    Requirement already satisfied: cryptography>=1.3 in /usr/lib/python2.7/dist-packages (from requests-ntlm>=0.3.0->pywinrm) (1.7.1)
    Collecting urllib3<1.25,>=1.21.1 (from requests>=2.9.1->pywinrm)
      Downloading https://files.pythonhosted.org/packages/62/00/ee1d7de624db8ba7090d1226aebefab96a2c71cd5cfa7629d6ad3f61b79e/urllib3-1.24.1-py2.py3-none-any.whl (118kB)
        100% |████████████████████████████████| 122kB 1.1MB/s
    Collecting idna<2.9,>=2.5 (from requests>=2.9.1->pywinrm)
      Downloading https://files.pythonhosted.org/packages/14/2c/cd551d81dbe15200be1cf41cd03869a46fe7226e7450af7a6545bfc474c9/idna-2.8-py2.py3-none-any.whl (58kB)
        100% |████████████████████████████████| 61kB 1.3MB/s
    Collecting chardet<3.1.0,>=3.0.2 (from requests>=2.9.1->pywinrm)
      Downloading https://files.pythonhosted.org/packages/bc/a9/01ffebfb562e4274b6487b4bb1ddec7ca55ec7510b22e4c51f14098443b8/chardet-3.0.4-py2.py3-none-any.whl (133kB)
        100% |████████████████████████████████| 143kB 1.5MB/s
    Collecting certifi>=2017.4.17 (from requests>=2.9.1->pywinrm)
      Downloading https://files.pythonhosted.org/packages/60/75/f692a584e85b7eaba0e03827b3d51f45f571c2e793dd731e598828d380aa/certifi-2019.3.9-py2.py3-none-any.whl (158kB)
        100% |████████████████████████████████| 163kB 1.7MB/s
    Installing collected packages: xmltodict, ntlm-auth, urllib3, idna, chardet, certifi, requests, requests-ntlm, pywinrm
      Found existing installation: idna 2.2
        Not uninstalling idna at /usr/lib/python2.7/dist-packages, outside environment /tmp/bootstrap_ansible_xIa6Xm/ansible-venv
        Can't uninstall 'idna'. No files were found to uninstall.
    Successfully installed certifi-2019.3.9 chardet-3.0.4 idna-2.8 ntlm-auth-1.2.0 pywinrm-0.3.0 requests-2.21.0 requests-ntlm-1.1.0 urllib3-1.24.1 xmltodict-0.12.0
    ```
- Added the file /etc/ansible/hosts with a single line in WSL Debian environment (password redacted in notes):

    ```console
    root@circe-win10:/etc/ansible# cat hosts
    [windows]
    172.24.1.244 ansible_port=5986 ansible_connection=winrm ansible_user=tmcphill ansible_password=XXXXXXXX ansible_winrm_server_cert_validation=ignore
    ```
- Successfully ran the [setup](https://docs.ansible.com/ansible/latest/modules/setup_module.html) module against the Windows host, listing the variables available to Ansible playbooks and modules:

    ```console
    (ansible-venv) tmcphill@circe-win10:~$ ansible windows  -m setup
    localhost | SUCCESS => 
    ```
    ```json
    {
        "ansible_facts": {
            "ansible_architecture": "64-bit",
            "ansible_bios_date": "10/01/2018",
            "ansible_bios_version": "389.2370.769",
            "ansible_date_time": {
                "date": "2019-03-26",
                "day": "26",
                "epoch": "1553624118.28136",
                "hour": "18",
                "iso8601": "2019-03-27T01:15:18Z",
                "iso8601_basic": "20190326T181518277863",
                "iso8601_basic_short": "20190326T181518",
                "iso8601_micro": "2019-03-27T01:15:18.277863Z",
                "minute": "15",
                "month": "03",
                "second": "18",
                "time": "18:15:18",
                "tz": "Pacific Standard Time",
                "tz_offset": "-07:00",
                "weekday": "Tuesday",
                "weekday_number": "2",
                "weeknumber": "12",
                "year": "2019"
            },
            "ansible_distribution": "Microsoft Windows 10 Pro",
            "ansible_distribution_major_version": "10",
            "ansible_distribution_version": "10.0.17763.0",
            "ansible_domain": "",
            "ansible_env": {
                "ALLUSERSPROFILE": "C:\\ProgramData",
                "APPDATA": "C:\\Users\\tmcphill\\AppData\\Roaming",
                "COMPUTERNAME": "CIRCE-WIN10",
                "ChocolateyInstall": "C:\\ProgramData\\chocolatey",
                "ChocolateyLastPathUpdate": "Mon Mar 11 22:26:23 2019",
                "ComSpec": "C:\\WINDOWS\\system32\\cmd.exe",
                "CommonProgramFiles": "C:\\Program Files\\Common Files",
                "CommonProgramFiles(x86)": "C:\\Program Files (x86)\\Common Files",
                "CommonProgramW6432": "C:\\Program Files\\Common Files",
                "DriverData": "C:\\Windows\\System32\\Drivers\\DriverData",
                "HOMEDRIVE": "C:",
                "HOMEPATH": "\\Users\\tmcphill",
                "LOCALAPPDATA": "C:\\Users\\tmcphill\\AppData\\Local",
                "LOGONSERVER": "\\\\CIRCE-WIN10",
                "MSMPI_BIN": "C:\\Program Files\\Microsoft MPI\\Bin",
                "NUMBER_OF_PROCESSORS": "8",
                "OS": "Windows_NT",
                "OneDrive": "C:\\Users\\tmcphill\\OneDrive",
                "OneDriveConsumer": "C:\\Users\\tmcphill\\OneDrive",
                "PATHEXT": ".COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.PY;.PYW;.CPL",
                "PROCESSOR_ARCHITECTURE": "AMD64",
                "PROCESSOR_IDENTIFIER": "Intel64 Family 6 Model 142 Stepping 10, GenuineIntel",
                "PROCESSOR_LEVEL": "6",
                "PROCESSOR_REVISION": "8e0a",
                "PROMPT": "$P$G",
                "PSExecutionPolicyPreference": "Unrestricted",
                "PSModulePath": "C:\\Users\\tmcphill\\Documents\\WindowsPowerShell\\Modules;C:\\Program Files\\WindowsPowerShell\\Modules;C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\Modules",
                "PUBLIC": "C:\\Users\\Public",
                "Path": "C:\\Program Files (x86)\\Common Files\\Oracle\\Java\\javapath;C:\\Program Files\\Docker\\Docker\\Resources\\bin;C:\\Program Files\\Python36\\Scripts\\;C:\\Program Files\\Python36\\;C:\\Program Files\\Microsoft MPI\\Bin\\;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;C:\\WINDOWS\\System32\\OpenSSH\\;C:\\Program Files\\dotnet\\;C:\\Program Files\\Microsoft SQL Server\\130\\Tools\\Binn\\;C:\\Program Files\\Microsoft VS Code\\bin;C:\\Program Files (x86)\\Google\\Google Apps Sync\\;C:\\Program Files (x86)\\Google\\Google Apps Migration\\;C:\\Program Files (x86)\\NVIDIA Corporation\\PhysX\\Common;C:\\Program Files\\NVIDIA Corporation\\NVIDIA NvDLISR;C:\\Program Files\\Git\\cmd;C:\\ProgramData\\chocolatey\\bin;C:\\HashiCorp\\Vagrant\\bin;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;C:\\WINDOWS\\System32\\OpenSSH\\;C:\\Program Files\\PowerShell\\6\\;C:\\Users\\tmcphill\\AppData\\Local\\Microsoft\\WindowsApps;C:\\Users\\tmcphill\\AppData\\Local\\GitHubDesktop\\bin;C:\\Users\\tmcphill\\AppData\\Local\\Microsoft\\WindowsApps;C:\\Users\\tmcphill\\AppData\\Local\\Programs\\Microsoft VS Code\\bin",
                "ProgramData": "C:\\ProgramData",
                "ProgramFiles": "C:\\Program Files",
                "ProgramFiles(x86)": "C:\\Program Files (x86)",
                "ProgramW6432": "C:\\Program Files",
                "SystemDrive": "C:",
                "SystemRoot": "C:\\WINDOWS",
                "TEMP": "C:\\Users\\tmcphill\\AppData\\Local\\Temp",
                "TMP": "C:\\Users\\tmcphill\\AppData\\Local\\Temp",
                "USERDOMAIN": "CIRCE-WIN10",
                "USERDOMAIN_ROAMINGPROFILE": "CIRCE-WIN10",
                "USERNAME": "tmcphill",
                "USERPROFILE": "C:\\Users\\tmcphill",
                "asl.log": "Destination=file",
                "windir": "C:\\WINDOWS"
            },
            "ansible_fqdn": "circe-win10.",
            "ansible_hostname": "CIRCE-WIN10",
            "ansible_interfaces": [
                {
                    "connection_name": "vEthernet (Default Switch) 2",
                    "default_gateway": null,
                    "dns_domain": null,
                    "interface_index": 35,
                    "interface_name": "Hyper-V Virtual Ethernet Adapter #3",
                    "macaddress": "02:15:5D:77:F0:AC"
                },
                {
                    "connection_name": "vEthernet (DockerNAT)",
                    "default_gateway": null,
                    "dns_domain": null,
                    "interface_index": 22,
                    "interface_name": "Hyper-V Virtual Ethernet Adapter #4",
                    "macaddress": "00:15:5D:00:05:03"
                },
                {
                    "connection_name": "Ethernet 3",
                    "default_gateway": "172.24.1.1",
                    "dns_domain": "local",
                    "interface_index": 8,
                    "interface_name": "Surface Ethernet Adapter",
                    "macaddress": "28:16:A8:04:2B:B5"
                }
            ],
            "ansible_ip_addresses": [
                "172.17.242.193",
                "fe80::543e:f6bf:9a6:455b",
                "10.0.75.1",
                "fe80::b1f2:5709:b981:242c",
                "172.24.1.244",
                "fe80::c961:efe6:5531:aa12"
            ],
            "ansible_kernel": "10.0.17763.0",
            "ansible_lastboot": "2019-03-25 09:01:14Z",
            "ansible_machine_id": "S-1-5-21-2455563023-2196983525-4126008006",
            "ansible_memtotal_mb": 16309,
            "ansible_nodename": "circe-win10.",
            "ansible_os_family": "Windows",
            "ansible_os_name": "Microsoft Windows 10 Pro",
            "ansible_os_product_type": "workstation",
            "ansible_owner_contact": "",
            "ansible_owner_name": "",
            "ansible_powershell_version": 5,
            "ansible_processor": [
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz",
                "GenuineIntel",
                "Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz"
            ],
            "ansible_processor_cores": 4,
            "ansible_processor_count": 1,
            "ansible_processor_threads_per_core": 2,
            "ansible_processor_vcpus": 8,
            "ansible_product_name": "Surface Book 2",
            "ansible_product_serial": "032789680257",
            "ansible_reboot_pending": true,
            "ansible_swaptotal_mb": 0,
            "ansible_system": "Win32NT",
            "ansible_system_description": "Circe - Tim's Surface Book 2",
            "ansible_system_vendor": "Microsoft Corporation",
            "ansible_uptime_seconds": 119646,
            "ansible_user_dir": "C:\\Users\\tmcphill",
            "ansible_user_gecos": "",
            "ansible_user_id": "tmcphill",
            "ansible_user_sid": "S-1-5-21-2455563023-2196983525-4126008006-1001",
            "ansible_win_rm_certificate_expires": "2022-03-24 10:25:55",
            "ansible_windows_domain": "WORKGROUP",
            "ansible_windows_domain_member": false,
            "ansible_windows_domain_role": "Stand-alone workstation",
            "gather_subset": [
                "all"
            ],
            "module_setup": true
        },
        "changed": false
    }
    ```

