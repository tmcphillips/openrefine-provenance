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

