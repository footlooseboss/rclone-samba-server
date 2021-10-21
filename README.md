# Rclone-Samba-Server
This docker image provides you with a small [samba-server](https://github.com/dperson/samba) that exposes your [rclone](https://rclone.org) remote. You can then access all your rclones remote files via SMB/CIFS.

If you need to expose an rclone mount via NFS, also have a look at our [rclone-nfs-server](https://gitlab.com/encircle360-oss/rclone-nfs-server) project.

## Quickstart
Your rclone.conf file in the directory you mount into the docker container _needs to contain_ a remote with the name `remote`. Only this remote will be mounted and exposed via SMB/CIFS.

```
[remote] # the name here is important
type = crypt
remote = gdrive:storage/rclone-path
filename_encryption = standard
directory_name_encryption = true
... further settings
```

```
docker run -v /path/to/rclone/confdir:/rclone/config -e SHARE="remote;/mnt/remote" -p 0.0.0.0:139:139 -p 0.0.0.0:445:445 registry.gitlab.com/encircle360-oss/rclone-samba-server:latest
```

Afterwards just use the Samba client or tool you want to connect to the host you binded. In case of the example it's the host which runs docker (`10.10.10.10`).

```
mkdir -p /mnt/test
sudo mount -t cifs //10.10.10.10/<share> /mnt/test
```

### Complete Mac OS example (public share without credentials)
```
docker run -e NMBD=true -e SHARE="public;/mnt/remote" -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp --cap-add SYS_ADMIN --device /dev/fuse -d --name samba  --restart always -v /path/to/rclone/confdir:/rclone/config registry.gitlab.com/encircle360-oss/rclone-samba-server:latest
```

```
sudo mkdir -p /Volumes/smbshare
sudo mount_smbfs -N //guest@localhost/public /Volumes/smbshare
```

## Customization
You can customize many settings in the underlying samba-server. For example it's also possible to restrict access to shares to some created users.

You can find all customization options and environment variables [here](https://github.com/dperson/samba).
Please be aware that mostly **only the environment variables** work with this image.

## Contribute
Feel free to contribute to this open source project. Just fork, change and create a pull or merge request to this repository.

### Ideas & Improvements
* Make rclone mount configurable
* Multiple rcloune mounts and samba exports

## Credits
This is open source software by [encircle360](https://encircle360.com). Use on your own risk and for personal use. If you need support or consultancy just contact us.
