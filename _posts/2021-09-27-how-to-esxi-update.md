---
title: Install ESXi updates from command line
categories: how-to
tags: how-to esxi
---

How to install ESXi updates from command line

## 1. Allow outbound HTTP requests  

```bash
esxcli network firewall ruleset set -e true -r httpClient
```

## 2. List of all available ESXi profiles  

```bash
esxcli software sources profile list --depot=https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml |grep ESXi-7
```

## 3. Dry Run 

```bash
esxcli software profile update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml -p ESXi-7.0U1b-17168206-standard --dry-run
```

## 4. Install Update

```bash
esxcli software profile update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml -p ESXi-7.0U1b-17168206-standard
```


## 5. Disable outbound HTTP requests  

```bash
esxcli network firewall ruleset set -e false -r httpClient
```

## 6. Reboot 


## 7. Troubleshooting

Sometimes this error occurs during update
```bash
# Common error
[InstallationError]
[Errno 28] No space left on device
       vibs = VMware_locker_tools-light_11.0.5.15389592-15999342

# Install without tools
esxcli software profile update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml -p ESXi-6.7.0-20191204001-no-tools

# Install the tools after
esxcli software vib install -v https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/esx/vmw/vib20/tools-light/VMware_locker_tools-light_11.0.5.15389592-15999342.vib


```
https://my.vmware.com/group/vmware/downloads/details?downloadGroup=VMTOOLS1120-OSS&productId=1073