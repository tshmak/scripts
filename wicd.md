# This note is for installing [wicd](https://wiki.archlinux.org/index.php/Wicd) to replace NetworkManger in Ubuntu 

However, it appears that wicd is not actively maintained (see above link). So, don't use it unless it's a last resort. 

Anyway, here's what to do, based on https://wiki.archlinux.org/index.php/Wicd and https://help.ubuntu.com/community/WICD#Configuring_WICD 

1. Install wicd: `sudo apt-get install wicd-gtk`

Note that this will automatically start wicd. However, we should not run wicd and NetworkManger together. So we need to stop and disable NetworkManger. 

2. To disable NetworkManger, do: 
```
sudo systemctl stop NetworkManager.service
sudo systemctl disable NetworkManager.service

sudo systemctl stop NetworkManager-wait-online.service
sudo systemctl disable NetworkManager-wait-online.service

sudo systemctl stop NetworkManager-dispatcher.service
sudo systemctl disable NetworkManager-dispatcher.service

sudo systemctl stop network-manager.service
sudo systemctl disable network-manager.service
```

To reenable if you give up on wicd, run
```
sudo systemctl enable NetworkManager.service
sudo systemctl enable NetworkManager-wait-online.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl enable network-manager.service
```

3. As noted in (1) above, wicd should already be running at this point. To check, type `systemctl status wicd.service`. If not, then type `systemctl start wicd.service`. 

4. Now launch wicd by running `wicd-client`. A GUI should pop up in gnome. Now select the network and ask it to remember. It should automatically connect when you start up the computer. 

5. Ideally that's it. However, the wicd notification tray icon is too old for my gnome desktop. To enable it, I had to install [Topicon plus](https://extensions.gnome.org/extension/1031/topicons/), which I had to do by enabling the gnome-shell-integration add-on in chrome.  
