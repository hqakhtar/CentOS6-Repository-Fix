#!/bin/bash

# Get the version so we know which repository to add
centos_version="$(cat /etc/redhat-release | awk '{print $3}')"

# Initialize varaibles; allow a user to specify another directory name for old unwanted CentOS repos
repodir_base="/etc/yum.repos.d"
repodir_old="${repodir_base}/${1:-old_repos}"
vault_repo="CentOS-Vault.${centos_version}.repo"

# Create the folder and move unwanted repo files to it
mkdir -p $repodir_old
find ${repodir_base}/CentOS*.repo -maxdepth 1 -type f -exec mv {} ${repodir_old} \;

# Generate the repo file for the current CentOS version
cat << EOF > ${repodir_base}/${vault_repo}

[C${centos_version}-base]
name=CentOS-${centos_version} - Base
baseurl=http://vault.centos.org/${centos_version}/os/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C${centos_version}-updates]
name=CentOS-${centos_version} - Updates
baseurl=http://vault.centos.org/${centos_version}/updates/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C${centos_version}-extras]
name=CentOS-${centos_version} - Extras
baseurl=http://vault.centos.org/${centos_version}/extras/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C${centos_version}-contrib]
name=CentOS-${centos_version} - Contrib
baseurl=http://vault.centos.org/${centos_version}/contrib/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1

[C${centos_version}-centosplus]
name=CentOS-${centos_version} - CentOSPlus
baseurl=http://vault.centos.org/${centos_version}/centosplus/\$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
enabled=1
EOF

# Clean and update yum cache
yum clean all
yum makecache
