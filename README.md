# CentOS6 - Repository Fix

With CentOS6 being EOL now, lots of users are facing a challenge in finding the proper yum repositories as the current CentOS repository URLs are no longer serving out RPM packages. The repositories are now available but under a different URL. So rather doing this manually, I created this script and thought it might help others.

Simply run this bash script. It will move all old unwanted CentOS yum repositories to another folder (rather than disabling those). One could use yum-config-manager instead, but only if you have that installed already!

## USAGE
```
./centos6_repo_fix.sh
```
OR
```
./centos6_repo_fix.sh unwanted_repos
```
In the first option, all files CentOS.*repo files will be moved to "/etc/yum.repos.d/old_repos" folder, whereas in the second one, all files will be moved to "/etc/yum.repos.d/unwanted_repos".


**NOTE:**

This is a hack, and it works for me. Use it at your own risk!
