## 2019-03-11 Install Vagrant using Chocolatey

### Background
- The computing environment for this project should be compatible with running in a VM.
- Vagrant makes it easy to deploy and manage VMs, and version-control and share their definitions.
- Vagrant works on Windows, MacOS, and Linux so can be a universal platform for sharing computing environments.

### Installed Chocolately on Windows 10
- Vagrant can be installed on Wndows easily using Chocolatey: https://chocolatey.org/packages/vagrant
- Found Installation instructions for Chocolatey at:  https://chocolatey.org/install
- Started PowerShell as Administrator.
- Checked powershell script execution policy:

    ```console
    PS C:\WINDOWS\system32>  get-executionpolicy
    RemoteSigned
    ```
- Ran installation script found at https://chocolatey.org/install.ps1:

    ```console
    PS C:\WINDOWS\system32> iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Getting latest version of the Chocolatey package for download.
    Getting Chocolatey from https://chocolatey.org/api/v2/package/chocolatey/0.10.11.
    Extracting C:\Users\tmcphill\AppData\Local\Temp\chocolatey\chocInstall\chocolatey.zip to C:\Users\tmcphill\AppData\Local\Temp\chocolatey\chocInstall...
    Installing chocolatey on this machine
    Creating ChocolateyInstall as an environment variable (targeting 'Machine')
      Setting ChocolateyInstall to 'C:\ProgramData\chocolatey'
    WARNING: It's very likely you will need to close and reopen your shell
      before you can use choco.
    Restricting write permissions to Administrators
    We are setting up the Chocolatey package repository.
    The packages themselves go to 'C:\ProgramData\chocolatey\lib'
      (i.e. C:\ProgramData\chocolatey\lib\yourPackageName).
    A shim file for the command line goes to 'C:\ProgramData\chocolatey\bin'
      and points to an executable in 'C:\ProgramData\chocolatey\lib\yourPackageName'.
    
    Creating Chocolatey folders if they do not already exist.
    
    WARNING: You can safely ignore errors related to missing log files when
      upgrading from a version of Chocolatey less than 0.9.9.
      'Batch file could not be found' is also safe to ignore.
      'The system cannot find the file specified' - also safe.
    chocolatey.nupkg file not installed in lib.
     Attempting to locate it from bootstrapper.
    PATH environment variable does not have C:\ProgramData\chocolatey\bin in it. Adding...
    WARNING: Not setting tab completion: Profile file does not exist at
    'C:\Users\tmcphill\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
    Chocolatey (choco.exe) is now ready.
    You can call choco from anywhere, command line or powershell by typing choco.
    Run choco /? for a list of functions.
    You may need to shut down and restart powershell and/or consoles
     first prior to using choco.
    Ensuring chocolatey commands are on the path
    Ensuring chocolatey.nupkg is in the lib folder
    ```

- Checked version of Chocolatey just installed:

    ```console
    PS C:\WINDOWS\system32> choco --version
    0.10.11

    PS C:\Users\tmcphill> choco
    Chocolatey v0.10.11
    Please run 'choco -?' or 'choco <command> -?' for help menu.
    ```

### Installed Vagrant using Chocolatey

- Found Vagrant package for Chocolatey:  https://chocolatey.org/packages/vagrant
- Installed Vagrant using PowerShell running as Administrator:

    ```console
    PS C:\WINDOWS\system32> choco install vagrant
    Chocolatey v0.10.11
    Installing the following packages:
    vagrant
    By installing you accept licenses for the packages.
    Progress: Downloading vagrant 2.2.4... 100%
    
    vagrant v2.2.4 [Approved]
    vagrant package files install completed. Performing other installation steps.
    The package vagrant wants to run 'chocolateyinstall.ps1'.
    Note: If you don't run this script, the installation will fail.
    Note: To confirm automatically next time, use '-y' or consider:
    choco feature enable -n allowGlobalConfirmation
    Do you want to run the script?([Y]es/[N]o/[P]rint): Y
    
    Downloading vagrant 64 bit
      from 'https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi'
    Progress: 100% - Completed download of C:\Users\tmcphill\AppData\Local\Temp\chocolatey\vagrant\2.2.4\vagrant_2.2.4_x86_64.msi (229.22 MB).
    Download of vagrant_2.2.4_x86_64.msi (229.22 MB) completed.
    Hashes match.
    Installing vagrant...
    vagrant has been installed.
    Repairing currently installed global plugins. This may take a few minutes...
    Installed plugins successfully repaired!
      vagrant may be able to be automatically uninstalled.
    Environment Vars (like PATH) have changed. Close/reopen your shell to
     see the changes (or in powershell/cmd.exe just type `refreshenv`).
     The install of vagrant was successful.
      Software installed as 'msi', install location is likely default.
    
    Chocolatey installed 1/1 packages.
     See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
    
    Packages requiring reboot:
     - vagrant (exit code 3010)
    
    The recent package changes indicate a reboot is necessary.
     Please reboot at your earliest convenience.
    ```
 - Checked version of vagrant in a new PowerShell instance:

    ```console
   PS C:\Users\tmcphill> vagrant --version
   Vagrant 2.2.4
    ```

### Created a first VM using Vagrant 

- Because Hyper-V will be the hypervisor, Vagrant must run as Administrator.
- Created a directory C:\vagrant.
- Created a VM using the hashicorp/precise64 box:

    ```console
    PS C:\vagrant> vagrant up
    Bringing machine 'default' up with 'hyperv' provider...
    ==> default: Verifying Hyper-V is enabled...
    ==> default: Verifying Hyper-V is accessible...
    ==> default: Box 'hashicorp/precise64' could not be found. Attempting to find and install...
        default: Box Provider: hyperv
        default: Box Version: >= 0
    ==> default: Loading metadata for box 'hashicorp/precise64'
        default: URL: https://vagrantcloud.com/hashicorp/precise64
    ==> default: Adding box 'hashicorp/precise64' (v1.1.0) for provider: hyperv
        default: Downloading: https://vagrantcloud.com/hashicorp/boxes/precise64/versions/1.1.0/providers/hyperv.box
        default: Download redirected to host: vagrantcloud-files-production.s3.amazonaws.com
        default:
    ==> default: Successfully added box 'hashicorp/precise64' (v1.1.0) for 'hyperv'!
    ==> default: Importing a Hyper-V instance
        default: Creating and registering the VM...
        default: Successfully imported VM
        default: Please choose a switch to attach to your Hyper-V instance.
        default: If none of these are appropriate, please open the Hyper-V manager
        default: to create a new virtual switch.
        default:
        default: 1) DockerNAT
        default: 2) Default Switch
        default:
        default: What switch would you like to use? 2
        default: Configuring the VM...
    ==> default: Starting the machine...
    ==> default: Waiting for the machine to report its IP address...
        default: Timeout: 120 seconds
        default: IP: 172.24.109.170
    ==> default: Waiting for machine to boot. This may take a few minutes...
        default: SSH address: 172.24.109.170:22
        default: SSH username: vagrant
        default: SSH auth method: password
        default:
        default: Inserting generated public key within guest...
        default: Removing insecure key from the guest if it's present...
        default: Key inserted! Disconnecting and reconnecting using new SSH key...
    ==> default: Machine booted and ready!
    ==> default: Preparing SMB shared folders...
        default: You will be asked for the username and password to use for the SMB
        default: folders shortly. Please use the proper username/password of your
        default: account.
        default:
        default: Username: tmcphill
        default: Password (will be hidden):
    
    Vagrant requires administrator access to create SMB shares and
    may request access to complete setup of configured shares.
    ==> default: Mounting SMB shared folders...
        default: C:/vagrant => /vagrant
    ```

- SSH'd into new Ubuntu VM:

    ```console
    PS C:\vagrant> vagrant ssh
    Welcome to Ubuntu 12.04.4 LTS (GNU/Linux 3.11.0-15-generic x86_64)
    
     * Documentation:  https://help.ubuntu.com/
    Last login: Thu Mar  6 09:02:28 2014
    
    vagrant@precise64:~$ uname -a
    Linux precise64 3.11.0-15-generic #25~precise1-Ubuntu SMP Thu Jan 30 17:39:31 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
    vagrant@precise64:~$ ls /vagrant/
    Vagrantfile
    vagrant@precise64:~$ ls -al /vagrant/
    total 8
    drwxr-xr-x  2 vagrant vagrant    0 Mar 11 23:08 .
    drwxr-xr-x 24 root    root    4096 Mar 11 23:14 ..
    drwxr-xr-x  0 vagrant vagrant    0 Mar 11 23:08 .vagrant
    -rwxr-xr-x  0 vagrant vagrant 3096 Mar 11 23:07 Vagrantfile
    vagrant@precise64:~$
    ```




